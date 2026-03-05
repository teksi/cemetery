-- function used to normalize empty strings to null values
DROP FUNCTION IF EXISTS tce_app.normalize_empty_string(in_string TEXT) CASCADE;
CREATE FUNCTION tce_app.normalize_empty_string(in_string TEXT)
RETURNS TEXT
AS
$$
DECLARE
out_string TEXT DEFAULT NULL::text;
BEGIN
    IF in_string IS NULL OR in_string = ''
        THEN out_string := NULL::text;
    ELSE out_string := in_string;
    END IF;

    RETURN out_string;
END;
$$ LANGUAGE plpgsql;

-- display text generator
DROP FUNCTION IF EXISTS tce_app.displaytext_generator(uuid, NAME, JSONB) CASCADE;
CREATE FUNCTION tce_app.displaytext_generator(obj_id uuid, tablename NAME, new_row JSONB)
RETURNS TEXT
AS
$$
DECLARE
    display_text TEXT DEFAULT '';
    placeholder TEXT := 'TODO';
    identifier TEXT;
    last_name TEXT;
    first_name TEXT;
    second_first_name TEXT;
    family_name_at_birth TEXT;
    nickname TEXT;
    remark TEXT;
    death_date TEXT;
    phone_number TEXT;
    email TEXT;
    contract_kind integer;
    contract_kind_txt TEXT;
    urn_kind integer;
    urn_emoji TEXT;
BEGIN

    -- extract row values
    identifier := tce_app.normalize_empty_string((new_row ->>'identifier')::text);
    first_name := tce_app.normalize_empty_string((new_row ->>'first_name')::text);
    second_first_name := tce_app.normalize_empty_string((new_row ->>'second_first_name')::text);
    last_name := tce_app.normalize_empty_string((new_row ->>'last_name')::text);
    family_name_at_birth := tce_app.normalize_empty_string((new_row ->>'family_name_at_birth')::text);
    nickname := tce_app.normalize_empty_string((new_row ->>'nickname')::text);
    remark := tce_app.normalize_empty_string((new_row ->>'remark')::text);
    death_date := to_char((new_row ->>'death_date')::timestamp, 'DD.MM.YYYY');
    phone_number := tce_app.normalize_empty_string((new_row ->>'phone')::text);
    email := tce_app.normalize_empty_string((new_row ->>'email')::text);

    -- Debugging
    --RAISE NOTICE '%', new_row;

    -- combine to form display-text
    IF tablename = 'cemetery' THEN
        display_text := identifier;

    ELSIF tablename = 'contact' THEN
        display_text := CONCAT(
            COALESCE(last_name, ''),
            COALESCE(' ' || first_name, ''),
            COALESCE(' ' || second_first_name, ''),
            COALESCE(' | ' || email, ''),
            COALESCE(' | ' || phone_number, '')
        );

    ELSIF tablename = 'contract' THEN
        contract_kind := (new_row ->>'fk_kind')::text;
        contract_kind_txt := (SELECT ck.value_de FROM tce_vl.contract_kind ck WHERE ck.id = contract_kind);
        display_text := CONCAT(
            COALESCE(contract_kind_txt, ''),
            COALESCE(' | ' || identifier, ''),
            COALESCE(' | ' || remark, '')
        );

    ELSIF tablename = 'deceased' THEN
        urn_kind := (new_row ->>'fk_urn_kind')::text;
        IF urn_kind IS NOT NULL
            THEN urn_emoji := ' ⚱️';
        ELSE urn_emoji := '';
        END IF;

        display_text := CONCAT(
            death_date,
            COALESCE(urn_emoji, ''),
            ' | ',
            last_name,
            COALESCE(' (' || family_name_at_birth || ')', ''),
            COALESCE(' ' || first_name, ''),
            COALESCE(' ' || second_first_name, ''),
            COALESCE(' "' || nickname || '"', '')
        );

    ELSIF tablename = 'file' THEN
        display_text := identifier;

    ELSIF tablename = 'furniture' THEN
        display_text := remark;

    ELSIF tablename = 'organisation' THEN
        display_text := identifier;

    ELSIF tablename = 'sector' THEN
        display_text := identifier;

    ELSIF tablename = 'unit' THEN
        display_text := 'Nr. ' || identifier;

    ELSIF tablename = 'vegetation' THEN
        display_text := remark;

    ELSE display_text := '?';
    END IF;

    -- Debugging
    --RAISE NOTICE 'DspTXT: %', display_text;

    RETURN display_text;

END;
$$ LANGUAGE plpgsql;


DROP FUNCTION IF EXISTS tce_app.generate_display_text() CASCADE;
CREATE OR REPLACE FUNCTION tce_app.generate_display_text()
  RETURNS TRIGGER
AS
$BODY$
DECLARE
BEGIN
  NEW.display_txt := tce_app.displaytext_generator(NEW.id, TG_TABLE_NAME, TO_JSONB(NEW));
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
              EXECUTE PROCEDURE tce_app.generate_display_text();
        $sql$, trigger_name, tablename);
    END LOOP;
END $$;
