-- Ajoute les informations sur la cérémonie
ALTER TABLE tce_od.deceased ADD COLUMN IF NOT EXISTS ceremony_place TEXT;
ALTER TABLE tce_od.deceased ADD COLUMN IF NOT EXISTS ceremony_date DATE;
ALTER TABLE tce_od.deceased ADD COLUMN IF NOT EXISTS fk_contact_person uuid;
