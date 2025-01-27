import '@testing-library/jest-dom';
import React from 'react';

// Mock environment variables
process.env.NEXT_PUBLIC_SUPABASE_URL = 'https://test.supabase.co';
process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY = 'test-key';

// Mock next/navigation
jest.mock('next/navigation', () => ({
  useRouter() {
    return {
      push: jest.fn(),
      replace: jest.fn(),
      prefetch: jest.fn(),
    };
  },
  useSearchParams() {
    return new URLSearchParams();
  },
}));

// Mock next/link
jest.mock('next/link', () => {
  const Link = ({ children, ...props }) => {
    return React.createElement('a', props, children);
  };
  return Link;
});

// Mock framer-motion
jest.mock('framer-motion', () => {
  const motionComponent = ({ children, ...props }) => {
    // Filter out motion-specific props
    const filteredProps = Object.fromEntries(
      Object.entries(props).filter(([key]) => !key.startsWith('while') && !key.startsWith('animate') && !key.startsWith('initial') && !key.startsWith('exit') && !key.startsWith('transition'))
    );
    return React.createElement('div', filteredProps, children);
  };

  return {
    motion: new Proxy({}, {
      get: () => motionComponent,
    }),
    AnimatePresence: ({ children }) => children,
  };
}); 
