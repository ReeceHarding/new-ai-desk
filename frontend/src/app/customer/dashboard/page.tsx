'use client';

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { motion } from 'framer-motion';
import { supabaseClient } from '@/utils/supabase';
import { Card } from '@/components/ui/Card';
import { Button } from '@/components/ui/Button';
import { Layout } from '@/components/ui/Layout';

export default function CustomerDashboard() {
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

        // Check if user is customer
        const { data, error: roleError } = await supabaseClient
          .from('users')
          .select('role')
          .eq('id', session.user.id)
          .single();

        if (roleError || !data || data.role !== 'customer') {
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
            Customer Dashboard
          </h1>
          <p className="mt-2 text-gray-600 dark:text-gray-300">
            View and manage your support tickets
          </p>
        </motion.div>

        {/* Quick Actions */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.1 }}
          >
            <Card className="p-6">
              <h3 className="text-lg font-medium text-gray-900 dark:text-white">
                Create New Ticket
              </h3>
              <p className="mt-2 text-sm text-gray-600 dark:text-gray-300">
                Need help? Submit a new support ticket and we'll get back to you shortly.
              </p>
              <Button className="mt-4" variant="primary">
                Submit Ticket
              </Button>
            </Card>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.2 }}
          >
            <Card className="p-6">
              <h3 className="text-lg font-medium text-gray-900 dark:text-white">
                Knowledge Base
              </h3>
              <p className="mt-2 text-sm text-gray-600 dark:text-gray-300">
                Browse our documentation and FAQs to find quick answers to common questions.
              </p>
              <Button className="mt-4" variant="secondary">
                View Articles
              </Button>
            </Card>
          </motion.div>
        </div>

        {/* Ticket History */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3 }}
        >
          <Card>
            <div className="px-6 py-4 border-b border-gray-200 dark:border-gray-700">
              <h2 className="text-lg font-medium text-gray-900 dark:text-white">
                Your Tickets
              </h2>
            </div>
            <div className="divide-y divide-gray-200 dark:divide-gray-700">
              {[
                {
                  id: 'T-789',
                  subject: 'Account Access Issue',
                  status: 'Open',
                  lastUpdate: '2 hours ago',
                  priority: 'High'
                },
                {
                  id: 'T-790',
                  subject: 'Billing Question',
                  status: 'In Progress',
                  lastUpdate: '1 day ago',
                  priority: 'Medium'
                },
                {
                  id: 'T-791',
                  subject: 'Feature Suggestion',
                  status: 'Closed',
                  lastUpdate: '3 days ago',
                  priority: 'Low'
                }
              ].map((ticket) => (
                <div
                  key={ticket.id}
                  className="px-6 py-4 hover:bg-gray-50 dark:hover:bg-slate-700/50 transition-colors"
                >
                  <div className="flex items-center justify-between">
                    <div>
                      <div className="flex items-center space-x-3">
                        <span className="text-sm font-medium text-gray-900 dark:text-white">
                          {ticket.id}
                        </span>
                        <span className={`text-xs px-2 py-1 rounded-full ${
                          ticket.status === 'Open'
                            ? 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900/50 dark:text-yellow-300'
                            : ticket.status === 'In Progress'
                            ? 'bg-blue-100 text-blue-800 dark:bg-blue-900/50 dark:text-blue-300'
                            : 'bg-green-100 text-green-800 dark:bg-green-900/50 dark:text-green-300'
                        }`}>
                          {ticket.status}
                        </span>
                      </div>
                      <p className="mt-1 text-sm text-gray-600 dark:text-gray-300">
                        {ticket.subject}
                      </p>
                    </div>
                    <div className="text-right">
                      <p className="text-xs text-gray-400 dark:text-gray-500">
                        Last updated: {ticket.lastUpdate}
                      </p>
                      <span className={`mt-1 inline-block text-xs px-2 py-1 rounded-full ${
                        ticket.priority === 'High'
                          ? 'bg-red-100 text-red-800 dark:bg-red-900/50 dark:text-red-300'
                          : ticket.priority === 'Medium'
                          ? 'bg-orange-100 text-orange-800 dark:bg-orange-900/50 dark:text-orange-300'
                          : 'bg-green-100 text-green-800 dark:bg-green-900/50 dark:text-green-300'
                      }`}>
                        {ticket.priority} Priority
                      </span>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </Card>
        </motion.div>
      </div>
    </Layout>
  );
} 
