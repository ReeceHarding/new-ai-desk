import { ButtonHTMLAttributes, ReactNode } from 'react';
import { motion } from 'framer-motion';
import { LoadingSpinner } from './LoadingSpinner';

interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: 'primary' | 'secondary';
  size?: 'sm' | 'md' | 'lg';
  loading?: boolean;
  children: ReactNode;
}

export const Button = ({
  variant = 'primary',
  size = 'md',
  loading = false,
  children,
  className = '',
  disabled,
  ...props
}: ButtonProps) => {
  const baseStyles = `
    relative
    inline-flex items-center justify-center
    rounded-lg
    font-medium
    transition-all duration-300
    focus:outline-none focus:ring-2 focus:ring-offset-2
    disabled:opacity-50 disabled:cursor-not-allowed
  `;

  const variants = {
    primary: `
      bg-gradient-to-r from-blue-500 to-blue-600
      hover:from-blue-600 hover:to-blue-700
      text-white
      shadow-lg shadow-blue-500/25
      hover:shadow-xl hover:shadow-blue-500/30
      focus:ring-blue-500
    `,
    secondary: `
      bg-white dark:bg-slate-800
      text-slate-900 dark:text-white
      border border-slate-200 dark:border-slate-700
      hover:bg-slate-50 dark:hover:bg-slate-700
      focus:ring-slate-500
    `
  };

  const sizes = {
    sm: 'px-3 py-1.5 text-sm',
    md: 'px-4 py-2 text-base',
    lg: 'px-6 py-3 text-lg'
  };

  return (
    <motion.button
      whileHover={{ scale: 1.02 }}
      whileTap={{ scale: 0.98 }}
      className={`${baseStyles} ${variants[variant]} ${sizes[size]} ${className}`}
      disabled={disabled || loading}
      {...props}
    >
      {loading && (
        <div className="absolute inset-0 flex items-center justify-center">
          <LoadingSpinner />
        </div>
      )}
      <span className={loading ? 'opacity-0' : ''}>
        {children}
      </span>
    </motion.button>
  );
}; 