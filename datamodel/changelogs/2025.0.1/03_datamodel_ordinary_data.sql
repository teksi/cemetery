-- Datamodel initialization script for the TEKSI cemetery database

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
   fk_urn_kind integer,
   exumation_date date,
   exumation_place character varying(50),
   remark text,
   child boolean,
   quality double precision,
   orientation double precision,
   fk_unit uuid,
   the_geom geometry(Point,{SRID})
);

CREATE TABLE IF NOT EXISTS tce_od.unit
(
   id uuid DEFAULT public.uuid_generate_v1() NOT NULL PRIMARY KEY,
   identifier character varying(10),
   begin_date date,
   end_date date,
   fk_company uuid,
   fk_sector uuid,
   fk_cemetery integer,
   fk_unit_size integer,
   fk_unit_kind integer,
   fk_contact_person uuid,
   remark text,
   disused boolean,
   disused_date date,
   fk_control integer,
   the_geom geometry(Polygon,{SRID})
);

CREATE TABLE IF NOT EXISTS tce_od.contract
(
   id uuid DEFAULT public.uuid_generate_v1() NOT NULL PRIMARY KEY,
   fk_kind integer,
   begin_date date,
   end_date date,
   fk_contract_person uuid,
   remark text
);

CREATE TABLE IF NOT EXISTS tce_od.sector
(
   id uuid DEFAULT public.uuid_generate_v1() NOT NULL PRIMARY KEY,
   ident_short character varying(10),
   identifier character varying(100),
   remark text,
   the_geom geometry(Polygon,{SRID})
);

CREATE TABLE IF NOT EXISTS tce_od.furniture
(
   id uuid DEFAULT public.uuid_generate_v1() NOT NULL PRIMARY KEY,
   fk_furniture_kind integer,
   remark text,
   the_geom geometry(Point,{SRID})
);

CREATE TABLE IF NOT EXISTS tce_od.vegetation
(
   id uuid DEFAULT public.uuid_generate_v1() NOT NULL PRIMARY KEY,
   fk_vegetation_kind integer,
   remark text,
   the_geom geometry(Polygon,{SRID})
);

CREATE TABLE IF NOT EXISTS tce_od.organisation
(
   id uuid DEFAULT public.uuid_generate_v1() NOT NULL PRIMARY KEY,
   identifier integer,
   remark text
);

CREATE TABLE IF NOT EXISTS tce_od.contact_person
(
   id uuid DEFAULT public.uuid_generate_v1() NOT NULL PRIMARY KEY,
   person_kind integer,
   last_name character varying(50),
   first_name character varying(50),
   address character varying(50),
   city character varying(50),
   postal_code character varying(10),
   phone character varying(20),
   email character varying(255),
   remark text
);
