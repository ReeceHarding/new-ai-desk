-- =============================================================================================================
-- STORAGE BUCKETS AND RLS POLICIES
-- =============================================================================================================

-- Create Storage Buckets
INSERT INTO storage.buckets (id, name, public)
SELECT 'avatars','avatars',true
WHERE NOT EXISTS (SELECT 1 FROM storage.buckets WHERE id = 'avatars');

INSERT INTO storage.buckets (id, name, public)
SELECT 'doc_attachments','doc_attachments',false
WHERE NOT EXISTS (SELECT 1 FROM storage.buckets WHERE id = 'doc_attachments');

INSERT INTO storage.buckets (id, name, public)
SELECT 'ticket_exports','ticket_exports',false
WHERE NOT EXISTS (SELECT 1 FROM storage.buckets WHERE id = 'ticket_exports');

INSERT INTO storage.buckets (id, name, public)
SELECT 'branding_assets','branding_assets',false
WHERE NOT EXISTS (SELECT 1 FROM storage.buckets WHERE id = 'branding_assets');

INSERT INTO storage.buckets (id, name, public)
SELECT 'misc_files','misc_files',false
WHERE NOT EXISTS (SELECT 1 FROM storage.buckets WHERE id = 'misc_files');

-- Disable RLS for Development
ALTER TABLE public.organizations              DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.users                      DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.organization_members       DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.teams                      DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.team_members               DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.tickets                    DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.messages                   DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.message_attachments        DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.ticket_attachments         DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.deals                      DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.deal_attachments           DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.knowledge_docs             DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.knowledge_doc_chunks       DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.knowledge_doc_versions     DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.knowledge_doc_localizations DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.knowledge_doc_categories   DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.knowledge_doc_category_links DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.sla_policies               DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.sla_violations             DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.ticket_history             DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.scraped_sites              DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.discovered_emails          DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.outreach_campaigns         DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.outreach_companies         DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.outreach_contacts          DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.channels                   DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.ticket_embeddings          DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.ticket_summaries           DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.plans                      DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.org_subscriptions          DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.marketing_campaigns        DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.marketing_campaign_members DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.marketing_leads            DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.marketing_lead_activity    DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.marketing_segments         DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.marketing_email_templates  DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.marketing_workflows        DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.marketing_workflow_steps   DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.forms                      DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.form_fields                DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.form_submissions           DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.form_submission_answers    DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.custom_field_definitions   DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.custom_field_values        DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.to_do_tasks                DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.to_do_task_comments        DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.advanced_user_preferences  DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.agent_schedules            DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.agent_shift_logs           DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.macros                     DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.macro_usages               DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.escalation_rules           DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.automation_scripts         DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.permissions                DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.role_permissions           DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.ticket_classifications     DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.phone_calls                DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.phone_call_recordings      DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.third_party_integrations   DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.ip_restrictions            DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_api_tokens            DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.automation_conditions      DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.automation_actions         DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.automation_logs            DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.audit_logs                 DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.reports                    DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifications              DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.subscription_usage         DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.email_usage                DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.email_events               DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.invitations                DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.comments                   DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.tags                       DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.ticket_tags                DISABLE ROW LEVEL SECURITY; 