'use client';

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { Button } from '@/components/ui/Button';
import { Card } from '@/components/ui/Card';
import { Layout } from '@/components/ui/Layout';
import { MotionWrapper } from '@/components/ui/MotionWrapper';
import { supabaseClient } from '@/utils/supabase';

export default function AgentDashboard() {
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

        // Check if user is agent
        const { data, error: roleError } = await supabaseClient
          .from('users')
          .select('role')
          .eq('id', session.user.id)
          .single();

        if (roleError || !data || data.role !== 'agent') {
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
      <div className="space-y-8">
        {/* Header */}
        <MotionWrapper
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
          className="text-center"
        >
          <h1 className="text-3xl font-bold text-gray-900 dark:text-white">
            Agent Dashboard
          </h1>
          <p className="mt-2 text-gray-600 dark:text-gray-300">
            Manage customer tickets and support requests
          </p>
        </MotionWrapper>

        {/* Stats Grid */}
        <MotionWrapper
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5, delay: 0.2 }}
        >
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            {[
              { title: 'Active Tickets', value: '12', status: 'normal' },
              { title: 'Urgent Tickets', value: '3', status: 'urgent' },
              { title: 'Resolved Today', value: '8', status: 'success' }
            ].map((stat, index) => (
              <MotionWrapper
                key={stat.title}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: index * 0.1 }}
              >
                <Card className="p-6">
                  <h3 className="text-sm font-medium text-gray-500 dark:text-gray-400">
                    {stat.title}
                  </h3>
                  <p className={`mt-2 text-3xl font-bold ${
                    stat.status === 'urgent'
                      ? 'text-red-600 dark:text-red-400'
                      : stat.status === 'success'
                      ? 'text-green-600 dark:text-green-400'
                      : 'text-gray-900 dark:text-white'
                  }`}>
                    {stat.value}
                  </p>
                </Card>
              </MotionWrapper>
            ))}
          </div>
        </MotionWrapper>

        {/* Ticket Queue */}
        <MotionWrapper
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5, delay: 0.4 }}
        >
          <Card>
            <div className="px-6 py-4 border-b border-gray-200 dark:border-gray-700 flex justify-between items-center">
              <h2 className="text-lg font-medium text-gray-900 dark:text-white">
                Ticket Queue
              </h2>
              <Button variant="secondary" size="sm">
                View All
              </Button>
            </div>
            <div className="divide-y divide-gray-200 dark:divide-gray-700">
              {[
                {
                  id: 'T-123',
                  customer: 'John Doe',
                  subject: 'Login Issues',
                  priority: 'High',
                  time: '10 min ago'
                },
                {
                  id: 'T-124',
                  customer: 'Jane Smith',
                  subject: 'Payment Failed',
                  priority: 'Medium',
                  time: '1 hour ago'
                },
                {
                  id: 'T-125',
                  customer: 'Mike Johnson',
                  subject: 'Feature Request',
                  priority: 'Low',
                  time: '2 hours ago'
                }
              ].map((ticket) => (
                <div
                  key={ticket.id}
                  className="px-6 py-4 hover:bg-gray-50 dark:hover:bg-slate-700/50 transition-colors"
                >
                  <div className="flex items-center justify-between">
                    <div className="flex items-center space-x-4">
                      <span className="text-sm font-medium text-gray-900 dark:text-white">
                        {ticket.id}
                      </span>
                      <span className="text-sm text-gray-500 dark:text-gray-400">
                        {ticket.customer}
                      </span>
                    </div>
                    <span className={`text-sm px-2 py-1 rounded-full ${
                      ticket.priority === 'High'
                        ? 'bg-red-100 text-red-800 dark:bg-red-900/50 dark:text-red-300'
                        : ticket.priority === 'Medium'
                        ? 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900/50 dark:text-yellow-300'
                        : 'bg-green-100 text-green-800 dark:bg-green-900/50 dark:text-green-300'
                    }`}>
                      {ticket.priority}
                    </span>
                  </div>
                  <p className="mt-2 text-sm text-gray-600 dark:text-gray-300">
                    {ticket.subject}
                  </p>
                  <p className="mt-1 text-xs text-gray-400 dark:text-gray-500">
                    {ticket.time}
                  </p>
                </div>
              ))}
            </div>
          </Card>
        </MotionWrapper>
      </div>
    </Layout>
  );
} 
