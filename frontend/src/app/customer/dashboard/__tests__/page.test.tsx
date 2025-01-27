import { render, screen, waitFor, act } from '@testing-library/react';
import CustomerDashboard from '../page';
import { supabaseClient } from '@/utils/supabase';
import { useRouter } from 'next/navigation';

jest.mock('next/navigation', () => ({
  useRouter: jest.fn()
}));

jest.mock('@/utils/supabase', () => ({
  supabaseClient: {
    auth: {
      getSession: jest.fn()
    },
    from: jest.fn(() => ({
      select: jest.fn(() => ({
        eq: jest.fn(() => ({
          single: jest.fn()
        }))
      }))
    }))
  }
}));

describe('CustomerDashboard', () => {
  const mockRouter = {
    push: jest.fn()
  };

  beforeEach(() => {
    jest.clearAllMocks();
    (useRouter as jest.Mock).mockReturnValue(mockRouter);
  });

  it('redirects to signin when no session exists', async () => {
    (supabaseClient.auth.getSession as jest.Mock).mockResolvedValue({
      data: { session: null },
      error: null
    });

    await act(async () => {
      render(<CustomerDashboard />);
    });

    expect(mockRouter.push).toHaveBeenCalledWith('/auth/signin');
  });

  it('redirects to signin when user is not a customer', async () => {
    (supabaseClient.auth.getSession as jest.Mock).mockResolvedValue({
      data: { session: { user: { id: '123' } } },
      error: null
    });

    (supabaseClient.from as jest.Mock).mockReturnValue({
      select: jest.fn().mockReturnValue({
        eq: jest.fn().mockReturnValue({
          single: jest.fn().mockResolvedValue({
            data: { role: 'agent' },
            error: null
          })
        })
      })
    });

    render(<CustomerDashboard />);

    await waitFor(() => {
      expect(mockRouter.push).toHaveBeenCalledWith('/auth/signin');
    });
  });

  it('renders customer dashboard when user is customer', async () => {
    (supabaseClient.auth.getSession as jest.Mock).mockResolvedValue({
      data: { session: { user: { id: '123' } } },
      error: null
    });

    (supabaseClient.from as jest.Mock).mockReturnValue({
      select: jest.fn().mockReturnValue({
        eq: jest.fn().mockReturnValue({
          single: jest.fn().mockResolvedValue({
            data: { role: 'customer' },
            error: null
          })
        })
      })
    });

    render(<CustomerDashboard />);

    await waitFor(() => {
      expect(screen.getByText('Customer Dashboard')).toBeInTheDocument();
      expect(screen.getByText('View and manage your support tickets')).toBeInTheDocument();
      expect(screen.getByText('Create New Ticket')).toBeInTheDocument();
      expect(screen.getByText('Knowledge Base')).toBeInTheDocument();
      expect(screen.getByText('Your Tickets')).toBeInTheDocument();
    });
  });

  it('shows loading state initially', async () => {
    (supabaseClient.auth.getSession as jest.Mock).mockImplementationOnce(() => 
      new Promise(() => {})
    );

    render(<CustomerDashboard />);
    expect(screen.getByText('Loading...')).toBeInTheDocument();
  });
}); 
