
docker compose exec db dropdb -U postgres tce
docker compose exec db createdb -U postgres tce

docker compose exec db pum -vvv -s pg_tce -d datamodel install -p SRID 2056 --roles --grant

docker compose run qgis sh -c 'xvfb-run /usr/src/plugin/tce_cmd.py interlis_import --xtf_file /usr/src/plugin/teksi_wastewater/tests/data/test-dataset-organisations.xtf --pghost db --pgdatabase tce --pguser postgres --pgpass postgres --pgport 5432'
docker compose run qgis sh -c 'xvfb-run /usr/src/plugin/tce_cmd.py interlis_import --xtf_file /usr/src/plugin/teksi_wastewater/tests/data/test-dataset-DSS.xtf --pghost db --pgdatabase tce --pguser postgres --pgpass postgres --pgport 5432'

docker compose exec db pg_dump --inserts --data-only --no-owner --no-privileges --schema=tce_od -U postgres tce > demo_data.sql

# Comment out lines with SELECT pg_catalog.set_config, keeping the original content
sed -i '/^SELECT pg_catalog\.set_config/ s/^/-- Removed as it breaks PostGIS: /' demo_data.sql
