import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import SignupPage from '../page';
import { supabaseClient } from '@/utils/supabase';
import { useRouter } from 'next/navigation';

// Mock next/navigation
jest.mock('next/navigation', () => ({
  useRouter: jest.fn()
}));

// Mock supabase client
jest.mock('@/utils/supabase', () => ({
  supabaseClient: {
    auth: {
      signUp: jest.fn()
    },
    from: jest.fn(() => ({
      insert: jest.fn().mockReturnValue({
        select: jest.fn()
      })
    }))
  }
}));

describe('SignupPage', () => {
  const mockPush = jest.fn();
  
  beforeEach(() => {
    jest.clearAllMocks();
    (useRouter as jest.Mock).mockReturnValue({ push: mockPush });
  });

  it('renders signup form', () => {
    render(<SignupPage />);
    
    expect(screen.getByLabelText('Email address')).toBeInTheDocument();
    expect(screen.getByLabelText('Password')).toBeInTheDocument();
    expect(screen.getByLabelText('Role')).toBeInTheDocument();
    expect(screen.getByRole('button', { name: /sign up/i })).toBeInTheDocument();
  });

  it('handles successful signup', async () => {
    const mockUser = { id: 'user123' };
    (supabaseClient.auth.signUp as jest.Mock).mockResolvedValueOnce({
      data: { user: mockUser },
      error: null
    });
    (supabaseClient.from as jest.Mock)().insert.mockResolvedValueOnce({
      error: null
    });

    render(<SignupPage />);

    fireEvent.change(screen.getByLabelText('Email address'), {
      target: { value: 'test@example.com' }
    });
    fireEvent.change(screen.getByLabelText('Password'), {
      target: { value: 'password123' }
    });
    fireEvent.change(screen.getByLabelText('Role'), {
      target: { value: 'customer' }
    });

    const submitButton = screen.getByRole('button', { name: /sign up/i });
    fireEvent.click(submitButton);

    await waitFor(() => {
      expect(supabaseClient.auth.signUp).toHaveBeenCalledWith({
        email: 'test@example.com',
        password: 'password123'
      });
      expect(supabaseClient.from).toHaveBeenCalledWith('users');
      expect(mockPush).toHaveBeenCalledWith('/auth/signin');
    });
  });

  it('displays error message on signup failure', async () => {
    const errorMessage = 'Signup failed';
    (supabaseClient.auth.signUp as jest.Mock).mockResolvedValueOnce({
      data: null,
      error: { message: errorMessage }
    });

    render(<SignupPage />);

    fireEvent.change(screen.getByLabelText('Email address'), {
      target: { value: 'test@example.com' }
    });
    fireEvent.change(screen.getByLabelText('Password'), {
      target: { value: 'password123' }
    });
    fireEvent.change(screen.getByLabelText('Role'), {
      target: { value: 'customer' }
    });

    const submitButton = screen.getByRole('button', { name: /sign up/i });
    fireEvent.click(submitButton);

    await waitFor(() => {
      expect(screen.getByRole('heading', { name: errorMessage })).toBeInTheDocument();
    });
  });

  it('displays validation error for invalid email', async () => {
    render(<SignupPage />);

    fireEvent.change(screen.getByLabelText('Email address'), {
      target: { value: 'invalid-email' }
    });
    fireEvent.change(screen.getByLabelText('Password'), {
      target: { value: 'password123' }
    });
    
    const submitButton = screen.getByRole('button', { name: /sign up/i });
    fireEvent.click(submitButton);

    expect(supabaseClient.auth.signUp).not.toHaveBeenCalled();
  });
}); 

