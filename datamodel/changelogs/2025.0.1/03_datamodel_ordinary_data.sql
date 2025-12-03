-- Datamodel initialization script for the TEKSI cemetery database

CREATE TABLE IF NOT EXISTS tce_od.deceased
(
   id uuid DEFAULT public.uuid_generate_v1() NOT NULL PRIMARY KEY,
   ahv_number character varying(16),
   fk_civility integer,
   first_name text,
   second_first_name text,
   last_name text,
   address character text,
   city text,
   postal_code character varying(10),
   birth_date date,
   death_date date,
   death_place text,
   burial_date date,
   burial_place text,
   flag_main boolean,
   flag_ashes boolean,
   incineration_date date,
   incineration_place text,
   fk_urn_kind integer,
   exumation_date date,
   exumation_place text,
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
   excavation_date date,
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
   approval_date date,
   valid boolean,
   invoiced boolean,
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

CREATE TABLE IF NOT EXISTS tce_od.person
(
   id uuid DEFAULT public.uuid_generate_v1() NOT NULL PRIMARY KEY,
   kind integer,
   fk_civility integer,
   first_name text,
   last_name text,
   address text,
   city text,
   postal_code character varying(10),
   phone character varying(20),
   email character varying(255),
   remark text
);
