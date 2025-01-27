import Link from 'next/link';
import { Button } from '@/components/ui/Button';
import { Card } from '@/components/ui/Card';
import { Layout } from '@/components/ui/Layout';
import { MotionWrapper } from '@/components/ui/MotionWrapper';

export default function LandingPage() {
  return (
    <Layout>
      {/* Hero Section */}
      <section className="relative min-h-[90vh] bg-[#4B1E91] overflow-hidden">
        {/* Background shapes */}
        <div className="absolute bottom-0 left-0 w-[40vw] h-[40vw] bg-[#45E3C6] rounded-full opacity-90 blur-3xl -translate-x-1/2 translate-y-1/2" />
        <div className="absolute top-0 right-0 w-[50vw] h-[50vw] bg-[#6B2EB3] rounded-full opacity-80 blur-3xl translate-x-1/2 -translate-y-1/2" />
        
        <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pt-32 pb-24">
          <MotionWrapper
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6 }}
            className="text-center space-y-8"
          >
            <h1 className="heading-1 text-white max-w-5xl mx-auto leading-tight">
              Get measurable results from customer support
            </h1>
            <p className="body-lg text-white/80 max-w-3xl mx-auto">
              Do ticket management, customer analytics, AI automation, and team collaboration from just one platform.
            </p>
            <div className="max-w-2xl mx-auto pt-8">
              <div className="flex items-center bg-white rounded-lg p-2">
                <input
                  type="email"
                  placeholder="Enter your work email"
                  className="flex-1 px-4 py-3 text-lg border-0 focus:outline-none text-gray-800"
                />
                <Link href="/auth/signup">
                  <Button size="lg" variant="primary" className="bg-[#FF622D] hover:bg-[#FF4500] shadow-none text-lg px-8">
                    Start now
                  </Button>
                </Link>
              </div>
            </div>
          </MotionWrapper>
        </div>
      </section>

      {/* Trusted By Section */}
      <section className="py-16 bg-white">
        <div className="container-xl">
          <p className="text-center text-gray-600 mb-12">Trusted by the world's leading brands</p>
          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-8 items-center justify-items-center opacity-70">
            <img src="/logos/tesla.svg" alt="Tesla" className="h-8" />
            <img src="/logos/samsung.svg" alt="Samsung" className="h-8" />
            <img src="/logos/apple.svg" alt="Apple" className="h-8" />
            <img src="/logos/microsoft.svg" alt="Microsoft" className="h-8" />
            <img src="/logos/amazon.svg" alt="Amazon" className="h-8" />
            <img src="/logos/google.svg" alt="Google" className="h-8" />
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section className="py-24 bg-gray-50">
        <div className="container-xl">
          <MotionWrapper
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            className="text-center mb-20"
          >
            <h2 className="heading-2 text-gray-900 mb-6">
              See what's inside
            </h2>
          </MotionWrapper>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {[
              {
                title: 'AI-Powered Support',
                description: 'Automate responses and get insights from customer conversations',
                icon: '🤖',
                color: 'from-purple-500 to-purple-600'
              },
              {
                title: 'Analytics Dashboard',
                description: 'Track metrics and visualize customer satisfaction trends',
                icon: '📊',
                color: 'from-blue-500 to-blue-600'
              },
              {
                title: 'Team Collaboration',
                description: 'Work together seamlessly with built-in tools',
                icon: '👥',
                color: 'from-green-500 to-green-600'
              }
            ].map((feature, index) => (
              <MotionWrapper
                key={feature.title}
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ delay: index * 0.1 }}
              >
                <Card className="h-full hover:shadow-xl transition-shadow duration-300">
                  <div className="text-center space-y-4">
                    <div className={`inline-flex items-center justify-center w-16 h-16 rounded-full bg-gradient-to-r ${feature.color} text-white text-3xl`}>
                      {feature.icon}
                    </div>
                    <h3 className="text-xl font-bold text-gray-900">
                      {feature.title}
                    </h3>
                    <p className="text-gray-600">
                      {feature.description}
                    </p>
                  </div>
                </Card>
              </MotionWrapper>
            ))}
          </div>
        </div>
      </section>

      {/* Stats Section */}
      <section className="py-24 bg-[#4B1E91] relative overflow-hidden">
        <div className="absolute inset-0 bg-[url('/grid-pattern.svg')] opacity-10" />
        <div className="container-xl relative">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-12">
            <div className="text-center">
              <div className="text-5xl font-bold text-white mb-4">10M+</div>
              <p className="text-white/80">Support tickets managed</p>
            </div>
            <div className="text-center">
              <div className="text-5xl font-bold text-white mb-4">99.9%</div>
              <p className="text-white/80">Uptime guarantee</p>
            </div>
            <div className="text-center">
              <div className="text-5xl font-bold text-white mb-4">24/7</div>
              <p className="text-white/80">Customer support</p>
            </div>
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-24 bg-white">
        <MotionWrapper
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          className="container-md text-center"
        >
          <h2 className="heading-2 text-gray-900 mb-8">
            Ready to transform your customer support?
          </h2>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Link href="/auth/signup">
              <Button size="lg" variant="primary" className="bg-[#FF622D] hover:bg-[#FF4500] shadow-none text-lg px-12">
                Start Free Trial
              </Button>
            </Link>
            <Link href="/contact">
              <Button size="lg" variant="secondary" className="text-lg px-12">
                Schedule Demo
              </Button>
            </Link>
          </div>
        </MotionWrapper>
      </section>
    </Layout>
  );
}
