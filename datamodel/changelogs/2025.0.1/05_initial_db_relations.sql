-- INITIAL DB RELATIONS FOR 2025.0.1

--ALTER TABLE tww_od.structure_part ADD CONSTRAINT rel_structure_part_wastewater_structure FOREIGN KEY (fk_wastewater_structure) REFERENCES tww_od.wastewater_structure(obj_id) ON UPDATE CASCADE ON DELETE cascade DEFERRABLE INITIALLY DEFERRED;

------- DECEASED - RELATIONS -------
ALTER TABLE tce_od.deceased
  ADD CONSTRAINT rel_deceased_unit FOREIGN KEY (fk_unit)
  REFERENCES tce_od.unit (id) MATCH SIMPLE
  ON UPDATE RESTRICT ON DELETE RESTRICT
  DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT rel_deceased_unit ON TABLE tce_od.deceased IS 'Foreign key constraint linking deceased.fk_unit to unit.id, ensuring referential integrity between deceased records and their associated burial units.'; 

 /*

 What it does: adds a named foreign‑key constraint rel_deceased_unit on the table tce.deceased, enforcing that values in the column fk_unit must match an existing id in tce_od.unit.

## Breakdown:

 * ALTER TABLE tce.deceased — modify table tce.deceased.
 * ADD CONSTRAINT rel_deceasehat is referenced will be rejected.
* The constraint is enforced immediatelyd_unit — create a constraint named rel_deceased_unit.
 * FOREIGN KEY (fk_unit) — the local column(s) that reference another table.
 * REFERENCES tce_od.unit (id) — referenced table and column.
 * MATCH SIMPLE — default match behavior for composite keys (no special full match rules; fine here because it’s a single column).
 * ON UPDATE RESTRICT ON DELETE RESTRICT — prevent updating or deleting the referenced unit.id row while any deceased.fk_unit still references it (the DB will reject such UPDATE/DELETE).

## Practical effects:

* Inserts/updates to deceased.fk_unit must be NULL or an existing tce_od.unit.id.
* Trying to delete or change a unit.id t.
* Note: your datamodel script creates the deceased table in schema tce_od (tce_od.deceased). If that’s correct, the constraint should reference that table instead of tce.deceased. Example corrected statement:

## About DEFERRABLE INITIALLY DEFERRED:

* DEFERRABLE — the constraint can be deferred or immediate within a transaction (via SET CONSTRAINTS).
* INITIALLY DEFERRED — by default the constraint is deferred (checked at COMMIT).
* Practical effect — you can perform multi‑statement changes that temporarily violate the FK (for example delete a unit then update deceased rows to point elsewhere) as long as the final state at COMMIT satisfies the constraint. If the constraint is still violated at COMMIT the transaction fails.
* ON UPDATE/DELETE RESTRICT still applies at the time the constraint is checked; RESTRICT prevents leaving dangling references — with DEFERRABLE the prevention happens at COMMIT rather than immediately.
* Default without this clause is NOT DEFERRABLE (checked after each statement), so many multi‑step changes would be rejected unless you reorder them.

*/


------ UNIT - RELATIONS -------

ALTER TABLE tce_od.unit
  ADD CONSTRAINT rel_unit_contact_person FOREIGN KEY (fk_contact_person)
  REFERENCES tce_od.contact (id) MATCH SIMPLE
  ON UPDATE RESTRICT ON DELETE RESTRICT
  DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT rel_unit_contact_person ON TABLE tce_od.unit IS 'Foreign key constraint linking unit.fk_contact_person to contact.id, ensuring referential integrity between burial units and their associated contact persons.';

ALTER TABLE tce_od.unit
  ADD CONSTRAINT rel_unit_company FOREIGN KEY (fk_company)
  REFERENCES tce_od.organisation (id) MATCH SIMPLE
  ON UPDATE RESTRICT ON DELETE RESTRICT
  DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT rel_unit_company ON TABLE tce_od.unit IS 'Foreign key constraint linking unit.fk_company to organisation.id, ensuring referential integrity between burial units and their associated companies.';

ALTER TABLE tce_od.unit
  ADD CONSTRAINT rel_unit_sector FOREIGN KEY (fk_sector)
  REFERENCES tce_od.sector (id) MATCH SIMPLE
  ON UPDATE RESTRICT ON DELETE RESTRICT
  DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT rel_unit_sector ON TABLE tce_od.unit IS 'Foreign key constraint linking unit.fk_sector to sector.id, ensuring referential integrity between burial units and their associated cemetery sectors.';

ALTER TABLE tce_od.unit
  ADD CONSTRAINT rel_unit_cemetery FOREIGN KEY (fk_cemetery)
  REFERENCES tce_od.cemetery (id) MATCH SIMPLE
  ON UPDATE RESTRICT ON DELETE RESTRICT
  DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT rel_unit_cemetery ON TABLE tce_od.unit IS 'Foreign key constraint linking unit.fk_cemetery to cemetery.id, ensuring referential integrity between burial units and their associated cemeteries.';

------ CONTRACT - RELATIONS -------

ALTER TABLE tce_od.contract
   ADD CONSTRAINT rel_contract_unit FOREIGN KEY (fk_unit)
   REFERENCES tce_od.unit (id) MATCH SIMPLE
   ON UPDATE RESTRICT ON DELETE RESTRICT
   DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT rel_contract_unit ON TABLE tce_od.contract IS 'Foreign key constraint linking contract.fk_unit to unit.id, ensuring referential integrity between contracts and their associated burial units.';

ALTER TABLE tce_od.contract
  ADD CONSTRAINT rel_contract_contact FOREIGN KEY (fk_contract_person)
  REFERENCES tce_od.contact (id) MATCH SIMPLE
  ON UPDATE RESTRICT ON DELETE RESTRICT
  DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT rel_contract_contact ON TABLE tce_od.contract IS 'Foreign key constraint linking contract.fk_contract_person to contact.id, ensuring referential integrity between contracts and their associated contact persons.';


