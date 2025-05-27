-- Datamodel initialization script for the TEKSI cemetery database

BEGIN;
CREATE TABLE IF NOT EXISTS tce_od.deceased
(
   id uuid DEFAULT public.uuid_generate_v1() NOT NULL PRIMARY KEY,
   last_name character varying(50),
   first_name character varying(50),
   address character varying(50),
   city character varying(50),
   postal_code character varying(10),
   birth_date date,
   death_date date,
   death_place character varying(50),
   burial_date date,
   burial_place character varying(50),
   flag_main boolean,
   flag_ashes boolean,
   incineration_date date,
   incineration_place character varying(50),
   fk_urn_type integer,
   exumation_date date,
   exumation_place character varying(50),
   remark text,
   child boolean,
   quality double precision,
   orientation double precision,
   fk_unit integer,
   the_geom geometry(Point,2056)
)

COMMIT;