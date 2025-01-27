import { supabaseClient, getUserRole } from '../supabase';
import { PostgrestFilterBuilder, PostgrestSingleResponse } from '@supabase/postgrest-js';

// Mock the Supabase client
jest.mock('@supabase/supabase-js', () => ({
  createClient: jest.fn(() => ({
    from: jest.fn(() => ({
      select: jest.fn(() => ({
        eq: jest.fn(() => ({
          single: jest.fn()
        }))
      }))
    }))
  }))
}));

describe('Supabase Client', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('should be defined', () => {
    expect(supabaseClient).toBeDefined();
  });

  describe('getUserRole', () => {
    it('should return user role when successful', async () => {
      const mockRoleResponse = {
        data: { role: 'customer' },
        error: null
      };

      const mockSingle = jest.fn().mockResolvedValue(mockRoleResponse);
      const mockEq = jest.fn().mockReturnValue({ single: mockSingle });
      const mockSelect = jest.fn().mockReturnValue({ eq: mockEq });
      jest.spyOn(supabaseClient, 'from').mockReturnValue({
        select: mockSelect
      } as any);

      const role = await getUserRole('test-user-id');
      expect(role).toBe('customer');

      expect(supabaseClient.from).toHaveBeenCalledWith('users');
      expect(mockSelect).toHaveBeenCalledWith('role');
      expect(mockEq).toHaveBeenCalledWith('id', 'test-user-id');
      expect(mockSingle).toHaveBeenCalled();
    });

    it('should return null when there is an error', async () => {
      const mockRoleResponse = {
        data: null,
        error: new Error('Test error')
      };

      const mockSingle = jest.fn().mockResolvedValue(mockRoleResponse);
      const mockEq = jest.fn().mockReturnValue({ single: mockSingle });
      const mockSelect = jest.fn().mockReturnValue({ eq: mockEq });
      jest.spyOn(supabaseClient, 'from').mockReturnValue({
        select: mockSelect
      } as any);

      const role = await getUserRole('test-user-id');
      expect(role).toBeNull();

      expect(supabaseClient.from).toHaveBeenCalledWith('users');
      expect(mockSelect).toHaveBeenCalledWith('role');
      expect(mockEq).toHaveBeenCalledWith('id', 'test-user-id');
      expect(mockSingle).toHaveBeenCalled();
    });

    it('should return null when no data is returned', async () => {
      const mockRoleResponse = {
        data: null,
        error: null
      };

      const mockSingle = jest.fn().mockResolvedValue(mockRoleResponse);
      const mockEq = jest.fn().mockReturnValue({ single: mockSingle });
      const mockSelect = jest.fn().mockReturnValue({ eq: mockEq });
      jest.spyOn(supabaseClient, 'from').mockReturnValue({
        select: mockSelect
      } as any);

      const role = await getUserRole('test-user-id');
      expect(role).toBeNull();

      expect(supabaseClient.from).toHaveBeenCalledWith('users');
      expect(mockSelect).toHaveBeenCalledWith('role');
      expect(mockEq).toHaveBeenCalledWith('id', 'test-user-id');
      expect(mockSingle).toHaveBeenCalled();
    });
  });
}); 
