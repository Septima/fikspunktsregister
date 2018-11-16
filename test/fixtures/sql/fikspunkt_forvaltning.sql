CREATE TABLE BEREGNING (

   OBJECTID INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1 ORDER NOCACHE) PRIMARY KEY,
   REGISTRERINGFRA TIMESTAMP WITH TIME ZONE NOT NULL,
   REGISTRERINGTIL TIMESTAMP WITH TIME ZONE,
   SAGSEVENTID VARCHAR2(4000) NOT NULL
);

CREATE TABLE BEREGNING_KOORDINAT (

   BEREGNINGOBJECTID INTEGER NOT NULL,
   KOORDINATOBJECTID INTEGER NOT NULL,
   PRIMARY KEY (BEREGNINGOBJECTID, KOORDINATOBJECTID)
);

CREATE TABLE BEREGNING_PUNKT (

   BEREGNINGOBJECTID INTEGER NOT NULL,
   OBSERVATIONOBJECTID INTEGER NOT NULL,
   PRIMARY KEY (BEREGNINGOBJECTID, OBSERVATIONOBJECTID)
);

CREATE TABLE EVENTYPE (

   OBJECTID INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1 ORDER NOCACHE) PRIMARY KEY,
   BESKRIVELSE VARCHAR2(4000) NOT NULL,
   EVENT VARCHAR2(4000) NOT NULL
);

CREATE TABLE GEOMETRIOBJEKT (

   OBJECTID INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1 ORDER NOCACHE) PRIMARY KEY,
   REGISTRERINGFRA TIMESTAMP WITH TIME ZONE NOT NULL,
   REGISTRERINGTIL TIMESTAMP WITH TIME ZONE,
   GEOMETRI SDO_GEOMETRY NOT NULL,
   SAGSEVENTID VARCHAR2(4000) NOT NULL,
   PUNKTID VARCHAR2(4000) NOT NULL
);

CREATE TABLE INFOTYPENAMESPACE (

   OBJECTID INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1 ORDER NOCACHE) PRIMARY KEY,
   BESKRIVELSE VARCHAR2(4000) NOT NULL,
   NAMESPACE VARCHAR2(4000) NOT NULL
);

CREATE TABLE KOORDINAT (

   OBJECTID INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1 ORDER NOCACHE) PRIMARY KEY,
   REGISTRERINGFRA TIMESTAMP WITH TIME ZONE NOT NULL,
   REGISTRERINGTIL TIMESTAMP WITH TIME ZONE,
   SRID VARCHAR2(100) NOT NULL,
   SX NUMBER,
   SY NUMBER,
   SZ NUMBER,
   T TIMESTAMP WITH TIME ZONE,
   TRANSFORMERET VARCHAR2(5) NOT NULL,
   X NUMBER,
   Y NUMBER,
   Z NUMBER,
   SAGSEVENTID VARCHAR2(4000) NOT NULL,
   PUNKTID VARCHAR2(4000) NOT NULL
);

CREATE TABLE OBSERVATION (

   OBJECTID INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1 ORDER NOCACHE) PRIMARY KEY,
   REGISTRERINGFRA TIMESTAMP WITH TIME ZONE NOT NULL,
   REGISTRERINGTIL TIMESTAMP WITH TIME ZONE,
   ANTAL INTEGER NOT NULL,
   GRUPPE INTEGER,
   OBSERVATIONSTYPE VARCHAR2(4000) NOT NULL,
   VALUE1 NUMBER NOT NULL,
   VALUE2 NUMBER,
   VALUE3 NUMBER,
   VALUE4 NUMBER,
   VALUE5 NUMBER,
   VALUE6 NUMBER,
   VALUE7 NUMBER,
   VALUE8 NUMBER,
   VALUE9 NUMBER,
   VALUE10 NUMBER,
   VALUE11 NUMBER,
   VALUE12 NUMBER,
   VALUE13 NUMBER,
   VALUE14 NUMBER,
   VALUE15 NUMBER,
   SAGSEVENTID VARCHAR2(4000) NOT NULL,
   OPSTILLINGSPUNKTID VARCHAR2(4000) NOT NULL,
   SIGTEPUNKT1ID INTEGER,
   SIGTEPUNKT2ID INTEGER
);

