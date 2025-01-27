import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import AdminWizardPage from "../page";
import { createClientComponentClient } from "@supabase/auth-helpers-nextjs";
import { useRouter } from "next/navigation";

// Mock next/navigation
jest.mock("next/navigation", () => ({
  useRouter: jest.fn()
}));

// Mock supabase
jest.mock("@supabase/auth-helpers-nextjs", () => ({
  createClientComponentClient: jest.fn()
}));

// Mock URL.createObjectURL
const mockObjectURL = "blob:mock-url";
global.URL.createObjectURL = jest.fn(() => mockObjectURL);

describe("AdminWizardPage", () => {
  let mockPush: jest.Mock;

  beforeEach(() => {
    jest.clearAllMocks();
    mockPush = jest.fn();
    (useRouter as jest.Mock).mockReturnValue({ push: mockPush });
  });

  it("renders the wizard steps for an admin with incomplete wizard", async () => {
    // Arrange
    (createClientComponentClient as jest.Mock).mockReturnValue({
      auth: {
        getSession: jest.fn().mockResolvedValue({
          data: { session: { user: { id: "admin-user-id" } } }
        })
      },
      from: jest.fn((table: string) => {
        if (table === "users") {
          return {
            select: jest.fn().mockReturnValue({
              eq: jest.fn().mockReturnValue({
                single: jest
                  .fn()
                  .mockResolvedValue({ data: { id: "admin-user-id", role: "admin", org_id: "org-123" }, error: null })
              })
            })
          };
        }
        if (table === "organizations") {
          return {
            select: jest.fn().mockReturnValue({
              eq: jest.fn().mockReturnValue({
                single: jest.fn().mockResolvedValue({
                  data: {
                    name: "Test Org",
                    metadata: { wizardComplete: false, dailyEmailLimit: 50 }
                  },
                  error: null
                })
              })
            })
          };
        }
        return { select: jest.fn() };
      })
    });

    // Act
    render(<AdminWizardPage />);

    // Assert
    await waitFor(() => {
      expect(screen.queryByText("Loading ...")).not.toBeInTheDocument();
    });
    expect(screen.getByText("Step 1: Upload Organization Logo")).toBeInTheDocument();
  });

  it("redirects if wizardComplete is true", async () => {
    // Arrange
    (createClientComponentClient as jest.Mock).mockReturnValue({
      auth: {
        getSession: jest.fn().mockResolvedValue({
          data: { session: { user: { id: "admin-user-id" } } }
        })
      },
      from: jest.fn((table: string) => {
        if (table === "users") {
          return {
            select: jest.fn().mockReturnValue({
              eq: jest.fn().mockReturnValue({
                single: jest
                  .fn()
                  .mockResolvedValue({ data: { id: "admin-user-id", role: "admin", org_id: "org-123" }, error: null })
              })
            })
          };
        }
        if (table === "organizations") {
          return {
            select: jest.fn().mockReturnValue({
              eq: jest.fn().mockReturnValue({
                single: jest.fn().mockResolvedValue({
                  data: {
                    name: "Test Org",
                    metadata: { wizardComplete: true }
                  },
                  error: null
                })
              })
            })
          };
        }
        return { select: jest.fn() };
      })
    });

    // Act
    render(<AdminWizardPage />);

    // Assert
    await waitFor(() => {
      expect(mockPush).toHaveBeenCalledWith("/admin/dashboard");
    }, { timeout: 3000 });
  });

  it("uploads a logo file on step 1 and goes to step 2", async () => {
    // Arrange
    (createClientComponentClient as jest.Mock).mockReturnValue({
      auth: {
        getSession: jest.fn().mockResolvedValue({
          data: { session: { user: { id: "admin-user-id" } } }
        })
      },
      from: jest.fn((table: string) => {
        return {
          select: jest.fn().mockReturnValue({
            eq: jest.fn().mockReturnValue({
              single: jest.fn().mockResolvedValue({
                data: {
                  name: "Test Org",
                  metadata: { wizardComplete: false, dailyEmailLimit: 100 }
                },
                error: null
              })
            })
          }),
          update: jest.fn().mockReturnValue({
            eq: jest.fn().mockResolvedValue({ error: null })
          })
        };
      }),
      storage: {
        from: jest.fn(() => ({
          upload: jest.fn().mockResolvedValue({ data: { path: "org-123/12345_logo.png" }, error: null }),
          getPublicUrl: jest.fn(() => ({
            data: { publicUrl: "https://bucket-url/org-123/12345_logo.png" }
          }))
        }))
      }
    });

    // Act
    render(<AdminWizardPage />);

    // Wait for loading to finish
    await waitFor(() => {
      expect(screen.queryByText("Loading ...")).not.toBeInTheDocument();
    });

    // Wait for step 1
    const heading = await screen.findByText("Step 1: Upload Organization Logo");
    expect(heading).toBeInTheDocument();

    const fileInput = screen.getByTestId("logo-upload") as HTMLInputElement;
    const file = new File(["(⌐□_□)"], "logo.png", { type: "image/png" });
    fireEvent.change(fileInput, { target: { files: [file] } });

    const nextBtn = screen.getByText("Next");
    fireEvent.click(nextBtn);

    // Assert
    await waitFor(() => {
      expect(screen.getByText("Step 2: Set Daily Email Limit")).toBeInTheDocument();
    });
  });
}); 
