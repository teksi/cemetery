-- Ajoute les informations sur la cérémonie
ALTER TABLE tce_od.deceased ADD COLUMN IF NOT EXISTS ceremony_place TEXT;
ALTER TABLE tce_od.deceased ADD COLUMN IF NOT EXISTS ceremony_date DATE;
ALTER TABLE tce_od.deceased ADD COLUMN IF NOT EXISTS fk_contact_person uuid;

ALTER TABLE tce_od.deceased
  ADD CONSTRAINT rel_deceased_contact_person FOREIGN KEY (fk_contact_person)
  REFERENCES tce_od.contact (id) MATCH SIMPLE
  ON UPDATE RESTRICT ON DELETE RESTRICT
  DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT rel_deceased_contact_person ON tce_od.deceased IS 'Foreign key constraint linking deceased.fk_contact_person to contact.id, ensuring referential integrity between deceased records and their associated contact.';

ALTER TABLE tce_od.deceased ADD COLUMN IF NOT EXISTS contact_person_link TEXT;
