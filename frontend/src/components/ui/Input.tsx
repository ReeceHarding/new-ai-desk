'use client';

import { InputHTMLAttributes } from 'react';
import { MotionWrapper } from './MotionWrapper';

interface InputProps extends InputHTMLAttributes<HTMLInputElement> {
  label?: string;
  error?: string;
}

export const Input = ({ label, error, id, className = '', ...props }: InputProps) => {
  return (
    <div className="space-y-1">
      {label && (
        <label htmlFor={id} className="block text-sm font-medium text-gray-700 dark:text-gray-200">
          {label}
        </label>
      )}
      <MotionWrapper
        whileFocus={{ scale: 1.01 }}
        transition={{ duration: 0.2 }}
      >
        <input
          id={id}
          className={`
            block w-full px-3 py-2
            border border-gray-300 dark:border-gray-700
            rounded-md shadow-sm
            text-gray-900 dark:text-white
            bg-white dark:bg-slate-800
            focus:ring-2 focus:ring-blue-500 focus:border-blue-500
            ${error ? 'border-red-500' : ''}
            ${className}
          `}
          {...props}
        />
      </MotionWrapper>
      {error && (
        <p className="text-sm text-red-600 dark:text-red-500">{error}</p>
      )}
    </div>
  );
}; 
