import './globals.css';
import { ReactNode } from 'react';

export const metadata = {
  title: 'Smart CRM & Outreach',
  description: 'A multi-role platform with tickets, marketing, outreach, etc.'
};

export default function RootLayout({ children }: { children: ReactNode }) {
  return (
    <html lang="en">
      <body>
        {children}
      </body>
    </html>
  );
}
