-- Datamodel initialization script for the TEKSI cemetery database

CREATE TABLE IF NOT EXISTS tce_od.deceased
(
   id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
   CONSTRAINT pkey_tce_od_deceased_id PRIMARY KEY (id)
);
COMMENT ON TABLE tce_od.deceased IS 'Dataset of deceased persons / Datensatz der Verstorbenen / Ensemble de données des personnes décédées';

ALTER TABLE tce_od.deceased ADD COLUMN ahv_number character varying(16);
ALTER TABLE tce_od.deceased ADD COLUMN fk_civility integer;
ALTER TABLE tce_od.deceased ADD COLUMN first_name text;
ALTER TABLE tce_od.deceased ADD COLUMN second_first_name text;
ALTER TABLE tce_od.deceased ADD COLUMN last_name text;
ALTER TABLE tce_od.deceased ADD COLUMN street_name text;
ALTER TABLE tce_od.deceased ADD COLUMN house_number character varying(10);
ALTER TABLE tce_od.deceased ADD COLUMN address_supplement text;
ALTER TABLE tce_od.deceased ADD COLUMN city text;
ALTER TABLE tce_od.deceased ADD COLUMN postal_code character varying(10);
ALTER TABLE tce_od.deceased ADD COLUMN birth_date date;
ALTER TABLE tce_od.deceased ADD COLUMN birth_place text;
ALTER TABLE tce_od.deceased ADD COLUMN fk_birth_country integer;
ALTER TABLE tce_od.deceased ADD COLUMN death_date date;
ALTER TABLE tce_od.deceased ADD COLUMN death_place text;
ALTER TABLE tce_od.deceased ADD COLUMN fk_death_country integer;
ALTER TABLE tce_od.deceased ADD COLUMN burial_date date;
ALTER TABLE tce_od.deceased ADD COLUMN burial_place text;
ALTER TABLE tce_od.deceased ADD COLUMN fk_burial_country integer;
ALTER TABLE tce_od.deceased ADD COLUMN municipality_disposal_date date;
ALTER TABLE tce_od.deceased ADD COLUMN municipality_approval boolean;
ALTER TABLE tce_od.deceased ADD COLUMN incineration_date date;
ALTER TABLE tce_od.deceased ADD COLUMN incineration_place text;
ALTER TABLE tce_od.deceased ADD COLUMN fk_urn_kind integer;
ALTER TABLE tce_od.deceased ADD COLUMN exumation_date date;
ALTER TABLE tce_od.deceased ADD COLUMN exumation_place text;
ALTER TABLE tce_od.deceased ADD COLUMN remark text;
ALTER TABLE tce_od.deceased ADD COLUMN child boolean;
ALTER TABLE tce_od.deceased ADD COLUMN quality double precision;
ALTER TABLE tce_od.deceased ADD COLUMN depth double precision;
ALTER TABLE tce_od.deceased ADD COLUMN orientation double precision;
ALTER TABLE tce_od.deceased ADD COLUMN fk_unit uuid;
ALTER TABLE tce_od.deceased ADD COLUMN the_geom geometry(Point,{SRID});

CREATE TABLE IF NOT EXISTS tce_od.unit
(
   id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
   CONSTRAINT pkey_tce_od_unit_id PRIMARY KEY (id)
);
COMMENT ON TABLE tce_od.unit IS 'Dataset of burial units / Datensatz der Grabstellen / Ensemble de données des emplacements de sépulture';

CREATE SEQUENCE IF NOT EXISTS tce_od.seq_unit_identifier;

ALTER TABLE tce_od.unit ADD COLUMN identifier text DEFAULT nextval('tce_od.seq_unit_identifier'::regclass) UNIQUE;
ALTER TABLE tce_od.unit ADD COLUMN excavation_date date;
ALTER TABLE tce_od.unit ADD COLUMN begin_date date;
ALTER TABLE tce_od.unit ADD COLUMN end_date date;
ALTER TABLE tce_od.unit ADD COLUMN fk_company uuid;
ALTER TABLE tce_od.unit ADD COLUMN fk_sector uuid;
ALTER TABLE tce_od.unit ADD COLUMN fk_cemetery uuid;
ALTER TABLE tce_od.unit ADD COLUMN fk_size integer;
ALTER TABLE tce_od.unit ADD COLUMN fk_kind integer;
ALTER TABLE tce_od.unit ADD COLUMN fk_urn_material integer;
ALTER TABLE tce_od.unit ADD COLUMN fk_urn_shape integer;
ALTER TABLE tce_od.unit ADD COLUMN fk_contact_person uuid;
ALTER TABLE tce_od.unit ADD COLUMN remark text;
ALTER TABLE tce_od.unit ADD COLUMN disused boolean;
ALTER TABLE tce_od.unit ADD COLUMN disused_date date;
ALTER TABLE tce_od.unit ADD COLUMN fk_control integer;
ALTER TABLE tce_od.unit ADD COLUMN the_geom geometry(Polygon,{SRID});


CREATE TABLE IF NOT EXISTS tce_od.contract
(
   id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
   CONSTRAINT pkey_tce_od_contract_id PRIMARY KEY (id)
);
COMMENT ON TABLE tce_od.contract IS 'Dataset of contracts / Datensatz der Verträge / Ensemble de données des contrats';