CREATE TABLE OBSERVATIONTYPE (

   OBJECTID INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1 ORDER NOCACHE) PRIMARY KEY,
   BESKRIVELSE VARCHAR2(4000) NOT NULL,
   OBSERVATIONSTYPE VARCHAR2(4000) NOT NULL,
   SIGTEPUNKT1 VARCHAR2(5) NOT NULL,
   SIGTEPUNKT2 VARCHAR2(5) NOT NULL,
   VALUE1 VARCHAR2(4000) NOT NULL,
   VALUE2 VARCHAR2(4000),
   VALUE3 VARCHAR2(4000),
   VALUE4 VARCHAR2(4000),
   VALUE5 VARCHAR2(4000),
   VALUE6 VARCHAR2(4000),
   VALUE7 VARCHAR2(4000),
   VALUE8 VARCHAR2(4000),
   VALUE9 VARCHAR2(4000),
   VALUE10 VARCHAR2(4000),
   VALUE11 VARCHAR2(4000),
   VALUE12 VARCHAR2(4000),
   VALUE13 VARCHAR2(4000),
   VALUE14 VARCHAR2(4000),
   VALUE15 VARCHAR2(4000)
);

CREATE TABLE OBSERVATIONTYPENAMESPACE (

   OBJECTID INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1 ORDER NOCACHE) PRIMARY KEY,
   BESKRIVELSE VARCHAR2(4000) NOT NULL,
   NAMESPACE VARCHAR2(4000) NOT NULL
);

CREATE TABLE PUNKT (

   OBJECTID INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1 ORDER NOCACHE) PRIMARY KEY,
   REGISTRERINGFRA TIMESTAMP WITH TIME ZONE NOT NULL,
   REGISTRERINGTIL TIMESTAMP WITH TIME ZONE,
   ID VARCHAR2(36) NOT NULL,
   SAGSEVENTID VARCHAR2(4000) NOT NULL
);

CREATE TABLE PUNKTINFO (

   OBJECTID INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1 ORDER NOCACHE) PRIMARY KEY,
   REGISTRERINGFRA TIMESTAMP WITH TIME ZONE NOT NULL,
   REGISTRERINGTIL TIMESTAMP WITH TIME ZONE,
   INFOTYPE VARCHAR2(4000) NOT NULL,
   REELTAL NUMBER,
   TEKST VARCHAR2(4000),
   SAGSEVENTID VARCHAR2(4000) NOT NULL,
   PUNKTID VARCHAR2(4000) NOT NULL
);

CREATE TABLE PUNKTINFOTYPE (

   OBJECTID INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1 ORDER NOCACHE) PRIMARY KEY,
   ANVENDELSE VARCHAR2(9) NOT NULL,
   BESKRIVELSE VARCHAR2(4000) NOT NULL,
   INFOTYPE VARCHAR2(4000) NOT NULL
);

CREATE TABLE SAG (

   OBJECTID INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1 ORDER NOCACHE) PRIMARY KEY,
   ID VARCHAR2(36) NOT NULL,
   REGISTRERINGFRA TIMESTAMP WITH TIME ZONE NOT NULL,
   REGISTRERINGTIL TIMESTAMP WITH TIME ZONE,
   SAGSTYPE VARCHAR2(21) NOT NULL,
   JOURNALNUMMER VARCHAR2(4000),
   BEHANDLER VARCHAR2(4000) NOT NULL,
   BESKRIVELSE VARCHAR2(4000)
);

CREATE TABLE SAGSEVENT (

   OBJECTID INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1 ORDER NOCACHE) PRIMARY KEY,
   ID VARCHAR2(36) NOT NULL,
   REGISTRERINGFRA TIMESTAMP WITH TIME ZONE NOT NULL,
   REGISTRERINGTIL TIMESTAMP WITH TIME ZONE,
   EVENT VARCHAR2(4000) NOT NULL,
   BESKRIVELSE VARCHAR2(4000),
   SAGID VARCHAR2(4000) NOT NULL
);

CREATE TABLE SAGSEVENT_MATERIALE (

   SAGSEVENTOBJECTID INTEGER NOT NULL,
   MATERIALE VARCHAR2(4000) NOT NULL,
   PRIMARY KEY (SAGSEVENTOBJECTID, MATERIALE)
);

