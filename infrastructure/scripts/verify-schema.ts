import { Client } from 'pg';
import dotenv from 'dotenv';

dotenv.config();

async function main() {
  const supabaseUrl = new URL(process.env.SUPABASE_URL || '');
  const host = supabaseUrl.hostname;
  
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
    console.log("Connected to Supabase. Verifying schema...\n");

    // Check extensions
    const extensions = await client.query(`
      SELECT extname FROM pg_extension;
    `);
    console.log("Installed Extensions:");
    extensions.rows.forEach(ext => console.log(`- ${ext.extname}`));
    console.log();

    // Check enums
    const enums = await client.query(`
      SELECT typname FROM pg_type WHERE typcategory = 'E';
    `);
    console.log("Custom Enums:");
    enums.rows.forEach(enum_ => console.log(`- ${enum_.typname}`));
    console.log();

    // Check key tables
    const tables = await client.query(`
      SELECT tablename 
      FROM pg_tables 
      WHERE schemaname = 'public'
      ORDER BY tablename;
    `);
    console.log("Tables in public schema:");
    tables.rows.forEach(table => console.log(`- ${table.tablename}`));

  } catch (err) {
    console.error("Error verifying schema:", err);
    process.exit(1);
  } finally {
    await client.end();
  }
}

main().catch(err => {
  console.error(err);
  process.exit(1);
}); 