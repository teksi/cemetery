-------------------------------------------
/* CREATE roles - cluster initialisation */
-------------------------------------------
DO $$
DECLARE
    role text;
BEGIN
    FOREACH role IN ARRAY ARRAY['tce_viewer', 'tce_user', 'tce_manager', 'tce_sysadmin'] LOOP
      IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = role) THEN
          EXECUTE format('CREATE ROLE %1$I NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION', role);
      END IF;
    END LOOP;
END
$$;
GRANT tce_viewer TO tce_user;
GRANT tce_user TO tce_manager;
GRANT tce_manager TO tce_sysadmin;
