#! /bin/bash

#Inspired by https://github.com/DreamItGetIT/docker-pg-prove/blob/master/test.sh

#Insert all pgTAP functions via install script (this saves us from uploading the control file)
PGPASSWORD=${POSTGRES_SUPERUSER_PASSWORD?} psql -h ${POSTGRES_HOST?} -U ${POSTGRES_SUPERUSER?} -f /pgtap/pgtap.sql > /dev/null

PGPASSWORD=${POSTGRES_TESTUSER_PASSWORD?} pg_prove -h ${POSTGRES_HOST?} -U ${POSTGRES_TESTUSER?} /tests

testRC=$?

#Remove all pgTAP functions to leave the Database in its original state
PGPASSWORD=${POSTGRES_SUPERUSER_PASSWORD?} psql -h ${POSTGRES_HOST?} -U ${POSTGRES_SUPERUSER?} -f /pgtap/uninstall_pgtap.sql > /dev/null

exit $testRC