-------File table using same structure as VSA KEK but as minimal as possible
-------
CREATE TABLE tce_od.file
(
   id uuid DEFAULT public.uuid_generate_v1() NOT NULL PRIMARY KEY
)
WITH (
   OIDS = False
);
-- COMMENT ON COLUMN tce_od.file.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix), see www.interlis.ch';
-- ALTER TABLE tce_od.file ADD COLUMN classname  integer ;
-- COMMENT ON COLUMN tce_od.file.classname IS 'Specifies the classname of the VSA-DSS data model to which the file belongs. In principle, all classes are possible. In the context of sewer television recordings, mainly channel, manhole damage, channel damage and examination. / Gibt an, zu welcher Klasse des VSA-DSS-Datenmodells die Datei gehört. Grundsätzlich alle Klassen möglich. Im Rahmen der Kanalfernsehaufnahmen hauptsächlich Kanal, Normschachtschaden, Kanalschaden und Untersuchung. / Indique à quelle classe du modèle de données de VSA-SDEE appartient le fichier. Toutes les classes sont possible. Surtout CANALISATION, DOMMAGE_CHAMBRE_STANDARD, DOMMAGE_CANALISATION, EXAMEN.';
 ALTER TABLE tce_od.file ADD COLUMN identifier text;
-- ALTER TABLE tce_od.file ADD CONSTRAINT fi_identifier_length_max_120 CHECK(char_length(identifier)<=120);
-- COMMENT ON COLUMN tce_od.file.identifier IS 'yyy_Name der Datei mit Dateiendung. Z.B video_01.mpg oder haltung_01.ipf / Name der Datei mit Dateiendung. Z.B video_01.mpg oder haltung_01.ipf / Nom du fichier avec terminaison du fichier. P. ex. video_01.mpg ou canalisation_01.ipf';
-- ALTER TABLE tce_od.file ADD COLUMN kind  integer ;
-- COMMENT ON COLUMN tce_od.file.kind IS 'yyy_Beschreibt die Art der Datei. Für analoge Videos auf Bändern ist der Typ "Video" einzusetzen. Die Bezeichnung wird dann gleich gesetzt wie die Bezeichnung des Videobandes. / Beschreibt die Art der Datei. Für analoge Videos auf Bändern ist der Typ "Video" einzusetzen. Die Bezeichnung wird dann gleich gesetzt wie die Bezeichnung des Videobandes. / Décrit le type de fichier. Pour les vidéos analo-giques sur bandes, le type « vidéo » doit être entré. La désignation sera ensuite la même que celle de la bande vidéo.';
 ALTER TABLE tce_od.file ADD COLUMN object text;
-- ALTER TABLE tce_od.file ADD CONSTRAINT fi_object_length_max_16 CHECK(char_length(object)<=16);
COMMENT ON COLUMN tce_od.file.object IS 'UUID (uuid) des Datensatzes zu dem die Datei gehört / Identification de l''ensemble de données auquel le fichier appartient (UUID)';
ALTER TABLE tce_od.file ADD COLUMN filepath text;
--  ALTER TABLE tce_od.file ADD CONSTRAINT fi_path_relative_length_max_200 CHECK(char_length(path_relative)<=200);
COMMENT ON COLUMN tce_od.file.path_relative IS 'yyy_Zusätzlicher Relativer Pfad, wo die Datei auf dem Datenträger zu finden ist. Z.B. DVD_01. / Zusätzlicher Relativer Pfad, wo die Datei auf dem Datenträger zu finden ist. Z.B. DVD_01. / Accès relatif supplémentaire à l’emplacement du fichier sur le support de données. P. ex. DVD_01';
 ALTER TABLE tce_od.file ADD COLUMN remark text;
--  ALTER TABLE tce_od.file ADD CONSTRAINT fi_remark_length_max_80 CHECK(char_length(remark)<=80);
-- COMMENT ON COLUMN tce_od.file.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
--  ALTER TABLE tce_od.file ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
-- COMMENT ON COLUMN tce_od.file.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
--  ALTER TABLE tce_od.file ADD COLUMN fk_dataowner varchar(16);
-- COMMENT ON COLUMN tce_od.file.fk_dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
--  ALTER TABLE tce_od.file ADD COLUMN fk_provider varchar(16);
-- COMMENT ON COLUMN tce_od.file.fk_provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
