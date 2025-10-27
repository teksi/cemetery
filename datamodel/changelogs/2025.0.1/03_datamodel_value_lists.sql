-- Datamodel initialization script for the TEKSI cemetery database

--------------------- VALUE LIST BASE--------------------------------
/* CREATE */
CREATE TABLE tce_vl.value_list_base ( id integer not null, CONSTRAINT "value_list_base_pk" PRIMARY KEY (id));
COMMENT ON TABLE tce_vl.value_list_base IS 'Master tables for value lists. It will be inherited by value list tables. This table shall not be filled. Be warned that value list table shall have its own unique index on id since PG does not propagate indexes. Therefore unicity of id cannot be garanteed over all value lists.';

/* COLUMNS */
ALTER TABLE tce_vl.value_list_base ADD COLUMN active boolean default true;
ALTER TABLE tce_vl.value_list_base ADD COLUMN short_en varchar(10) ;
ALTER TABLE tce_vl.value_list_base ADD COLUMN short_fr varchar(10) ;
ALTER TABLE tce_vl.value_list_base ADD COLUMN short_de varchar(10) ;
ALTER TABLE tce_vl.value_list_base ADD COLUMN short_it varchar(10) ;
ALTER TABLE tce_vl.value_list_base ADD COLUMN value_en varchar(50) ;
ALTER TABLE tce_vl.value_list_base ADD COLUMN value_fr varchar(50) ;
ALTER TABLE tce_vl.value_list_base ADD COLUMN value_de varchar(50) ;
ALTER TABLE tce_vl.value_list_base ADD COLUMN value_it varchar(50) ;
ALTER TABLE tce_vl.value_list_base ADD COLUMN description_en text ;
ALTER TABLE tce_vl.value_list_base ADD COLUMN description_fr text ;
ALTER TABLE tce_vl.value_list_base ADD COLUMN description_de text ;
ALTER TABLE tce_vl.value_list_base ADD COLUMN description_it text ;
ALTER TABLE tce_vl.value_list_base ADD COLUMN sia405code text;


--------------------- URN MATERIAL --------------------------------
/* CREATE */
CREATE TABLE tce_vl.urn_material () INHERITS ( tce_vl.value_list_base);
ALTER TABLE tce_vl.urn_material ADD CONSTRAINT vl_urn_material_pk PRIMARY KEY (id);
COMMENT ON TABLE tce_vl.urn_material IS 'Urn material';

/* VALUES */
INSERT INTO tce_vl.urn_material (id, value_en, value_fr, value_de, value_it) VALUES (101, 'unknown', 'inconnu', 'unbekannt', 'sconosciuto');

INSERT INTO tce_vl.urn_material (id, value_en, value_fr, value_de, value_it) VALUES (1001,'metal','métal','Metall','metallo');
INSERT INTO tce_vl.urn_material (id, value_en, value_fr, value_de, value_it) VALUES (1002,'ceramics','céramique','Keramik','ceramica');
INSERT INTO tce_vl.urn_material (id, value_en, value_fr, value_de, value_it) VALUES (1003,'copper','cuivre','Kupfer','rame');
INSERT INTO tce_vl.urn_material (id, value_en, value_fr, value_de, value_it) VALUES (1004,'wood','bois','Holz','legno');
INSERT INTO tce_vl.urn_material (id, value_en, value_fr, value_de, value_it) VALUES (1005,'sandstone','grès','Steingut','gres');
INSERT INTO tce_vl.urn_material (id, value_en, value_fr, value_de, value_it) VALUES (1006,'brick','brique','Ziegel','mattoni');
INSERT INTO tce_vl.urn_material (id, value_en, value_fr, value_de, value_it) VALUES (1007,'bronze','bronze','Bronze','bronzo');
INSERT INTO tce_vl.urn_material (id, value_en, value_fr, value_de, value_it) VALUES (1008,'marble','marbre','Marmor','marmo');
INSERT INTO tce_vl.urn_material (id, value_en, value_fr, value_de, value_it) VALUES (1009,'fabric','toile','Stoff','tessuto');

--------------------- URN SHAPE --------------------------------
/* CREATE */
CREATE TABLE tce_vl.urn_shape () INHERITS ( tce_vl.value_list_base);
ALTER TABLE tce_vl.urn_shape ADD CONSTRAINT vl_urn_shape_pk PRIMARY KEY (id);
COMMENT ON TABLE tce_vl.urn_shape IS 'Urn shape';

