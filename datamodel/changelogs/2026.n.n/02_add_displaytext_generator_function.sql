DROP FUNCTION IF EXISTS tce_od.displaytext_generator(uuid, NAME, JSONB) CASCADE;
CREATE FUNCTION tce_od.displaytext_generator(obj_id uuid, tablename NAME, new_row JSONB)
RETURNS TEXT
AS
$$
DECLARE
display_text TEXT DEFAULT '';
placeholder TEXT := 'TODO';
identifier TEXT;
last_name TEXT;
first_name TEXT;
remark TEXT;
death_date TEXT;
BEGIN

    --SET client_min_messages TO NOTICE;

    -- extract row values
    identifier := (new_row ->>'identifier')::text;
    first_name := (new_row ->>'first_name')::text;
    last_name := (new_row ->>'last_name')::text;
    remark := (new_row ->>'remark')::text;
    death_date := to_char((new_row ->>'death_date')::timestamp, 'YYYY.MM.DD');

    -- combine to form display-text
    IF tablename = 'cemetery' THEN
        display_text := identifier;

    ELSIF tablename = 'contact' THEN
        display_text := last_name || ' ' || first_name;

    ELSIF tablename = 'contract' THEN
        display_text := identifier || ' ' || remark;

    ELSIF tablename = 'deceased' THEN
        display_text := death_date || ' | ' || last_name || ' ' || first_name;

    ELSIF tablename = 'file' THEN
        display_text := identifier;

    ELSIF tablename = 'furniture' THEN
        display_text := remark;

    ELSIF tablename = 'organisation' THEN
        display_text := identifier;

    ELSIF tablename = 'sector' THEN
        display_text := identifier;

    ELSIF tablename = 'unit' THEN
        display_text := 'Grab Nr. ' || identifier;

    ELSIF tablename = 'vegetation' THEN
        display_text := remark;

    ELSE display_text := '?';
    END IF;

    RETURN display_text;

END;
$$ LANGUAGE plpgsql;
