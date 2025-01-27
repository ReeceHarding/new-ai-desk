"use client";

import React, { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { createClientComponentClient } from "@supabase/auth-helpers-nextjs";
import { Database } from "@/lib/database.types";
import WizardStepper from "@/components/WizardStepper";
import { Button } from "@/components/ui/Button";
import { Input } from "@/components/ui/Input";
import { motion } from "framer-motion";

enum WizardStep {
  UploadLogo = 1,
  EmailLimit = 2,
  ConnectGmail = 3,
  Confirmation = 4
}

const AdminWizardPage = () => {
  const router = useRouter();
  const supabase = createClientComponentClient<Database>();

  // Step-related state
  const [currentStep, setCurrentStep] = useState<WizardStep>(WizardStep.UploadLogo);

  // Organization Data
  const [orgId, setOrgId] = useState<string>("");
  const [orgName, setOrgName] = useState<string>("");
  const [logoFile, setLogoFile] = useState<File | null>(null);
  const [logoPreview, setLogoPreview] = useState<string>("");
  const [dailyEmailLimit, setDailyEmailLimit] = useState<number>(100);
  const [gmailConnected, setGmailConnected] = useState<boolean>(false);

  // Loading & error states
  const [loading, setLoading] = useState(false);
  const [errorMsg, setErrorMsg] = useState<string>("");

  useEffect(() => {
    async function fetchData() {
      try {
        setLoading(true);
        setErrorMsg("");

        // 1. Get session
        const {
          data: { session }
        } = await supabase.auth.getSession();

        if (!session || !session.user) {
          setErrorMsg("No session found, please sign in.");
          router.push("/auth/signin");
          return;
        }

        // 2. Check if user is admin
        const { data: userData, error: userError } = await supabase
          .from("users")
          .select("id, role, org_id")
          .eq("id", session.user.id)
          .single();

        if (userError || !userData) {
          setErrorMsg("Error retrieving user data or not found.");
          return;
        }

        if (userData.role !== "admin") {
          router.push("/");
          return;
        }

        // 3. Retrieve org
        if (!userData.org_id) {
          setErrorMsg("No organization found for this admin user.");
          return;
        }
        setOrgId(userData.org_id);

        const { data: orgData, error: orgError } = await supabase
          .from("organizations")
          .select("*")
          .eq("id", userData.org_id)
          .single();

        if (orgError || !orgData) {
          setErrorMsg("Error retrieving organization data.");
          return;
        }

        setOrgName(orgData.name ?? "");

        // 4. Check wizardComplete in metadata
        const orgMetadata = orgData.metadata || {};
        const wizardComplete = orgMetadata.wizardComplete === true;

        if (wizardComplete) {
          router.push("/admin/dashboard");
          return;
        }

        if (orgMetadata.dailyEmailLimit) {
          setDailyEmailLimit(orgMetadata.dailyEmailLimit);
        }

        // Check if Gmail is connected
        const { data: updatedUser } = await supabase
          .from("users")
          .select("google_refresh_token")
          .eq("id", session.user.id)
          .single();

        if (updatedUser && updatedUser.google_refresh_token) {
          setGmailConnected(true);
        }
      } catch (err: any) {
        console.error("Error in wizard fetchData:", err);
        setErrorMsg(err.message || "Something went wrong");
      } finally {
        setLoading(false);
      }
    }

    fetchData();
  }, [router, supabase]);

  async function uploadLogoAndSave(file: File) {
    const filename = `${orgId}/${Date.now()}_${file.name}`;

    const { data, error } = await supabase.storage
      .from("branding_assets")
      .upload(filename, file, {
        cacheControl: "3600",
        upsert: false
      });

    if (error) {
      console.error("upload error", error);
      throw new Error("Failed to upload logo file");
    }

    const fullPath = data?.path ?? "";
    const { data: urlData } = supabase.storage
      .from("branding_assets")
      .getPublicUrl(fullPath);

    const logoUrl = urlData?.publicUrl || "";

    const { error: updateError } = await supabase
      .from("organizations")
      .update({ logo_url: logoUrl })
      .eq("id", orgId);

    if (updateError) {
      throw new Error("Failed to save logo URL to org");
    }
  }

  function handleFileSelect(e: React.ChangeEvent<HTMLInputElement>) {
    if (!e.target.files || e.target.files.length === 0) {
      return;
    }
    const file = e.target.files[0];
    setLogoFile(file);

    const previewURL = URL.createObjectURL(file);
    setLogoPreview(previewURL);
  }

  async function handleNextStep() {
    try {
      setErrorMsg("");

      if (currentStep === WizardStep.UploadLogo && logoFile) {
        setLoading(true);
        await uploadLogoAndSave(logoFile);
        setLoading(false);
      } else if (currentStep === WizardStep.EmailLimit) {
        setLoading(true);
        const { error } = await supabase.rpc("update_org_metadata", {
          p_org_id: orgId,
          p_key: "dailyEmailLimit",
          p_value: dailyEmailLimit.toString()
        });

        if (error) {
          setErrorMsg("Failed to update dailyEmailLimit");
          return;
        }
        setLoading(false);
      } else if (currentStep === WizardStep.ConnectGmail) {
        if (!gmailConnected) {
          setErrorMsg("You haven't connected Gmail yet. If you want to skip, press Next again.");
        }
      }

      if (currentStep < WizardStep.Confirmation) {
        setCurrentStep((prev) => (prev + 1) as WizardStep);
      }
    } catch (err: any) {
      setErrorMsg(err.message || "An error occurred moving to the next step.");
    }
  }

  function handleConnectGmail() {
    router.push("/auth/google-oauth?redirectTo=/admin/wizard");
  }

  async function handleFinishWizard() {
    setLoading(true);
    setErrorMsg("");

    try {
      const { error } = await supabase.rpc("update_org_metadata", {
        p_org_id: orgId,
        p_key: "wizardComplete",
        p_value: "true"
      });

      if (error) {
        setErrorMsg("Failed to finalize wizard: " + error.message);
        return;
      }

      router.push("/admin/dashboard");
    } catch (err: any) {
      setErrorMsg(err.message || "Something went wrong finishing wizard.");
    } finally {
      setLoading(false);
    }
  }

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <p className="text-gray-500">Loading ...</p>
      </div>
    );
  }

  if (errorMsg) {
    return (
      <div className="max-w-md mx-auto p-4">
        <p className="text-red-600 text-sm">{errorMsg}</p>
      </div>
    );
  }

  return (
    <div className="min-h-screen px-8 py-6">
      <div className="max-w-2xl mx-auto">
        <WizardStepper currentStep={currentStep} steps={4} />

        {currentStep === WizardStep.UploadLogo && (
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            className="bg-white shadow p-6 rounded-lg mt-8"
          >
            <h2 className="text-xl font-semibold mb-4">
              Step 1: Upload Organization Logo
            </h2>
            <p className="text-gray-600 mb-4">
              This logo will appear in your emails, customer portals, and
              branding.
            </p>
            <input
              type="file"
              accept="image/*"
              onChange={handleFileSelect}
              className="mb-4"
              data-testid="logo-upload"
            />
            {logoPreview && (
              <img
                src={logoPreview}
                alt="Logo Preview"
                className="max-h-24 mb-4 rounded border"
              />
            )}
            <div className="flex justify-end">
              <Button onClick={handleNextStep}>
                Next
              </Button>
            </div>
          </motion.div>
        )}

        {currentStep === WizardStep.EmailLimit && (
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            className="bg-white shadow p-6 rounded-lg mt-8"
          >
            <h2 className="text-xl font-semibold mb-4">
              Step 2: Set Daily Email Limit
            </h2>
            <p className="text-gray-600 mb-4">
              This limit determines how many outreach emails can be sent per
              day to protect your domain reputation.
            </p>
            <Input
              type="number"
              value={dailyEmailLimit}
              onChange={(e) => setDailyEmailLimit(Number(e.target.value))}
            />
            <div className="flex justify-end mt-4">
              <Button variant="secondary" onClick={() => setCurrentStep(WizardStep.UploadLogo)} className="mr-2">
                Back
              </Button>
              <Button onClick={handleNextStep}>
                Next
              </Button>
            </div>
          </motion.div>
        )}

        {currentStep === WizardStep.ConnectGmail && (
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            className="bg-white shadow p-6 rounded-lg mt-8"
          >
            <h2 className="text-xl font-semibold mb-4">
              Step 3: Connect Your Gmail
            </h2>
            <p className="text-gray-600 mb-4">
              Connect your Gmail to send or receive emails directly from this
              platform. You can skip this step if you want to do it later.
            </p>

            {gmailConnected ? (
              <p className="text-green-600 font-medium mb-4">
                Gmail is connected!
              </p>
            ) : (
              <Button onClick={handleConnectGmail}>
                Connect Gmail
              </Button>
            )}

            <div className="flex justify-end mt-4">
              <Button variant="secondary" onClick={() => setCurrentStep(WizardStep.EmailLimit)} className="mr-2">
                Back
              </Button>
              <Button onClick={handleNextStep}>
                Next
              </Button>
            </div>
          </motion.div>
        )}

        {currentStep === WizardStep.Confirmation && (
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            className="bg-white shadow p-6 rounded-lg mt-8"
          >
            <h2 className="text-xl font-semibold mb-4">Step 4: Confirmation</h2>
            <p className="text-gray-600 mb-4">
              Great! You've uploaded your logo, set a daily email limit, and
              {gmailConnected ? " connected Gmail." : " optionally connected Gmail."}
            </p>
            <p className="text-gray-600 mb-2">
              Organization: <strong>{orgName}</strong>
            </p>
            <p className="text-gray-600 mb-2">
              Daily Email Limit: <strong>{dailyEmailLimit}</strong>
            </p>
            <p className="text-gray-600 mb-4">
              Gmail Connected:{" "}
              <strong>{gmailConnected ? "Yes" : "No"}</strong>
            </p>
            <div className="flex justify-end">
              <Button variant="secondary" onClick={() => setCurrentStep(WizardStep.ConnectGmail)} className="mr-2">
                Back
              </Button>
              <Button onClick={handleFinishWizard}>
                Finish Wizard
              </Button>
            </div>
          </motion.div>
        )}
      </div>
    </div>
  );
};

export default AdminWizardPage; 
