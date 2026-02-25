DROP FUNCTION IF EXISTS tce_od.generate_display_text() CASCADE;
CREATE OR REPLACE FUNCTION tce_od.generate_display_text()
  RETURNS TRIGGER
AS
$BODY$
DECLARE
BEGIN
  NEW.display_txt := tce_od.displaytext_generator(NEW.id, TG_TABLE_NAME, TO_JSONB(NEW));
  RETURN NEW;
END
$BODY$
  LANGUAGE 'plpgsql' VOLATILE;
  

-- append triggers to all required classes
DO $$
DECLARE
    tablename TEXT;
    trigger_name TEXT;

    -- tables affected
    table_list TEXT[] := ARRAY[
      'cemetery',
      'contact',
      'contract',
      'deceased',
      'file',
      'furniture',
      'organisation',
      'sector',
      'unit',
      'vegetation'
    ];
BEGIN
    FOREACH tablename IN ARRAY table_list
    LOOP
        trigger_name := tablename || '_dp_trigger';        

        EXECUTE format('DROP TRIGGER IF EXISTS %I ON tce_od.%I;', trigger_name, tablename);

        EXECUTE format($sql$
            CREATE TRIGGER %I
              BEFORE INSERT OR UPDATE
              ON tce_od.%I
              FOR EACH ROW
              EXECUTE PROCEDURE tce_od.generate_display_text();
        $sql$, trigger_name, tablename);
    END LOOP;
END $$;
