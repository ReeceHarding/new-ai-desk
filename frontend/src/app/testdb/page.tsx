import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!;
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!;

const supabaseClient = createClient(supabaseUrl, supabaseAnonKey);

export default async function TestDbPage() {
  const { data, error } = await supabaseClient
    .from('organizations')
    .select('id, name')
    .limit(5);

  let content;
  if (error) {
    content = <p>Error: {error.message}</p>;
  } else {
    content = data?.map(org => <p key={org.id}>{org.name}</p>);
  }

  return (
    <main style={{ padding: '2rem' }}>
      <h1>Test DB Page</h1>
      {content}
    </main>
  );
} 