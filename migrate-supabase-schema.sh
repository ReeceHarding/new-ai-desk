#!/bin/bash
set -e  # Exit on error

echo "Starting Supabase schema migration..."

# Set the database connection URL
DATABASE_URL="postgresql://postgres.dkwjlvwuedmmzlavmuqq:supabasedatabasepw@aws-0-us-west-1.pooler.supabase.com:6543/postgres"

# Run migrations in order
for migration in $(ls supabase/migrations/*.sql | sort); do
    echo "Applying migration: $migration"
    # Run with ON_ERROR_STOP=1 to stop on first error, and -v ON_ERROR_ROLLBACK=on to rollback on error
    PGOPTIONS='--client-min-messages=warning' psql -X -v ON_ERROR_STOP=1 -v ON_ERROR_ROLLBACK=on -P pager=off "${DATABASE_URL}" -f "$migration" || {
        echo "Error applying migration $migration"
        exit 1
    }
done

echo "Migration completed successfully!" 
