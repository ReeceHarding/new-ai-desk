import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import { useRouter } from 'next/navigation';
import SigninPage from '../page';
import { supabaseClient, getUserRole } from '@/utils/supabase';

// Mock next/navigation
jest.mock('next/navigation', () => ({
  useRouter: jest.fn()
}));

// Mock supabase client and getUserRole
jest.mock('@/utils/supabase', () => ({
  supabaseClient: {
    auth: {
      signInWithPassword: jest.fn()
    }
  },
  getUserRole: jest.fn()
}));

describe('SigninPage', () => {
  const mockRouter = {
    push: jest.fn()
  };

  beforeEach(() => {
    jest.clearAllMocks();
    (useRouter as jest.Mock).mockReturnValue(mockRouter);
  });

  it('renders signin form', () => {
    render(<SigninPage />);
    
    expect(screen.getByLabelText('Email address')).toBeInTheDocument();
    expect(screen.getByLabelText('Password')).toBeInTheDocument();
    expect(screen.getByRole('button', { name: /sign in/i })).toBeInTheDocument();
  });

  it('handles successful signin', async () => {
    const mockUser = { id: 'user123' };
    (supabaseClient.auth.signInWithPassword as jest.Mock).mockResolvedValueOnce({
      data: { user: mockUser },
      error: null
    });
    (getUserRole as jest.Mock).mockResolvedValueOnce('customer');

    render(<SigninPage />);

    fireEvent.change(screen.getByLabelText('Email address'), {
      target: { value: 'test@example.com' }
    });
    fireEvent.change(screen.getByLabelText('Password'), {
      target: { value: 'password123' }
    });

    const submitButton = screen.getByRole('button', { name: /sign in/i });
    fireEvent.click(submitButton);

    await waitFor(() => {
      expect(supabaseClient.auth.signInWithPassword).toHaveBeenCalledWith({
        email: 'test@example.com',
        password: 'password123'
      });
      expect(mockRouter.push).toHaveBeenCalledWith('/customer/dashboard');
    });
  });

  it('displays error message on signin failure', async () => {
    const errorMessage = 'Invalid login credentials';
    (supabaseClient.auth.signInWithPassword as jest.Mock).mockResolvedValueOnce({
      data: { user: null },
      error: { message: errorMessage }
    });

    render(<SigninPage />);

    fireEvent.change(screen.getByLabelText('Email address'), {
      target: { value: 'test@example.com' }
    });
    fireEvent.change(screen.getByLabelText('Password'), {
      target: { value: 'password123' }
    });

    const submitButton = screen.getByRole('button', { name: /sign in/i });
    fireEvent.click(submitButton);

    await waitFor(() => {
      expect(screen.getByText(errorMessage)).toBeInTheDocument();
    });
  });

  it('handles role fetch error', async () => {
    const mockUser = { id: 'user123' };
    (supabaseClient.auth.signInWithPassword as jest.Mock).mockResolvedValueOnce({
      data: { user: mockUser },
      error: null
    });
    (getUserRole as jest.Mock).mockRejectedValueOnce(new Error('Failed to fetch role'));

    render(<SigninPage />);

    fireEvent.change(screen.getByLabelText('Email address'), {
      target: { value: 'test@example.com' }
    });
    fireEvent.change(screen.getByLabelText('Password'), {
      target: { value: 'password123' }
    });

    const submitButton = screen.getByRole('button', { name: /sign in/i });
    fireEvent.click(submitButton);

    await waitFor(() => {
      expect(screen.getByText('An unexpected error occurred')).toBeInTheDocument();
    });
  });
}); 