CREATE TABLE SAGSEVENT_RAPPORTHTML (

   SAGSEVENTOBJECTID INTEGER NOT NULL,
   RAPPORTHTML VARCHAR2(4000) NOT NULL,
   PRIMARY KEY (SAGSEVENTOBJECTID, RAPPORTHTML)
);

CREATE TABLE SAGSTYPE (

   OBJECTID INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1 ORDER NOCACHE) PRIMARY KEY,
   BESKRIVELSE VARCHAR2(4000) NOT NULL,
   SAGSTYPE VARCHAR2(4000) NOT NULL
);

CREATE TABLE SRIDNAMESPACE (

   OBJECTID INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1 ORDER NOCACHE) PRIMARY KEY,
   BESKRIVELSE VARCHAR2(4000) NOT NULL,
   NAMESPACE VARCHAR2(4000) NOT NULL
);

CREATE TABLE SRIDTYPE (

   OBJECTID INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1 ORDER NOCACHE) PRIMARY KEY,
   BESKRIVELSE VARCHAR2(4000) NOT NULL,
   SRID VARCHAR2(4000) NOT NULL
);


ALTER TABLE KOORDINAT ADD CONSTRAINT CK_KOORDINAT_TRANSFORMER248 CHECK (TRANSFORMERET IN ('true', 'false'));
ALTER TABLE OBSERVATIONTYPE ADD CONSTRAINT CK_OBSERVATION_SIGTEPUNKT1128 CHECK (SIGTEPUNKT1 IN ('true', 'false'));
ALTER TABLE OBSERVATIONTYPE ADD CONSTRAINT CK_OBSERVATION_SIGTEPUNKT2100 CHECK (SIGTEPUNKT2 IN ('true', 'false'));
ALTER TABLE PUNKTINFOTYPE ADD CONSTRAINT CK_PUNKTINFOTY_ANVENDELSE138 CHECK (ANVENDELSE IN ('FLAG', 'TAL', 'TEKST'));

INSERT INTO USER_SDO_GEOM_METADATA (TABLE_NAME, COLUMN_NAME, DIMINFO, SRID) VALUES ('GEOMETRIOBJEKT', 'GEOMETRI', MDSYS.SDO_DIM_ARRAY(MDSYS.SDO_DIM_ELEMENT('Longitude', -180.0000, 180.0000, 0.005), MDSYS.SDO_DIM_ELEMENT('Latitude', -90.0000, 90.0000, 0.005)), 4326);

CREATE INDEX IDX_GEOMETRIOBJEKT_GEOMETRI ON GEOMETRIOBJEKT (GEOMETRI) INDEXTYPE IS MDSYS.SPATIAL_INDEX PARAMETERS('layer_gtype=point');