ALTER TABLE tce_od.contract ADD COLUMN fk_kind integer;
ALTER TABLE tce_od.contract ADD COLUMN identifier text;
ALTER TABLE tce_od.contract ADD COLUMN begin_date date;
ALTER TABLE tce_od.contract ADD COLUMN end_date date;
ALTER TABLE tce_od.contract ADD COLUMN approval_date date;
ALTER TABLE tce_od.contract ADD COLUMN valid boolean;
ALTER TABLE tce_od.contract ADD COLUMN invoiced boolean;
ALTER TABLE tce_od.contract ADD COLUMN fk_contract_person uuid;
ALTER TABLE tce_od.contract ADD COLUMN fk_unit uuid;
ALTER TABLE tce_od.contract ADD COLUMN remark text;


CREATE TABLE IF NOT EXISTS tce_od.sector
(
   id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
   CONSTRAINT pkey_tce_od_sector_id PRIMARY KEY (id)
);
COMMENT ON TABLE tce_od.sector IS 'Dataset of cemetery sectors / Datensatz der Friedhofssektoren / Ensemble de données des secteurs de cimetières';

ALTER TABLE tce_od.sector ADD COLUMN ident_short character varying(10);
ALTER TABLE tce_od.sector ADD COLUMN identifier text;
ALTER TABLE tce_od.sector ADD COLUMN remark text;
ALTER TABLE tce_od.sector ADD COLUMN the_geom geometry(Polygon,{SRID});


CREATE TABLE IF NOT EXISTS tce_od.furniture
(
   id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
   CONSTRAINT pkey_tce_od_furniture_id PRIMARY KEY (id)
);
COMMENT ON TABLE tce_od.furniture IS 'Dataset of cemetery furniture / Datensatz der Friedhofsmöbel / Ensemble de données du mobilier de cimetière';

ALTER TABLE tce_od.furniture ADD COLUMN fk_kind integer;
ALTER TABLE tce_od.furniture ADD COLUMN remark text;
ALTER TABLE tce_od.furniture ADD COLUMN the_geom geometry(Point,{SRID});


CREATE TABLE IF NOT EXISTS tce_od.vegetation
(
   id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
   CONSTRAINT pkey_tce_od_vegetation_id PRIMARY KEY (id)
);
COMMENT ON TABLE tce_od.vegetation IS 'Dataset of cemetery vegetation / Datensatz der Friedhofsbepflanzungen / Ensemble de données de la végétation du cimetière';

ALTER TABLE tce_od.vegetation ADD COLUMN fk_kind integer;
ALTER TABLE tce_od.vegetation ADD COLUMN remark text;
ALTER TABLE tce_od.vegetation ADD COLUMN the_geom geometry(Polygon,{SRID});


CREATE TABLE IF NOT EXISTS tce_od.organisation
(
   id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
   CONSTRAINT pkey_tce_od_organisation_id PRIMARY KEY (id)
);
COMMENT ON TABLE tce_od.organisation IS 'Dataset of organisations / Datensatz der Organisationen / Ensemble de données des organisations';

ALTER TABLE tce_od.organisation ADD COLUMN identifier text;
ALTER TABLE tce_od.organisation ADD COLUMN remark text;


CREATE TABLE IF NOT EXISTS tce_od.contact
(
   id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
   CONSTRAINT pkey_tce_od_contact_id PRIMARY KEY (id)
);
COMMENT ON TABLE tce_od.contact IS 'Dataset of contacts / Datensatz der Kontakte / Ensemble de données des contacts';

ALTER TABLE tce_od.contact ADD COLUMN fk_kind integer;
COMMENT ON COLUMN tce_od.contact.fk_kind IS 'Type of contact person / Art der Kontaktperson / Type de personne de contact';
ALTER TABLE tce_od.contact ADD COLUMN fk_organisation uuid;

ALTER TABLE tce_od.contact ADD COLUMN fk_civility integer;
ALTER TABLE tce_od.contact ADD COLUMN first_name text;
ALTER TABLE tce_od.contact ADD COLUMN last_name text;
ALTER TABLE tce_od.contact ADD COLUMN street_name text;
ALTER TABLE tce_od.contact ADD COLUMN house_number character varying(10);
ALTER TABLE tce_od.contact ADD COLUMN address_supplement text;
ALTER TABLE tce_od.contact ADD COLUMN city text;
ALTER TABLE tce_od.contact ADD COLUMN postal_code character varying(10);
ALTER TABLE tce_od.contact ADD COLUMN phone character varying(20);
ALTER TABLE tce_od.contact ADD COLUMN email character varying(255);
ALTER TABLE tce_od.contact ADD COLUMN remark text;


CREATE TABLE IF NOT EXISTS tce_od.cemetery
(
   id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
   CONSTRAINT pkey_tce_od_cemetery_id PRIMARY KEY (id)
);
COMMENT ON TABLE tce_od.cemetery IS 'Dataset of cemeteries / Datensatz der Friedhöfe / Ensemble de données des cimetières';

ALTER TABLE tce_od.cemetery ADD COLUMN identifier text;
ALTER TABLE tce_od.cemetery ADD COLUMN remark text;
ALTER TABLE tce_od.cemetery ADD COLUMN the_geom geometry(Polygon,{SRID});
