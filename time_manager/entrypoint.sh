#!/bin/sh
set -e
# Docker entrypoint script.
# Wait until Postgres is ready
while ! pg_isready -q -h $PGHOST -p $PGPORT -U $PGUSER
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

mix deps.get

if [[ -f assets/package.json ]]; then
  # Install the app's dependencies with npm
  cd assets
  npm install
  cd ..
fi

# Create, migrate, and seed database if it doesn't exist.
if [ ! `psql -Atqc "\\list $PGDATABASE"` ]; then
  echo "Database $PGDATABASE does not exist. Creating..."
  exec createdb -E UTF8 $PGDATABASE -l en_US.UTF-8 -T template0
  exec mix ecto.create
  exec mix ecto.migrate
  exec mix run priv/repo/seeds.exs
  exec mix phx.server
  echo "Database $PGDATABASE created."
fi

exec mix phx.server