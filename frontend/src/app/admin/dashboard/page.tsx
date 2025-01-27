'use client';

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { motion } from 'framer-motion';
import { supabaseClient } from '@/utils/supabase';
import { Card } from '@/components/ui/Card';
import { Layout } from '@/components/ui/Layout';

export default function AdminDashboard() {
  const router = useRouter();
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function checkSession() {
      try {
        const { data: { session }, error } = await supabaseClient.auth.getSession();

        if (error || !session) {
          router.push('/auth/signin');
          return;
        }

        // Check if user is admin
        const { data, error: roleError } = await supabaseClient
          .from('users')
          .select('role')
          .eq('id', session.user.id)
          .single();

        if (roleError || !data || data.role !== 'admin') {
          router.push('/auth/signin');
          return;
        }

        setLoading(false);
      } catch (err) {
        console.error('Error checking session:', err);
        router.push('/auth/signin');
      }
    }

    checkSession();
  }, [router]);

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gradient-to-b from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-indigo-600 mx-auto"></div>
          <p className="mt-4 text-slate-600 dark:text-slate-400">Loading...</p>
        </div>
      </div>
    );
  }

  return (
    <Layout>
      <div className="space-y-6">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="bg-white dark:bg-slate-800 shadow-sm rounded-lg p-6"
        >
          <h1 className="text-3xl font-bold text-gray-900 dark:text-white">
            Admin Dashboard
          </h1>
          <p className="mt-2 text-gray-600 dark:text-gray-300">
            Manage your CRM system and monitor key metrics
          </p>
        </motion.div>

        {/* Stats Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          {[
            { title: 'Total Users', value: '1,234', change: '+12%' },
            { title: 'Active Tickets', value: '56', change: '-5%' },
            { title: 'Response Time', value: '2.4h', change: '+8%' },
            { title: 'Customer Satisfaction', value: '94%', change: '+2%' }
          ].map((stat, index) => (
            <motion.div
              key={stat.title}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.1 }}
            >
              <Card className="p-6">
                <h3 className="text-sm font-medium text-gray-500 dark:text-gray-400">
                  {stat.title}
                </h3>
                <div className="mt-2 flex items-baseline">
                  <p className="text-2xl font-semibold text-gray-900 dark:text-white">
                    {stat.value}
                  </p>
                  <p className={`ml-2 text-sm ${
                    stat.change.startsWith('+')
                      ? 'text-green-600 dark:text-green-400'
                      : 'text-red-600 dark:text-red-400'
                  }`}>
                    {stat.change}
                  </p>
                </div>
              </Card>
            </motion.div>
          ))}
        </div>

        {/* Recent Activity */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.4 }}
        >
          <Card>
            <div className="px-6 py-4 border-b border-gray-200 dark:border-gray-700">
              <h2 className="text-lg font-medium text-gray-900 dark:text-white">
                Recent Activity
              </h2>
            </div>
            <div className="divide-y divide-gray-200 dark:divide-gray-700">
              {[
                { user: 'John Doe', action: 'Created a new ticket', time: '2 hours ago' },
                { user: 'Jane Smith', action: 'Resolved ticket #123', time: '4 hours ago' },
                { user: 'Mike Johnson', action: 'Updated system settings', time: '1 day ago' }
              ].map((activity, index) => (
                <div
                  key={index}
                  className="px-6 py-4 flex items-center justify-between"
                >
                  <div>
                    <p className="text-sm font-medium text-gray-900 dark:text-white">
                      {activity.user}
                    </p>
                    <p className="text-sm text-gray-500 dark:text-gray-400">
                      {activity.action}
                    </p>
                  </div>
                  <span className="text-sm text-gray-400 dark:text-gray-500">
                    {activity.time}
                  </span>
                </div>
              ))}
            </div>
          </Card>
        </motion.div>
      </div>
    </Layout>
  );
} 
