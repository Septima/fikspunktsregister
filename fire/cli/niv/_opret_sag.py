import os
import os.path
import getpass

import click
import pandas as pd
import sys

from fire import uuid
import fire.cli

from fire.cli.niv import (
    ARKDEF_FILOVERSIGT,
    ARKDEF_NYETABLEREDE_PUNKTER,
    ARKDEF_SAG,
    niv,
    skriv_ark,
    bekræft,
)

from fire.api.model import (
    Sag,
    Sagsinfo,
)


@niv.command()
@fire.cli.default_options()
@click.argument(
    "projektnavn",
    nargs=1,
    type=str,
)
@click.argument(
    "beskrivelse",
    nargs=-1,
    type=str,
)
@click.option(
    "--sagsbehandler",
    default=getpass.getuser(),
    type=str,
    help="Angiv andet brugernavn end den aktuelt indloggede",
)
def opret_sag(projektnavn: str, beskrivelse: str, sagsbehandler: str, **kwargs) -> None:
    """Registrer ny sag i databasen"""

    if os.path.isfile(f"{projektnavn}.xlsx"):
        fire.cli.print(
            f"Filen '{projektnavn}.xlsx' eksisterer - sagen er allerede oprettet"
        )
        sys.exit(1)

    beskrivelse = " ".join(beskrivelse)

    sag = {
        "Dato": pd.Timestamp.now(),
        "Hvem": sagsbehandler,
        "Hændelse": "sagsoprettelse",
        "Tekst": f"{projektnavn}: {beskrivelse}",
        "uuid": uuid(),
    }
    sagsgang = pd.DataFrame([sag], columns=tuple(ARKDEF_SAG))

    fire.cli.print(f"Sags/projekt-navn: {projektnavn}  ({sag['uuid']})")
    fire.cli.print(f"Sagsbehandler:     {sagsbehandler}")
    fire.cli.print(f"Beskrivelse:       {beskrivelse}")
    sagsinfo = Sagsinfo(aktiv="true", behandler=sagsbehandler, beskrivelse=beskrivelse)
    fire.cli.firedb.indset_sag(Sag(id=sag["uuid"], sagsinfos=[sagsinfo]), commit=False)
    try:
        fire.cli.firedb.session.flush()
    except Exception as ex:
        fire.cli.firedb.session.rollback()
        fire.cli.print(
            f"Der opstod en fejl - sag {sag.id} for '{projektnavn}' IKKE oprettet"
        )
        return
    else:
        spørgsmål = click.style(
            f"Opretter ny sag i {fire.cli.firedb.db}-databasen - er du sikker? ",
            bg="red",
            fg="white",
        )
        if bekræft(spørgsmål):
            fire.cli.firedb.session.commit()
            fire.cli.print(f"Sag '{projektnavn}' oprettet")
        else:
            fire.cli.firedb.session.rollback()
            fire.cli.print("Opretter IKKE sag")
            # Ved demonstration af systemet er det nyttigt at kunne oprette
            # et sagsregneark, uden at oprette en tilhørende sag
            if not bekræft("Opret sagsregneark alligevel?", gentag=False):
                return

    fire.cli.print(f"Skriver sagsregneark '{projektnavn}.xlsx'")

    # Dummyopsætninger til sagsregnearkets sider
    forside = pd.DataFrame()
    nyetablerede = pd.DataFrame(columns=tuple(ARKDEF_NYETABLEREDE_PUNKTER)).astype(
        ARKDEF_NYETABLEREDE_PUNKTER
    )
    notater = pd.DataFrame([{"Dato": pd.Timestamp.now(), "Hvem": "", "Tekst": ""}])
    filoversigt = pd.DataFrame(columns=tuple(ARKDEF_FILOVERSIGT))
    param = pd.DataFrame(
        columns=["Navn", "Værdi"],
        data=[("Version", fire.__version__), ("Database", fire.cli.firedb.db)],
    )

    resultater = {
        "Projektforside": forside,
        "Sagsgang": sagsgang,
        "Nyetablerede punkter": nyetablerede,
        "Notater": notater,
        "Filoversigt": filoversigt,
        "Parametre": param,
    }

    if skriv_ark(projektnavn, resultater):
        # os.startfile() er kun tilgængelig på Windows
        if "startfile" in dir(os):
            fire.cli.print("Færdig! - åbner regneark for check.")
            os.startfile(f"{projektnavn}.xlsx")