/* VALUES */
INSERT INTO tce_vl.urn_shape (id, value_en, value_fr, value_de, value_it) VALUES (101, 'unknown', 'inconnu', 'unbekannt', 'sconosciuto');

INSERT INTO tce_vl.urn_shape (id, value_en, value_fr, value_de, value_it) VALUES (1101,'cylindrical','cylindrique','zylindrisch','cilindrico');
INSERT INTO tce_vl.urn_shape (id, value_en, value_fr, value_de, value_it) VALUES (1102,'rectangular','rectangulaire','rechteckig','rettangolare');
INSERT INTO tce_vl.urn_shape (id, value_en, value_fr, value_de, value_it) VALUES (1103,'round','ronde','rund','rotondo');
INSERT INTO tce_vl.urn_shape (id, value_en, value_fr, value_de, value_it) VALUES (1104,'amphora','amphore','Amphore','anfora');
INSERT INTO tce_vl.urn_shape (id, value_en, value_fr, value_de, value_it) VALUES (1105,'bag','sac','Sack','sacco');

--------------------- UNIT KIND --------------------------------
/* CREATE */
CREATE TABLE tce_vl.unit_kind () INHERITS ( tce_vl.value_list_base);
ALTER TABLE tce_vl.unit_kind ADD CONSTRAINT vl_unit_kind_pk PRIMARY KEY (id);
COMMENT ON TABLE tce_vl.unit_kind IS 'Unit kind';

/* VALUES */
INSERT INTO tce_vl.unit_kind (id, value_en, value_fr, value_de, value_it) VALUES (101, 'unknown', 'inconnu', 'unbekannt', 'sconosciuto');

INSERT INTO tce_vl.unit_kind (id, value_en, value_fr, value_de, value_it) VALUES (2000,'not inhumated here','non inhumé ici','nicht hier beigesetzt','non inumato qui');

INSERT INTO tce_vl.unit_kind (id, value_en, value_fr, value_de, value_it) VALUES (2001,'cave','caveau','Krypta','camerale');
INSERT INTO tce_vl.unit_kind (id, value_en, value_fr, value_de, value_it) VALUES (2002,'plot','concession','Koncession','concessione');
INSERT INTO tce_vl.unit_kind (id, value_en, value_fr, value_de, value_it) VALUES (2003,'cinerary plot','concession cinéraire','Konzession Krematorium','concessione cineraria');
INSERT INTO tce_vl.unit_kind (id, value_en, value_fr, value_de, value_it) VALUES (2004,'inline grave','tombe en ligne','Reihengrab','tomba in fila');
INSERT INTO tce_vl.unit_kind (id, value_en, value_fr, value_de, value_it) VALUES (2005,'cinerary grave','tombe cinéraire','Reihengrab','tomba in fila');
INSERT INTO tce_vl.unit_kind (id, value_en, value_fr, value_de, value_it) VALUES (2006,'child grave','tombe d''enfant','Kindgrab','tomba per bambini');
INSERT INTO tce_vl.unit_kind (id, value_en, value_fr, value_de, value_it) VALUES (2007,'columbarium','columbarium','Kolumbarium','colombario');
INSERT INTO tce_vl.unit_kind (id, value_en, value_fr, value_de, value_it) VALUES (2008,'memorial garden','jardin du souvenir','Garten der Erinnerung','giardino della memoria');
INSERT INTO tce_vl.unit_kind (id, value_en, value_fr, value_de, value_it) VALUES (2009,'concession columbarium','concession columbarium','Koncession Kolumbarium','concessione colombario');
INSERT INTO tce_vl.unit_kind (id, value_en, value_fr, value_de, value_it) VALUES (2010,'monument only','monument uniquement','nur Monument','solo monumento');
INSERT INTO tce_vl.unit_kind (id, value_en, value_fr, value_de, value_it) VALUES (2011,'Family grave','tombe familiale','Familiengrab','tomba di famiglia');

--------------------- UNIT SIZE --------------------------------
/* CREATE */
CREATE TABLE tce_vl.unit_size () INHERITS ( tce_vl.value_list_base);
ALTER TABLE tce_vl.unit_size ADD CONSTRAINT vl_unit_size_pk PRIMARY KEY (id);
COMMENT ON TABLE tce_vl.unit_size IS 'Unit size';

