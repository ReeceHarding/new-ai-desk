import Link from 'next/link';
import { motion } from 'framer-motion';
import { Button } from '@/components/ui/Button';
import { Card } from '@/components/ui/Card';
import { Layout } from '@/components/ui/Layout';

export default function LandingPage() {
  return (
    <Layout>
      <div className="space-y-24">
        {/* Hero Section */}
        <section className="relative">
          {/* Background gradient */}
          <div className="absolute inset-0 bg-gradient-to-b from-blue-50 to-white dark:from-slate-800 dark:to-slate-900 -z-10" />
          
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 md:py-20 lg:py-24">
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.6 }}
              className="text-center space-y-8"
            >
              <h1 className="text-4xl sm:text-5xl lg:text-6xl font-extrabold text-gray-900 dark:text-white">
                Smart CRM for
                <span className="text-transparent bg-clip-text bg-gradient-to-r from-blue-500 to-blue-700">
                  {' '}Modern Teams
                </span>
              </h1>
              <p className="max-w-2xl mx-auto text-xl sm:text-2xl text-gray-600 dark:text-gray-300">
                Streamline your customer support with AI-powered insights and seamless collaboration tools.
              </p>
              <div className="flex flex-col sm:flex-row gap-4 justify-center">
                <Button size="lg" variant="primary">
                  Get Started Free
                </Button>
                <Button size="lg" variant="secondary">
                  Book a Demo
                </Button>
              </div>
            </motion.div>
          </div>
        </section>

        {/* Features Section */}
        <section className="py-12">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.6 }}
              className="text-center mb-16"
            >
              <h2 className="text-3xl sm:text-4xl font-bold text-gray-900 dark:text-white">
                Why Choose Smart CRM?
              </h2>
              <p className="mt-4 text-xl text-gray-600 dark:text-gray-300">
                Everything you need to deliver exceptional customer support
              </p>
            </motion.div>

            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
              {[
                {
                  title: 'AI-Powered Insights',
                  description: 'Leverage machine learning to understand customer needs and automate responses.',
                  icon: '🤖'
                },
                {
                  title: 'Seamless Integration',
                  description: 'Connect with your favorite tools and services without any hassle.',
                  icon: '🔄'
                },
                {
                  title: 'Real-time Analytics',
                  description: 'Track performance metrics and customer satisfaction in real-time.',
                  icon: '📊'
                },
                {
                  title: 'Team Collaboration',
                  description: 'Work together efficiently with built-in communication tools.',
                  icon: '👥'
                },
                {
                  title: 'Custom Workflows',
                  description: 'Create and automate workflows that match your business needs.',
                  icon: '⚡'
                },
                {
                  title: 'Secure & Reliable',
                  description: 'Enterprise-grade security with 99.9% uptime guarantee.',
                  icon: '🔒'
                }
              ].map((feature, index) => (
                <motion.div
                  key={feature.title}
                  initial={{ opacity: 0, y: 20 }}
                  whileInView={{ opacity: 1, y: 0 }}
                  viewport={{ once: true }}
                  transition={{ delay: index * 0.1 }}
                >
                  <Card className="h-full">
                    <div className="text-center">
                      <span className="text-4xl mb-4 block">{feature.icon}</span>
                      <h3 className="text-xl font-semibold text-gray-900 dark:text-white mb-2">
                        {feature.title}
                      </h3>
                      <p className="text-gray-600 dark:text-gray-300">
                        {feature.description}
                      </p>
                    </div>
                  </Card>
                </motion.div>
              ))}
            </div>
          </div>
        </section>

        {/* CTA Section */}
        <section className="relative py-16">
          {/* Background gradient */}
          <div className="absolute inset-0 bg-gradient-to-r from-blue-500 to-blue-700 -z-10" />
          
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center"
          >
            <h2 className="text-3xl sm:text-4xl font-bold text-white mb-8">
              Ready to transform your customer support?
            </h2>
            <div className="flex flex-col sm:flex-row gap-4 justify-center">
              <Link href="/auth/signup">
                <Button size="lg" variant="secondary">
                  Start Free Trial
                </Button>
              </Link>
              <Button size="lg" variant="primary">
                Contact Sales
              </Button>
            </div>
          </motion.div>
        </section>
      </div>
    </Layout>
  );
}
