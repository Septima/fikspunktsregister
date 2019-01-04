import uuid
from sqlalchemy import create_engine, func, event, and_, inspect
from sqlalchemy.orm import sessionmaker, aliased
from fireapi.model import (
    RegisteringTidObjekt,
    Sag,
    Punkt,
    GeometriObjekt,
    Observation,
    Bbox,
    Sagsevent,
    Beregning,
    Koordinat,
    Geometry,
)
from typing import List, Optional, Union
from datetime import datetime


class FireDb(object):
    def __init__(self, connectionstring, debug=False):
        """

        Parameters
        ----------
        connectionstring : str
            Connection string for the oracle database where the FIRE database resides.
            Of the general form 'user:pass@host:port/dbname[?key=value&key=value...]'
        debug: bool
            if True, the SQLALchemy Engine will log all statements as well as a repr() of their parameter lists to the
            engines logger, which defaults to sys.stdout
        """
        self.dialect = "oracle+cx_oracle"
        self.connectionstring = connectionstring
        self.engine = create_engine(
            f"{self.dialect}://{self.connectionstring}",
            connect_args={"encoding": "UTF-8", "nencoding": "UTF-8"},
            echo=debug,
        )
        self.sessionmaker = sessionmaker(bind=self.engine)
        self.session = self.sessionmaker(autoflush=False)

        @event.listens_for(self.sessionmaker, "before_flush")
        def listener(thissession, flush_context, instances):
            for obj in thissession.deleted:
                if isinstance(obj, RegisteringTidObjekt):
                    obj._registreringtil = func.sysdate()
                    thissession.add(obj)

    def hent_punkt(self, id: str) -> Punkt:
        p = aliased(Punkt)
        return (
            self.session.query(p).filter(p.id == id, p._registreringtil == None).one()
        )

    def hent_geometri_objekt(self, punktid: str) -> GeometriObjekt:
        go = aliased(GeometriObjekt)
        return (
            self.session.query(go)
            .filter(go.punktid == punktid, go._registreringtil == None)
            .one()
        )

    def hent_alle_punkter(self) -> List[Punkt]:
        return self.session.query(Punkt).all()

    def hent_sag(self, id: str) -> Sag:
        return self.session.query(Sag).filter(Sag.id == id).one()

    def hent_alle_sager(self) -> List[Sag]:
        return self.session.query(Sag).all()

    def soeg_geometriobjekt(self, bbox) -> List[GeometriObjekt]:
        if not isinstance(bbox, Bbox):
            bbox = Bbox(bbox)
        return (
            self.session.query(GeometriObjekt)
            .filter(func.sdo_filter(GeometriObjekt.geometri, bbox) == "TRUE")
            .all()
        )

    def hent_observationer(self, objectids: List[int]) -> List[Observation]:
        return (
            self.session.query(Observation)
            .filter(Observation.objectid.in_(objectids))
            .all()
        )

    def hent_observationer_naer_opstillingspunkt(
        self,
        punkt: Punkt,
        afstand: float,
        tidfra: Optional[datetime] = None,
        tidtil: Optional[datetime] = None,
    ) -> List[Observation]:
        g1 = aliased(GeometriObjekt)
        g2 = aliased(GeometriObjekt)
        return (
            self.session.query(Observation)
            .join(g1, Observation.opstillingspunktid == g1.punktid)
            .join(g2, g2.punktid == punkt.id)
            .filter(
                self._filter_observationer(
                    g1.geometri, g2.geometri, afstand, tidfra, tidtil
                )
            )
            .all()
        )

    def hent_observationer_naer_geometri(
        self,
        geometri: Geometry,
        afstand: float,
        tidfra: Optional[datetime] = None,
        tidtil: Optional[datetime] = None,
    ) -> List[Observation]:
        """
        Parameters
        ----------
        geometri
            Either a WKT string or a Geometry instance which will be used as
            filter to identify the set of spatial objects that are within some
            specified distance of the given object.
        """
        g = aliased(GeometriObjekt)
        return (
            self.session.query(Observation)
            .join(
                g,
                g.punktid == Observation.opstillingspunktid
                or g.punktid == Observation.sigtepunktid,
            )
            .filter(
                self._filter_observationer(
                    g.geometri, geometri, afstand, tidfra, tidtil
                )
            )
            .all()
        )

    def indset_sag(self, sag: Sag):
        if not self._is_new_object(sag):
            raise Exception(f"Cannot re-add already persistent sag: {sag}")
        if len(sag.sagsinfos) < 1:
            raise Exception("At least one sagsinfo must be added to the sag")
        if sag.sagsinfos[-1].aktiv != "true":
            raise Exception("Last sagsinfo should have aktiv = 'true'")
        self.session.add(sag)
        self.session.commit()

    def indset_punkt(self, sag: Sag, punkt: Punkt):
        if not self._is_new_object(punkt):
            raise Exception(f"Cannot re-add already persistent punkt: {punkt}")
        if len(punkt.geometriobjekter) != 1:
            raise Exception("A single geometriobjekt must be added to the punkt")
        sagsevent = Sagsevent(id=str(uuid.uuid4()), sag=sag, event="punkt_oprettet")
        self.session.add(sagsevent)
        punkt.sagsevent = sagsevent
        for geometriobjekt in punkt.geometriobjekter:
            geometriobjekt.sagsevent = sagsevent
        self.session.add(punkt)
        self.session.commit()

    def indset_observation(self, sag: Sag, observation: Observation):
        if not self._is_new_object(observation):
            raise Exception(
                f"Cannot re-add already persistent observation: {observation}"
            )
        sagsevent = Sagsevent(id=str(uuid.uuid4()), sag=sag, event="observation_indsat")
        self.session.add(sagsevent)
        observation.sagsevent = sagsevent
        self.session.add(observation)
        self.session.commit()

    def indset_beregning(self, sag: Sag, beregning: Beregning):
        if not self._is_new_object(beregning):
            raise Exception(f"Cannot re-add already persistent beregning: {beregning}")
        sagsevent = Sagsevent(id=str(uuid.uuid4()), sag=sag, event="koordinat_beregnet")
        self.session.add(sagsevent)
        beregning.sagsevent = sagsevent
        for koordinat in beregning.koordinater:
            if not self._is_new_object(koordinat):
                raise Exception(
                    f"Added beregning cannot refer to existing koordinat: {koordinat}"
                )
            self._close_existing_koordinat(koordinat)
            koordinat.sagsevent = sagsevent
        self.session.add(beregning)
        self.session.commit()

    # Private methods

    def _filter_observationer(
        self,
        g1,
        g2,
        distance: float,
        from_date: Optional[datetime] = None,
        to_date: Optional[datetime] = None,
    ):
        exps = [
            func.sdo_within_distance(
                g1, g2, "distance=" + str(distance) + " unit=meter"
            )
            == "TRUE"
        ]
        if from_date:
            exps.append(Observation.observationstidspunkt >= from_date)
        if to_date:
            exps.append(Observation.observationstidspunkt <= to_date)
        filter = and_(*exps)
        return filter

    def _is_new_object(self, obj):
        """Check that the object has not been persisted to the database (= is 'new').

        Parameters
        ----------
        obj: object
            Object to check.

        Returns
        -------
        bool
            True if object has not been persisted. False otherwise
        """
        # here are the five states:
        # state.transient   # !session & !identity_key
        # state.pending     # session & !identity_key
        # state.persistent  # session &  identity_key
        # state.detached    # !session &  identity_key
        # state.deleted     # session & identity_key, flushed but not committed. Commit moves it to detached state
        insp = inspect(obj)
        return not (insp.persistent or insp.detached)

    def _close_existing_koordinat(self, newkoordinat):
        """Checks if a previous version of the new koordinat exists. If it exists the existing koordinat is closed.

        Parameters
        ----------
        newkoordinat: koordinat
            New koordinat object to insert into database. The koordinat must have its punkt-reference set before calling
            this method.
        """
        if not self._is_new_object(newkoordinat):
            return

        if not newkoordinat.punkt:
            raise Exception("koordinat must have a reference to its punkt")

        # Find existing koordinat with the same properties
        # According to constraint "KOOR_UNIQ_001" koordinates must be unique with regard to
        # SRID, PUNKTID, REGISTRERINGTIL
        # Note that new koordinat MAY have int srid
        existing_koordinater = list(
            [
                k
                for k in newkoordinat.punkt.koordinater
                if str(k.srid) == str(newkoordinat.srid)
                and k.registreringtil is None
                and k is not newkoordinat
            ]
        )
        assert (
            len(existing_koordinater) <= 1
        ), f"Punkt has more than one koordinat with srid={newkoordinat.srid} and registeringtil=None"

        if existing_koordinater:
            # self.session.expunge(newkoordinat)
            # Close the existing version (if any)
            for k in existing_koordinater:
                k._registreringtil = func.sysdate()
            # self.session.add(newkoordinat)


#
