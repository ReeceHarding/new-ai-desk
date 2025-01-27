import { render, screen, waitFor } from '@testing-library/react';
import AdminDashboard from '../page';
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

describe('AdminDashboard', () => {
  const mockRouter = {
    push: jest.fn()
  };

  beforeEach(() => {
    (useRouter as jest.Mock).mockReturnValue(mockRouter);
    jest.clearAllMocks();
  });

  it('redirects to signin when no session exists', async () => {
    const mockSessionResponse = {
      data: { session: null },
      error: null
    };

    (supabaseClient.auth.getSession as jest.Mock).mockResolvedValueOnce(mockSessionResponse);

    render(<AdminDashboard />);

    await waitFor(() => {
      expect(mockRouter.push).toHaveBeenCalledWith('/auth/signin');
    });
  });

  it('redirects to signin when user is not an admin', async () => {
    const mockSessionResponse = {
      data: { session: { user: { id: 'test-id' } } },
      error: null
    };
    const mockRoleResponse = {
      data: { role: 'customer' },
      error: null
    };

    (supabaseClient.auth.getSession as jest.Mock).mockResolvedValueOnce(mockSessionResponse);
    const mockSingle = jest.fn().mockResolvedValueOnce(mockRoleResponse);
    const mockEq = jest.fn().mockReturnValue({ single: mockSingle });
    const mockSelect = jest.fn().mockReturnValue({ eq: mockEq });
    (supabaseClient.from as jest.Mock).mockReturnValue({ select: mockSelect });

    render(<AdminDashboard />);

    await waitFor(() => {
      expect(mockRouter.push).toHaveBeenCalledWith('/auth/signin');
    });
  });

  it('renders admin dashboard when user is admin', async () => {
    const mockSessionResponse = {
      data: { session: { user: { id: 'test-id' } } },
      error: null
    };
    const mockRoleResponse = {
      data: { role: 'admin' },
      error: null
    };

    (supabaseClient.auth.getSession as jest.Mock).mockResolvedValueOnce(mockSessionResponse);
    const mockSingle = jest.fn().mockResolvedValueOnce(mockRoleResponse);
    const mockEq = jest.fn().mockReturnValue({ single: mockSingle });
    const mockSelect = jest.fn().mockReturnValue({ eq: mockEq });
    (supabaseClient.from as jest.Mock).mockReturnValue({ select: mockSelect });

    render(<AdminDashboard />);

    await waitFor(() => {
      expect(screen.getByText('Admin Dashboard')).toBeInTheDocument();
    });
  });

  it('shows loading state initially', () => {
    (supabaseClient.auth.getSession as jest.Mock).mockImplementationOnce(
      () => new Promise(() => {}) // Never resolves to keep loading state
    );

    render(<AdminDashboard />);
    
    expect(screen.getByText('Loading...')).toBeInTheDocument();
  });
}); 