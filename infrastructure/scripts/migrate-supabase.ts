import fs from 'fs';
import path from 'path';
import { Client } from 'pg';
import dotenv from 'dotenv';

// Load environment variables
dotenv.config();

async function main() {
  // read SQL
  const sqlPath = path.join(__dirname, '..', '..', 'supabase', 'migrations', '00000000000000_init.sql');
  const schemaSQL = fs.readFileSync(sqlPath, 'utf-8');

  // Extract host and password from Supabase URL
  const supabaseUrl = new URL(process.env.SUPABASE_URL || '');
  const host = supabaseUrl.hostname;
  
  // connect to DB using Supabase service role key
  const client = new Client({
    host: host,
    port: 5432,
    user: 'postgres',
    password: process.env.SUPABASE_SERVICE_ROLE_KEY,
    database: 'postgres',
    ssl: {
      rejectUnauthorized: false
    }
  });

  try {
    await client.connect();
    console.log("Connected to Supabase. Applying schema...");

    // run schema
    await client.query(schemaSQL);
    console.log("Schema applied successfully.");

  } catch (err) {
    console.error("Error applying schema:", err);
    process.exit(1);
  } finally {
    await client.end();
    console.log("Done.");
  }
}

main().catch(err => {
  console.error(err);
  process.exit(1);
}); 
