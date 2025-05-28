-------------------------------------------
/* CREATE roles - cluster initialisation */
-------------------------------------------

GRANT USAGE ON SCHEMA tce_app  TO tce_viewer;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA tce_app  TO tce_viewer;
GRANT SELECT, REFERENCES, TRIGGER ON ALL TABLES IN SCHEMA tce_app  TO tce_viewer;
ALTER DEFAULT PRIVILEGES IN SCHEMA tce_app  GRANT SELECT, REFERENCES, TRIGGER ON TABLES TO tce_viewer;

GRANT ALL ON SCHEMA tce_app TO tce_user;
GRANT ALL ON ALL TABLES IN SCHEMA tce_app TO tce_user;
GRANT ALL ON ALL SEQUENCES IN SCHEMA tce_app TO tce_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA tce_app GRANT ALL ON TABLES TO tce_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA tce_app GRANT ALL ON SEQUENCES TO tce_user;
