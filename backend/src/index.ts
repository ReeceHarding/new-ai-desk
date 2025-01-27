import express from 'express';
import { createClient } from '@supabase/supabase-js';
import { Queue, Worker } from 'bullmq';

const app = express();
const port = process.env.PORT || 4000;

// Initialize Supabase client
const supabaseUrl = process.env.SUPABASE_URL || '';
const supabaseKey = process.env.SUPABASE_SERVICE_KEY || '';
const supabase = createClient(supabaseUrl, supabaseKey);

// Initialize queues
const emailQueue = new Queue('email', {
  connection: {
    host: process.env.REDIS_HOST || 'localhost',
    port: parseInt(process.env.REDIS_PORT || '6379')
  }
});

// Basic health check endpoint
app.get('/health', (req, res) => {
  res.json({ status: 'healthy' });
});

app.listen(port, () => {
  console.log(`Backend worker listening on port ${port}`);
}); 