#!/usr/bin/env bash

set -e

INSTALL_DEPS=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --install-deps|-i)
      INSTALL_DEPS=1
      shift
      ;;
    *)
      shift
      ;;
  esac
done

source .venv/bin/activate

if [[ $INSTALL_DEPS -eq 1 ]]; then
  .venv/bin/python -m pip install --ignore-installed ~/dev/pum
  #.venv/bin/python -m pip install --ignore-installed ~/dev/pirogue
  pyenv rehash
fi

export PGSERVICE=pg_tce

# Cluster roles, uncomment only for first run
# psql "service=${PGSERVICE}" -v ON_ERROR_STOP=1 -f ${DIR}/12_0_roles.sql

pum -v -s pg_tce -d datamodel install -p SRID 2056 # --roles --grant # --demo-data Aletsch
# roles grant is not yet functional in pum
# demo data is not yet implemented for cemetery

# Database roles
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=1 -f ${DIR}/12_1_roles.sql
