-- FUNCTION: tce_app.ft_update_fk_unit()

-- DROP FUNCTION IF EXISTS tce_app.ft_update_fk_unit();

CREATE OR REPLACE FUNCTION tce_app.ft_update_fk_unit()
RETURNS trigger
LANGUAGE plpgsql
AS $BODY$
DECLARE
    v_unit_id tce_od.unit.id%TYPE;
BEGIN
    -- Search for a unit polygon that contains the point in NEW.the_geom
    -- and assign its id to v_unit_id
    SELECT id INTO v_unit_id
    FROM tce_od.unit
    WHERE ST_Contains(the_geom, NEW.the_geom)
    AND disused IS NOT true
    LIMIT 1;

    -- Update the fk_unit field in the NEW record
    NEW.fk_unit := v_unit_id;

    RETURN NEW;
END;
$BODY$;

CREATE TRIGGER trg_update_fk_unit
BEFORE INSERT OR UPDATE ON tce_od.deceased
FOR EACH ROW
EXECUTE FUNCTION tce_app.ft_update_fk_unit();
