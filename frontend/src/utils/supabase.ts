import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!;
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!;

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error('Missing Supabase environment variables');
}

export const supabaseClient = createClient(supabaseUrl, supabaseAnonKey, {
  auth: {
    persistSession: true,
    autoRefreshToken: true,
  },
});

// Types for user roles
export type UserRole = 'customer' | 'agent' | 'admin';

// Helper function to get user role
export async function getUserRole(userId: string): Promise<UserRole | null> {
  const { data, error } = await supabaseClient
    .from('users')
    .select('role')
    .eq('id', userId)
    .single();

  if (error || !data) {
    console.error('Error fetching user role:', error);
    return null;
  }

  return data.role as UserRole;
} 