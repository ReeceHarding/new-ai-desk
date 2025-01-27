'use client';

import { motion } from 'framer-motion';
import { ReactNode } from 'react';

interface MotionWrapperProps {
  children: ReactNode;
  className?: string;
  initial?: any;
  animate?: any;
  exit?: any;
  transition?: any;
  whileInView?: any;
  viewport?: any;
  whileHover?: any;
  whileTap?: any;
  whileFocus?: any;
}

export const MotionWrapper = ({ 
  children, 
  className,
  initial,
  animate,
  exit,
  transition,
  whileInView,
  viewport,
  whileHover,
  whileTap,
  whileFocus,
}: MotionWrapperProps) => {
  return (
    <motion.div
      className={className}
      initial={initial}
      animate={animate}
      exit={exit}
      transition={transition}
      whileInView={whileInView}
      viewport={viewport}
      whileHover={whileHover}
      whileTap={whileTap}
      whileFocus={whileFocus}
    >
      {children}
    </motion.div>
  );
}; 
