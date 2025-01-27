import { ReactNode } from 'react';
import { motion } from 'framer-motion';

interface CardProps {
  children: ReactNode;
  href?: string;
  className?: string;
}

export const Card = ({ children, href, className = '' }: CardProps) => {
  const Component = href ? motion.a : motion.div;

  return (
    <Component
      href={href}
      whileHover={{ y: -4 }}
      className={`
        group
        relative overflow-hidden
        rounded-2xl
        bg-gradient-to-b from-white to-slate-50
        dark:from-slate-900 dark:to-slate-800
        border border-slate-200 dark:border-slate-700
        shadow-sm hover:shadow-md
        transition-all duration-300
        ${className}
      `}
    >
      {/* Highlight effect */}
      <div
        className="
          absolute inset-0
          bg-gradient-to-r from-blue-500/0 via-blue-500/10 to-blue-500/0
          translate-x-[-100%] group-hover:translate-x-[100%]
          transition-transform duration-1000
        "
      />

      <div className="relative p-6">
        {children}
      </div>
    </Component>
  );
}; 