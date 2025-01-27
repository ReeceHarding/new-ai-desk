import { Worker } from 'bullmq';

const emailWorker = new Worker('email', async job => {
  console.log('Processing email job:', job.data);
  // Email sending logic will go here
}, {
  connection: {
    host: process.env.REDIS_HOST || 'localhost',
    port: parseInt(process.env.REDIS_PORT || '6379')
  }
}); 