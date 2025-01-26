#!/bin/bash

echo "Starting Supabase schema migration..."

# Set the database connection URL
DATABASE_URL="postgresql://postgres.dkwjlvwuedmmzlavmuqq:supabasedatabasepw@aws-0-us-west-1.pooler.supabase.com:6543/postgres"

# Run the consolidated migration file
psql "${DATABASE_URL}" -f supabase/migrations/00000000000000_init.sql

echo "Migration completed successfully!" 
