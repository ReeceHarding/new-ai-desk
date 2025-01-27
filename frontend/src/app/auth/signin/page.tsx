'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { motion } from 'framer-motion';
import { supabaseClient, getUserRole } from '@/utils/supabase';
import { Button } from '@/components/ui/Button';
import { Input } from '@/components/ui/Input';
import { Card } from '@/components/ui/Card';

export default function SigninPage() {
  const router = useRouter();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [errorMsg, setErrorMsg] = useState('');
  const [loading, setLoading] = useState(false);

  async function handleSignin(e: React.FormEvent) {
    e.preventDefault();
    setLoading(true);
    setErrorMsg('');

    try {
      const { data, error } = await supabaseClient.auth.signInWithPassword({
        email,
        password,
      });

      if (error) {
        setErrorMsg(error.message);
        return;
      }

      if (!data.user) {
        setErrorMsg('No user returned after sign-in');
        return;
      }

      // Get user role and redirect to appropriate dashboard
      const role = await getUserRole(data.user.id);
      if (!role) {
        setErrorMsg('Unable to fetch user role');
        return;
      }

      router.push(`/${role}/dashboard`);
    } catch (err) {
      setErrorMsg('An unexpected error occurred');
      console.error('Signin error:', err);
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-b from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800 py-12 px-4 sm:px-6 lg:px-8">
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        className="max-w-md w-full"
      >
        <Card className="w-full">
          <div className="text-center">
            <motion.h2
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ delay: 0.2 }}
              className="text-3xl font-extrabold text-gray-900 dark:text-white"
            >
              Sign in to your account
            </motion.h2>
          </div>

          <form onSubmit={handleSignin} className="mt-8 space-y-6">
            <div className="space-y-4">
              <Input
                id="email"
                type="email"
                label="Email address"
                required
                value={email}
                onChange={(e) => setEmail(e.target.value)}
              />

              <Input
                id="password"
                type="password"
                label="Password"
                required
                value={password}
                onChange={(e) => setPassword(e.target.value)}
              />
            </div>

            {errorMsg && (
              <motion.div
                initial={{ opacity: 0, y: -10 }}
                animate={{ opacity: 1, y: 0 }}
                className="rounded-md bg-red-50 dark:bg-red-900/50 p-4"
              >
                <div className="flex">
                  <div className="ml-3">
                    <h3 className="text-sm font-medium text-red-800 dark:text-red-200">
                      {errorMsg}
                    </h3>
                  </div>
                </div>
              </motion.div>
            )}

            <Button
              type="submit"
              loading={loading}
              className="w-full"
            >
              Sign in
            </Button>
          </form>
        </Card>
      </motion.div>
    </div>
  );
} 