COMMENT ON TABLE BEREGNING IS 'Sammenknytter beregnede koordinater med de anvendte observationer';
COMMENT ON COLUMN BEREGNING.REGISTRERINGFRA IS 'Tidspunktet hvor registreringen er foretaget.';
COMMENT ON COLUMN BEREGNING.REGISTRERINGTIL IS 'Tidspunktet hvor en ny registrering er foretaget på objektet, og hvor denne version således ikke længere er den seneste.';
COMMENT ON COLUMN BEREGNING.SAGSEVENTID IS 'Angivelse af den hændelse der har ændret et fikspunktsobjekt.';
COMMENT ON TABLE GEOMETRIOBJEKT IS 'SDO placeringskoordinat';
COMMENT ON COLUMN GEOMETRIOBJEKT.GEOMETRI IS 'Placeringskoordinat til brug for visning i f.eks et GIS sysstem.';
COMMENT ON COLUMN GEOMETRIOBJEKT.REGISTRERINGFRA IS 'Tidspunktet hvor registreringen er foretaget.';
COMMENT ON COLUMN GEOMETRIOBJEKT.REGISTRERINGTIL IS 'Tidspunktet hvor en ny registrering er foretaget på objektet, og hvor denne version således ikke længere er den seneste.';
COMMENT ON COLUMN GEOMETRIOBJEKT.SAGSEVENTID IS 'Angivelse af den hændelse der har ændret et fikspunktsobjekt.';
COMMENT ON TABLE KOORDINAT IS 'Generisk 4D koordinat';
COMMENT ON COLUMN KOORDINAT.REGISTRERINGFRA IS 'Tidspunktet hvor registreringen er foretaget.';
COMMENT ON COLUMN KOORDINAT.REGISTRERINGTIL IS 'Tidspunktet hvor en ny registrering er foretaget på objektet, og hvor denne version således ikke længere er den seneste.';
COMMENT ON COLUMN KOORDINAT.SAGSEVENTID IS 'Angivelse af den hændelse der har ændret et fikspunktsobjekt.';
COMMENT ON COLUMN KOORDINAT.SRID IS 'Unik værdi til angivelse af et koordinatsystem.';
COMMENT ON COLUMN KOORDINAT.SX IS 'A posteriori spredning på førstekoordinaten.';
COMMENT ON COLUMN KOORDINAT.SY IS 'A posteriori spredning på andenkoordinaten.';
COMMENT ON COLUMN KOORDINAT.SZ IS 'A posteriori spredning på tredjekoordinaten.';
COMMENT ON COLUMN KOORDINAT.T IS 'Observationstidspunktet.';
COMMENT ON COLUMN KOORDINAT.TRANSFORMERET IS 'Angivelse om positionen er målt, eller transformeret fra et andet koordinatsystem';
COMMENT ON COLUMN KOORDINAT.X IS 'Førstekoordinat.';
COMMENT ON COLUMN KOORDINAT.Y IS 'Andenkoordinat.';
COMMENT ON COLUMN KOORDINAT.Z IS 'Tredjekoordinat.';
COMMENT ON TABLE OBSERVATION IS 'Generisk observationsobjekt';
COMMENT ON COLUMN OBSERVATION.OBSERVATIONSTYPE IS 'Kortnavn for observationstypen, fx dH';
COMMENT ON COLUMN OBSERVATION.REGISTRERINGFRA IS 'Tidspunktet hvor registreringen er foretaget.';
COMMENT ON COLUMN OBSERVATION.REGISTRERINGTIL IS 'Tidspunktet hvor en ny registrering er foretaget på objektet, og hvor denne version således ikke længere er den seneste.';
COMMENT ON COLUMN OBSERVATION.SAGSEVENTID IS 'Angivelse af den hændelse der har ændret et fikspunktsobjekt.';
COMMENT ON COLUMN OBSERVATION.VALUE1 IS 'Første observationselement.';
COMMENT ON COLUMN OBSERVATION.VALUE2 IS 'Første observationselement.';
COMMENT ON COLUMN OBSERVATION.VALUE3 IS 'Første observationselement.';
COMMENT ON TABLE OBSERVATIONTYPE IS 'Udfaldsrum for observationsobjekter';
COMMENT ON COLUMN OBSERVATIONTYPE.BESKRIVELSE IS 'Overordnet beskrivelse af denne observationstype.';
COMMENT ON COLUMN OBSERVATIONTYPE.OBSERVATIONSTYPE IS 'Kortnavn for observationstypen, fx dH';
COMMENT ON COLUMN OBSERVATIONTYPE.SIGTEPUNKT1 IS 'Indikator for om Sigtepunkt 1 anvendes for denne observationstype.';
COMMENT ON COLUMN OBSERVATIONTYPE.SIGTEPUNKT2 IS 'Indikator for om Sigtepunkt 2 anvendes for denne observationstype.';
COMMENT ON COLUMN OBSERVATIONTYPE.VALUE1 IS 'Beskrivelse af første observationselement.';
COMMENT ON COLUMN OBSERVATIONTYPE.VALUE2 IS 'Beskrivelse af første observationselement.';
COMMENT ON COLUMN OBSERVATIONTYPE.VALUE3 IS 'Beskrivelse af første observationselement.';
COMMENT ON TABLE PUNKT IS 'Abstrakt repræsentation af et fysisk punkt. Knytter alle punktinformationer sammen';
COMMENT ON COLUMN PUNKT.ID IS 'Persistent unik nøgle.';
COMMENT ON COLUMN PUNKT.REGISTRERINGFRA IS 'Tidspunktet hvor registreringen er foretaget.';
COMMENT ON COLUMN PUNKT.REGISTRERINGTIL IS 'Tidspunktet hvor en ny registrering er foretaget på objektet, og hvor denne version således ikke længere er den seneste.';
COMMENT ON COLUMN PUNKT.SAGSEVENTID IS 'Angivelse af den hændelse der har ændret et fikspunktsobjekt.';
COMMENT ON TABLE PUNKTINFO IS 'Generisk information om et punkt';
COMMENT ON COLUMN PUNKTINFO.INFOTYPE IS 'Arten af dette informationselement.';
COMMENT ON COLUMN PUNKTINFO.REELTAL IS 'Værdien for numeriske informationselementer';
COMMENT ON COLUMN PUNKTINFO.REGISTRERINGFRA IS 'Tidspunktet hvor registreringen er foretaget.';
COMMENT ON COLUMN PUNKTINFO.REGISTRERINGTIL IS 'Tidspunktet hvor en ny registrering er foretaget på objektet, og hvor denne version således ikke længere er den seneste.';
COMMENT ON COLUMN PUNKTINFO.SAGSEVENTID IS 'Angivelse af den hændelse der har ændret et fikspunktsobjekt.';
COMMENT ON COLUMN PUNKTINFO.TEKST IS 'Værdien for tekstinformationselementer';
COMMENT ON TABLE PUNKTINFOTYPE IS 'Udfaldsrum for punktinforobjekter';
COMMENT ON COLUMN PUNKTINFOTYPE.ANVENDELSE IS 'Er det reelTal, tekst, eller ingen af disse, der angiver værdien';
COMMENT ON COLUMN PUNKTINFOTYPE.BESKRIVELSE IS 'Beskrivelse af denne informationstypes art.';
COMMENT ON COLUMN PUNKTINFOTYPE.INFOTYPE IS 'Arten af dette informationselement';
COMMENT ON TABLE SAG IS 'Samling af administrativt relaterede sagshændelser';
COMMENT ON COLUMN SAG.BEHANDLER IS 'Angivelse af en sagsbehandler.';
COMMENT ON COLUMN SAG.BESKRIVELSE IS 'Kort beskrivelse af en fikspunktssag.';
COMMENT ON COLUMN SAG.ID IS 'Persistent unik nøgle.';
COMMENT ON COLUMN SAG.JOURNALNUMMER IS 'Sagsmappeidentifikation i opmålings- og beregningssagsregistret.';
COMMENT ON COLUMN SAG.REGISTRERINGFRA IS 'Tidspunktet hvor registreringen er foretaget.';
COMMENT ON COLUMN SAG.REGISTRERINGTIL IS 'Tidspunktet hvor en ny registrering er foretaget på objektet, og hvor denne version således ikke længere er den seneste.';
COMMENT ON COLUMN SAG.SAGSTYPE IS 'Inddeling af fikspunktsager ud fra opgavetype.';
COMMENT ON TABLE SAGSEVENT IS 'Udvikling i sag som kan, men ikke behøver, medføre opdateringer af fikspunktregisterobjekter';
COMMENT ON COLUMN SAGSEVENT.BESKRIVELSE IS 'Specifik beskrivelse af den aktuelle fremdrift.';
COMMENT ON COLUMN SAGSEVENT.EVENT IS 'Generisk beskrivelse af fremdriftens art.';
COMMENT ON COLUMN SAGSEVENT.ID IS 'Persistent unik nøgle.';
COMMENT ON COLUMN SAGSEVENT.REGISTRERINGFRA IS 'Tidspunktet hvor registreringen er foretaget.';
COMMENT ON COLUMN SAGSEVENT.REGISTRERINGTIL IS 'Tidspunktet hvor en ny registrering er foretaget på objektet, og hvor denne version således ikke længere er den seneste.';
COMMENT ON COLUMN SAGSEVENT.SAGID IS 'Udpegning af den sag i fikspunktsforvalningssystemet som en event er foretaget i.';
COMMENT ON COLUMN SAGSEVENT_MATERIALE.MATERIALE IS 'Generisk materiale tilknyttet sagsevent - typisk en filmappe URI.';
COMMENT ON COLUMN SAGSEVENT_RAPPORTHTML.RAPPORTHTML IS 'Generisk operatørlæsbart orienterende rapportmateriale.';
COMMENT ON TABLE SRIDTYPE IS 'Udfaldsrum for SRID-koordinatbeskrivelser';
COMMENT ON COLUMN SRIDTYPE.BESKRIVELSE IS 'Generel beskrivelse af systemet.';
COMMENT ON COLUMN SRIDTYPE.SRID IS 'Den egentlige referencesystemindikator.';
                                                                                                                                      
exit;                                                                                                                                     