/* VALUES */
INSERT INTO tce_vl.unit_size (id, value_en, value_fr, value_de, value_it) VALUES (101, 'unknown', 'inconnu', 'unbekannt', 'sconosciuto');

INSERT INTO tce_vl.unit_size (id, value_en, value_fr, value_de, value_it) VALUES (2101,'single','simple','einzel','singolo');
INSERT INTO tce_vl.unit_size (id, value_en, value_fr, value_de, value_it) VALUES (2102,'double','double','doppel','doppio');
INSERT INTO tce_vl.unit_size (id, value_en, value_fr, value_de, value_it) VALUES (2103,'triple','triple','dreifach','triplo');
INSERT INTO tce_vl.unit_size (id, value_en, value_fr, value_de, value_it) VALUES (2104,'quadruple','quadruple','vierfach','quattro posti');

--------------------- UNIT CONTROL --------------------------------
/* CREATE */
CREATE TABLE tce_vl.control_kind () INHERITS ( tce_vl.value_list_base);
ALTER TABLE tce_vl.control_kind ADD CONSTRAINT vl_control_kind_pk PRIMARY KEY (id);
COMMENT ON TABLE tce_vl.control_kind IS 'Control kind';

/* VALUES */
INSERT INTO tce_vl.control_kind (id, value_en, value_fr, value_de, value_it) VALUES (101, 'unknown', 'inconnu', 'unbekannt', 'sconosciuto');

INSERT INTO tce_vl.control_kind (id, value_en, value_fr, value_de, value_it) VALUES (2201,'controled','contrôlé','kontrolliert','controllato');
INSERT INTO tce_vl.control_kind (id, value_en, value_fr, value_de, value_it) VALUES (2202,'not controled','non contrôlé','nicht kontrolliert','non controllato');

--------------------- FURNITURE KIND --------------------------------
/* CREATE */
CREATE TABLE tce_vl.furniture_kind () INHERITS ( tce_vl.value_list_base);
ALTER TABLE tce_vl.furniture_kind ADD CONSTRAINT vl_furniture_kind_pk PRIMARY KEY (id);
COMMENT ON TABLE tce_vl.furniture_kind IS 'Furniture kind';

/* VALUES */
INSERT INTO tce_vl.furniture_kind (id, value_en, value_fr, value_de, value_it) VALUES (101, 'unknown', 'inconnu', 'unbekannt', 'sconosciuto');

INSERT INTO tce_vl.furniture_kind (id, value_en, value_fr, value_de, value_it) VALUES (4001,'fountain','fontaine','Brunnen','fontana');
INSERT INTO tce_vl.furniture_kind (id, value_en, value_fr, value_de, value_it) VALUES (4002,'bench','banc','Bank','panchina');
INSERT INTO tce_vl.furniture_kind (id, value_en, value_fr, value_de, value_it) VALUES (4003,'garbage bin','poubelle','Abfalleimer','cestino');

---------------------- VEGETATION KIND --------------------------------
/* CREATE */
CREATE TABLE tce_vl.vegetation_kind () INHERITS ( tce_vl.value_list_base);
ALTER TABLE tce_vl.vegetation_kind ADD CONSTRAINT vl_vegetation_kind_pk PRIMARY KEY (id);
COMMENT ON TABLE tce_vl.vegetation_kind IS 'Vegetation kind';

/* VALUES */
INSERT INTO tce_vl.vegetation_kind (id, value_en, value_fr, value_de, value_it) VALUES (101, 'unknown', 'inconnu', 'unbekannt', 'sconosciuto');

INSERT INTO tce_vl.vegetation_kind (id, value_en, value_fr, value_de, value_it) VALUES (5001,'bush','buisson','Busch','cespuglio');
INSERT INTO tce_vl.vegetation_kind (id, value_en, value_fr, value_de, value_it) VALUES (5002,'flower bed','massif floral','Blumenbeet','aiuola fiorita');
INSERT INTO tce_vl.vegetation_kind (id, value_en, value_fr, value_de, value_it) VALUES (5003,'hedge','haie','Hecke','siepe');
INSERT INTO tce_vl.vegetation_kind (id, value_en, value_fr, value_de, value_it) VALUES (5004,'meadow','prairie','Wiese','prato');
