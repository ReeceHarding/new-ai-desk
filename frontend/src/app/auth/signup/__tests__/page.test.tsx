import React from 'react';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
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
    expect(screen.getByRole('button', { name: /create account/i })).toBeInTheDocument();
  });

  it('handles successful signup', async () => {
    const mockUser = { id: 'user123', email: 'test@example.com' };
    (supabaseClient.auth.signUp as jest.Mock).mockResolvedValueOnce({
      data: { user: mockUser },
      error: null
    });
    (supabaseClient.from as jest.Mock)().insert.mockResolvedValueOnce({
      error: null
    });

    const user = userEvent.setup();
    render(<SignupPage />);

    const emailInput = screen.getByLabelText('Email address');
    const passwordInput = screen.getByLabelText('Password');
    const roleSelect = screen.getByLabelText('Role');

    await user.type(emailInput, 'test@example.com');
    await user.type(passwordInput, 'password123');
    await user.selectOptions(roleSelect, 'customer');

    const submitButton = screen.getByRole('button', { name: /create account/i });
    await user.click(submitButton);

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
      data: { user: null },
      error: { message: errorMessage }
    });

    const user = userEvent.setup();
    render(<SignupPage />);

    const emailInput = screen.getByLabelText('Email address');
    const passwordInput = screen.getByLabelText('Password');
    const roleSelect = screen.getByLabelText('Role');

    await user.type(emailInput, 'test@example.com');
    await user.type(passwordInput, 'password123');
    await user.selectOptions(roleSelect, 'customer');

    const submitButton = screen.getByRole('button', { name: /create account/i });
    await user.click(submitButton);

    await waitFor(() => {
      expect(screen.getByText(errorMessage)).toBeInTheDocument();
    });
  });

  it('displays validation error for invalid email', async () => {
    const user = userEvent.setup();
    render(<SignupPage />);

    const emailInput = screen.getByLabelText('Email address');
    const passwordInput = screen.getByLabelText('Password');
    const roleSelect = screen.getByLabelText('Role');

    await user.type(emailInput, 'invalid-email');
    await user.type(passwordInput, 'password123');
    await user.selectOptions(roleSelect, 'customer');

    const submitButton = screen.getByRole('button', { name: /create account/i });
    await user.click(submitButton);

    expect(supabaseClient.auth.signUp).not.toHaveBeenCalled();
  });

  it('renders all form elements correctly', () => {
    render(<SignupPage />);

    // Check for main elements
    expect(screen.getByText('Create your account')).toBeInTheDocument();
    expect(screen.getByText('Smart CRM')).toBeInTheDocument();
    
    // Check for form inputs
    expect(screen.getByLabelText('Email address')).toBeInTheDocument();
    expect(screen.getByLabelText('Password')).toBeInTheDocument();
    expect(screen.getByLabelText('Role')).toBeInTheDocument();
    
    // Check for buttons
    expect(screen.getByRole('button', { name: /create account/i })).toBeInTheDocument();
  });

  it('handles form input changes', async () => {
    const user = userEvent.setup();
    render(<SignupPage />);

    // Get form elements
    const emailInput = screen.getByLabelText('Email address');
    const passwordInput = screen.getByLabelText('Password');
    const roleSelect = screen.getByLabelText('Role');

    // Test email input
    await user.type(emailInput, 'test@example.com');
    expect(emailInput).toHaveValue('test@example.com');

    // Test password input
    await user.type(passwordInput, 'password123');
    expect(passwordInput).toHaveValue('password123');

    // Test role select
    await user.selectOptions(roleSelect, 'agent');
    expect(roleSelect).toHaveValue('agent');
  });

  it('toggles password visibility', async () => {
    const user = userEvent.setup();
    render(<SignupPage />);

    const passwordInput = screen.getByLabelText('Password');
    const toggleButton = screen.getByRole('button', { name: /toggle password visibility/i });

    // Password should be hidden by default
    expect(passwordInput).toHaveAttribute('type', 'password');

    // Click toggle button to show password
    await user.click(toggleButton);
    expect(passwordInput).toHaveAttribute('type', 'text');
  });
}); 

