import { render, screen, waitFor, act } from '@testing-library/react';
import { useRouter } from 'next/navigation';
import AgentDashboard from '../page';
import { supabaseClient } from '@/utils/supabase';

// Mock next/navigation
jest.mock('next/navigation', () => ({
  useRouter: jest.fn()
}));

// Mock supabase client
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

describe('AgentDashboard', () => {
  const mockRouter = {
    push: jest.fn()
  };

  beforeEach(() => {
    jest.clearAllMocks();
    (useRouter as jest.Mock).mockReturnValue(mockRouter);
  });

  it('redirects to signin when no session exists', async () => {
    // Mock no session
    (supabaseClient.auth.getSession as jest.Mock).mockResolvedValue({
      data: { session: null },
      error: null
    });

    await act(async () => {
      render(<AgentDashboard />);
    });

    await waitFor(() => {
      expect(mockRouter.push).toHaveBeenCalledWith('/auth/signin');
    });
  });

  it('redirects to signin when user is not an agent', async () => {
    // Mock session but non-agent role
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

    render(<AgentDashboard />);

    await waitFor(() => {
      expect(mockRouter.push).toHaveBeenCalledWith('/auth/signin');
    });
  });

  it('renders agent dashboard when user is agent', async () => {
    // Mock valid session and agent role
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

    await act(async () => {
      render(<AgentDashboard />);
    });

    await waitFor(() => {
      // Check for new UI elements
      expect(screen.getByText('Agent Dashboard')).toBeInTheDocument();
      expect(screen.getByText('Manage customer tickets and support requests')).toBeInTheDocument();
      expect(screen.getByText('Active Tickets')).toBeInTheDocument();
      expect(screen.getByText('Urgent Tickets')).toBeInTheDocument();
      expect(screen.getByText('Resolved Today')).toBeInTheDocument();
      expect(screen.getByText('Ticket Queue')).toBeInTheDocument();
    });
  });

  it('shows loading state initially', async () => {
    (supabaseClient.auth.getSession as jest.Mock).mockImplementationOnce(() => 
      new Promise(() => {})
    );

    render(<AgentDashboard />);
    expect(screen.getByText('Loading...')).toBeInTheDocument();
  });
}); 
