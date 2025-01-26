import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config();

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('Missing required environment variables');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function seedData() {
  try {
    console.log('Starting seed data insertion...');

    // Create test organization
    const { data: org, error: orgError } = await supabase
      .from('organizations')
      .insert([
        { name: 'Test Organization' }
      ])
      .select()
      .single();

    if (orgError) throw orgError;
    console.log('Created organization:', org.id);

    // Create test profile
    const { data: profile, error: profileError } = await supabase
      .from('profiles')
      .insert([
        {
          organization_id: org.id,
          email: 'test@example.com',
          full_name: 'Test User'
        }
      ])
      .select()
      .single();

    if (profileError) throw profileError;
    console.log('Created profile:', profile.id);

    // Create test knowledge document
    const { data: doc, error: docError } = await supabase
      .from('knowledge_docs')
      .insert([
        {
          organization_id: org.id,
          title: 'Sample Document',
          content: 'This is a sample knowledge document for testing purposes.'
        }
      ])
      .select()
      .single();

    if (docError) throw docError;
    console.log('Created knowledge document:', doc.id);

    // Create test campaign
    const { data: campaign, error: campaignError } = await supabase
      .from('campaigns')
      .insert([
        {
          organization_id: org.id,
          name: 'Test Campaign',
          status: 'draft',
          settings: { reply_to: 'test@example.com' }
        }
      ])
      .select()
      .single();

    if (campaignError) throw campaignError;
    console.log('Created campaign:', campaign.id);

    console.log('Seed data insertion completed successfully!');
  } catch (error) {
    console.error('Error seeding data:', error);
    process.exit(1);
  }
}

seedData(); 