#!/usr/bin/env bash
set -e

# Load environment variables from .env file
if [ -f .env ]; then
    echo "Loading environment variables from .env file..."
    set -a
    source .env
    set +a
else
    echo "Error: .env file not found"
    exit 1
fi

# Check for required environment variables
if [ -z "$SUPABASE_URL" ]; then
  echo "Error: SUPABASE_URL is not set"
  exit 1
fi

if [ -z "$SUPABASE_SERVICE_ROLE_KEY" ]; then
  echo "Error: SUPABASE_SERVICE_ROLE_KEY is not set"
  exit 1
fi

echo "Starting Supabase schema migration..."

# Link to the Supabase project if not already linked
if [ ! -f "supabase/config.toml" ]; then
    echo "Linking to Supabase project..."
    supabase link --project-ref $(echo $SUPABASE_URL | awk -F[/:] '{print $4}')
fi

# Run migrations using Supabase CLI
echo "Running migrations..."
yes | supabase db push --linked

echo "Schema migration completed successfully!" 
