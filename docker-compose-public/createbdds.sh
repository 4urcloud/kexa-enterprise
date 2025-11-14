#!/bin/bash
set -e
set -u

create_user_and_database() {
	local database=$1
	echo "  create '$database'..."
	
	if psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --list | grep -q "$database"; then
		echo "  bdd'$database' exist"
	else
		psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
		    CREATE DATABASE $database;
		    GRANT ALL PRIVILEGES ON DATABASE $database TO $POSTGRES_USER;
EOSQL
	fi
}

create_user_and_database "keycloak"