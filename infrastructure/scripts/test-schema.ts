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
    console.log("Connected to Supabase. Running tests...\n");

    // Test 1: Create an organization
    const org = await client.query(`
      INSERT INTO organizations (name, logo_url)
      VALUES ('Test Org', 'https://example.com/logo.png')
      RETURNING id, name;
    `);
    console.log("Test 1 - Created organization:", org.rows[0]);

    // Test 2: Create a user in that organization
    const user = await client.query(`
      INSERT INTO users (role, org_id, email, display_name)
      VALUES ('admin', $1, 'test@example.com', 'Test Admin')
      RETURNING id, role, email;
    `, [org.rows[0].id]);
    console.log("Test 2 - Created user:", user.rows[0]);

    // Test 3: Create a ticket
    const ticket = await client.query(`
      INSERT INTO tickets (org_id, status, subject, customer_id, assigned_agent_id)
      VALUES ($1, 'open', 'Test Ticket', $2, $2)
      RETURNING id, subject, status;
    `, [org.rows[0].id, user.rows[0].id]);
    console.log("Test 3 - Created ticket:", ticket.rows[0]);

    // Test 4: Create a message on the ticket
    const message = await client.query(`
      INSERT INTO messages (ticket_id, sender_id, content, direction, status)
      VALUES ($1, $2, 'Test message content', 'inbound', 'sent')
      RETURNING id, content;
    `, [ticket.rows[0].id, user.rows[0].id]);
    console.log("Test 4 - Created message:", message.rows[0]);

    // Clean up test data
    await client.query('DELETE FROM messages WHERE id = $1', [message.rows[0].id]);
    await client.query('DELETE FROM tickets WHERE id = $1', [ticket.rows[0].id]);
    await client.query('DELETE FROM users WHERE id = $1', [user.rows[0].id]);
    await client.query('DELETE FROM organizations WHERE id = $1', [org.rows[0].id]);
    
    console.log("\nAll tests passed successfully!");

  } catch (err) {
    console.error("Error running tests:", err);
    process.exit(1);
  } finally {
    await client.end();
  }
}

main().catch(err => {
  console.error(err);
  process.exit(1);
}); 