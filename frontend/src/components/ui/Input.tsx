import { InputHTMLAttributes, forwardRef } from 'react';
import { motion } from 'framer-motion';

interface InputProps extends InputHTMLAttributes<HTMLInputElement> {
  label?: string;
  error?: string;
}

export const Input = forwardRef<HTMLInputElement, InputProps>(
  ({ label, error, className = '', id, ...props }, ref) => {
    // Generate a unique ID if none is provided
    const inputId = id || `input-${label?.toLowerCase().replace(/\s+/g, '-')}`;

    return (
      <div className="group relative">
        <motion.div
          className=" absolute inset-0 rounded-lg ring-2 ring-blue-500/50 pointer-events-none "
          initial={{ opacity: 0, scale: 1.05 }}
          animate={{ opacity: error ? 1 : 0, scale: 1 }}
          transition={{ duration: 0.2 }}
        />
        <input
          ref={ref}
          id={inputId}
          className={`
              w-full
              px-4 py-2
              rounded-lg
              bg-white dark:bg-slate-800
              border border-slate-200 dark:border-slate-700
              text-slate-900 dark:text-white
              placeholder-slate-400
              transition-all duration-300
              focus:outline-none
              ${error ? 'border-red-500' : ''}
              ${className}
            `}
          {...props}
        />
        {label && (
          <label
            htmlFor={inputId}
            className={`
                absolute left-4 -top-2.5
                px-1 bg-white dark:bg-slate-800
                text-sm
                transition-all duration-300
                ${error ? 'text-red-500' : 'text-slate-400'}
                ${props.value ? 'scale-75' : ''}
              `}
          >
            {label}
          </label>
        )}
        {error && (
          <motion.p
            initial={{ opacity: 0, y: -10 }}
            animate={{ opacity: 1, y: 0 }}
            className="mt-1 text-sm text-red-500"
          >
            {error}
          </motion.p>
        )}
      </div>
    );
  }
); 
