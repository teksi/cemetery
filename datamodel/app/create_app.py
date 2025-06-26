#!/usr/bin/env python3

from argparse import ArgumentParser, BooleanOptionalAction
from pathlib import Path

import psycopg
from pirogue import MultipleInheritance, SimpleJoins, SingleInheritance
from pum import HookBase
# from triggers.set_defaults_and_triggers import set_defaults_and_triggers
# from view.vw_tce_additional_ws import vw_tce_additional_ws
# from view.vw_tce_channel import vw_tce_channel
# from view.vw_tce_damage_channel import vw_tce_damage_channel
# from view.vw_tce_infiltration_installation import vw_tce_infiltration_installation
# from view.vw_tce_measurement_series import vw_tce_measurement_series
# from view.vw_tce_reach import vw_tce_reach
from yaml import safe_load


class Hook(HookBase):
    def run_hook(
        self,
        connection: psycopg.Connection,
        # SRID: int = 2056,
    ):
        """
        Creates the schema tce_app for TEKSI Wastewater & GEP
        :param SRID: the EPSG code for geometry columns
        """
        cwd = Path(__file__).parent.resolve()

        # variables = {
        #    "SRID": psycopg.sql.SQL(f"{SRID}")
        #}  # when dropping psycopg2 support, we can use the SRID var directly

        self.execute("CREATE SCHEMA tce_app;")
        self.execute(cwd / "functions/geometry_functions.sql")

        # self.execute(cwd / "view/vw_dictionary_value_list.sql")

        # defaults = {"view_schema": "tce_app"}

        # SingleInheritances = {
        #     # structure parts
        #     "access_aid": "structure_part",
        # }

        # default values
        # self.execute(cwd / "view/set_default_value_for_views.sql")

        # Audit
        # self.execute(cwd / "audit/audit.sql")

        # Roles
        self.execute(cwd / "tce_app_roles.sql")


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("-p", "--pg_service", help="postgres service")
    parser.add_argument(
        "-s", "--srid", help="SRID EPSG code, defaults to 2056", type=int, default=2056
    )
    parser.add_argument(
        "-d",
        "--drop-schema",
        help="Drops cascaded any existing tce_app schema",
        default=False,
        action=BooleanOptionalAction,
    )
    args = parser.parse_args()

    with psycopg.connect(service=args.pg_service) as connection:
        if args.drop_schema:
            connection.execute("DROP SCHEMA IF EXISTS tce_app CASCADE;")
        hook = Hook()
        hook.run_hook(
            connection=connection,
            SRID=args.srid,
         )
