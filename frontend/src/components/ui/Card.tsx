'use client';

import { ReactNode } from 'react';
import { MotionWrapper } from './MotionWrapper';
import Link from 'next/link';

interface CardProps {
  children: ReactNode;
  className?: string;
  href?: string;
}

export const Card = ({ children, className = '', href }: CardProps) => {
  const content = (
    <div className={`
      relative overflow-hidden
      bg-white
      border border-gray-100
      rounded-2xl
      p-8
      ${className}
    `}>
      <div className="relative">
        {children}
      </div>
    </div>
  );

  return (
    <MotionWrapper
      whileHover={{ 
        y: -4,
        boxShadow: '0 25px 50px -12px rgba(75, 30, 145, 0.15)'
      }}
      transition={{ duration: 0.2 }}
    >
      {href ? (
        <Link href={href} className="block">
          {content}
        </Link>
      ) : (
        content
      )}
    </MotionWrapper>
  );
}; 