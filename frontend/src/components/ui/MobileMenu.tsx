'use client';

import Link from 'next/link';
import { Button } from './Button';

interface MobileMenuProps {
  isOpen: boolean;
  navigation: Array<{
    name: string;
    href: string;
  }>;
}

export const MobileMenu = ({ isOpen, navigation }: MobileMenuProps) => {
  return (
    <div 
      className={`
        md:hidden
        transition-all duration-300 ease-in-out
        ${isOpen ? 'opacity-100 max-h-96' : 'opacity-0 max-h-0 overflow-hidden'}
      `}
    >
      <div className="px-4 pt-2 pb-3 space-y-1 bg-white border-t border-gray-100">
        {navigation.map((item) => (
          <Link
            key={item.name}
            href={item.href}
            className="block px-3 py-2 text-base font-medium text-gray-700 hover:text-[#4B1E91] transition-colors duration-200"
          >
            {item.name}
          </Link>
        ))}
        <div className="pt-4 space-y-2">
          <Link href="/auth/signin" className="block w-full">
            <Button variant="secondary" className="w-full">Log In</Button>
          </Link>
          <Link href="/auth/signup" className="block w-full">
            <Button variant="primary" className="w-full bg-[#FF622D] hover:bg-[#FF4500]">Sign Up</Button>
          </Link>
        </div>
      </div>
    </div>
  );
}; 
