#!/bin/bash
set -e
set -u

export PGPASSWORD="$POSTGRES_PASSWORD"

create_user_and_database() {
    local database=$1
    echo "  Checking '$database'..."
    
    if psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -tAc "SELECT 1 FROM pg_database WHERE datname='$database'" | grep -q 1; then
        echo "  Database '$database' already exists"
    else
        psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
            CREATE DATABASE $database;
            GRANT ALL PRIVILEGES ON DATABASE $database TO $POSTGRES_USER;
EOSQL
        echo "  Database '$database' created"
    fi
}

create_user_and_database "keycloak"