# pg_prove-docker
Alpine based super lightweight docker container to run pg_prove tests against your postgres database.

The container will install pgTAP (https://pgtap.org/) in the database and remove it again after the tests.
As long as your tests run inside transactions no trace of the tests should remain in the database.

## Usage

Set (as needed)
- $POSTGRES_HOST (or mount the pgsql socket to /tmp/.s.PSGSQL.5432)
- $POSTGRES_SUPERUSER (needed to install/remove pgTAP)
- $POSTGRES_SUPERUSER_PASSWORD
- $POSTGRES_TESTUSER (USER that will execute the tests)
- $POSTGRES_TESTUSER_PASSWORD
- $POSTGRES_DBNAME

Mount your tests to `/tests` inside the container 
