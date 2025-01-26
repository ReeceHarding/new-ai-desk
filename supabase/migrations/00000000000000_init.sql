-- =============================================================================================================
-- MASSIVE SUPERBASE SCHEMA FOR A MULTI-ROLE CRM/HELPDESK/MARKETING/SMART OUTREACH PLATFORM
-- NO DISCLAIMERS. ALL CODE IS FINAL. AT LEAST 50+ TABLES WITH TRIGGERS, ENUMS, BUCKETS, AND REFERENCES.
-- EVERYTHING IS METICULOUSLY DESIGNED. DISABLES ALL RLS FOR DEVELOPMENT. THIS NEVER CHANGES.
-- =============================================================================================================

---------------------------------------------------------------------------------------------------------------
-- 1. EXTENSIONS
---------------------------------------------------------------------------------------------------------------
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE EXTENSION IF NOT EXISTS vector;
CREATE EXTENSION IF NOT EXISTS "citext";

---------------------------------------------------------------------------------------------------------------
-- 2. ENUM TYPES (USER ROLE, TICKET STATUS, MESSAGE DIRECTIONS, ETC.)
---------------------------------------------------------------------------------------------------------------
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'user_role') THEN
    CREATE TYPE user_role AS ENUM (
      'customer',
      'agent',
      'admin'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'ticket_status_type') THEN
    CREATE TYPE ticket_status_type AS ENUM (
      'open',
      'pending',
      'closed',
      'archived'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'message_direction') THEN
    CREATE TYPE message_direction AS ENUM (
      'inbound',
      'outbound'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'message_status') THEN
    CREATE TYPE message_status AS ENUM (
      'queued',
      'sent',
      'read',
      'draft',
      'error'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'channel_type') THEN
    CREATE TYPE channel_type AS ENUM (
      'email',
      'whatsapp',
      'sms',
      'instagram',
      'chat',
      'slack'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'deal_stage') THEN
    CREATE TYPE deal_stage AS ENUM (
      'prospect',
      'qualified',
      'proposal',
      'won',
      'lost'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'marketing_campaign_status') THEN
    CREATE TYPE marketing_campaign_status AS ENUM (
      'draft',
      'active',
      'completed',
      'paused'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'marketing_lead_status') THEN
    CREATE TYPE marketing_lead_status AS ENUM (
      'new',
      'engaged',
      'qualified',
      'converted',
      'unsubscribed'
    );
  END IF;
END$$;

---------------------------------------------------------------------------------------------------------------
-- 3. HELPER FUNCTION FOR AUTO-UPDATE TIMESTAMP
---------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fn_auto_update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

---------------------------------------------------------------------------------------------------------------
-- 4. CREATE BUCKETS (STORAGE)
-- AVATARS, DOC_ATTACHMENTS, TICKET_EXPORTS, BRANDING_ASSETS, MISC_FILES
---------------------------------------------------------------------------------------------------------------
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

---------------------------------------------------------------------------------------------------------------
-- 5. ORGANIZATIONS
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.organizations (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  name text NOT NULL,
  logo_url text,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_organizations_update_timestamp') THEN
    CREATE TRIGGER tr_organizations_update_timestamp
    BEFORE UPDATE ON public.organizations
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

---------------------------------------------------------------------------------------------------------------
-- 6. USERS (ROLES: customer, agent, admin)
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.users (
  id uuid PRIMARY KEY,  -- matches auth.users ID
  role user_role NOT NULL,
  org_id uuid REFERENCES public.organizations(id) ON DELETE SET NULL,
  email citext NOT NULL,
  display_name text,
  google_refresh_token text,
  google_access_token text,
  skills text[] DEFAULT '{}',
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_users_update_timestamp') THEN
    CREATE TRIGGER tr_users_update_timestamp
    BEFORE UPDATE ON public.users
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

---------------------------------------------------------------------------------------------------------------
-- 7. ORGANIZATION MEMBERS (Optional multi-org membership)
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.organization_members (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  organization_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  user_id uuid NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  role_in_org user_role NOT NULL,   -- 'agent','admin','customer'
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_org_members_update_timestamp') THEN
    CREATE TRIGGER tr_org_members_update_timestamp
    BEFORE UPDATE ON public.organization_members
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

---------------------------------------------------------------------------------------------------------------
-- 8. TEAMS & TEAM MEMBERS
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.teams (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  name text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_teams_update_timestamp') THEN
    CREATE TRIGGER tr_teams_update_timestamp
    BEFORE UPDATE ON public.teams
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS public.team_members (
  team_id uuid NOT NULL REFERENCES public.teams(id) ON DELETE CASCADE,
  user_id uuid NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  role_in_team text,
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now(),
  PRIMARY KEY (team_id, user_id)
);

---------------------------------------------------------------------------------------------------------------
-- 9. TICKETS
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.tickets (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  status ticket_status_type NOT NULL DEFAULT 'open',
  subject text NOT NULL,
  description text,
  customer_id uuid REFERENCES public.users(id) ON DELETE SET NULL,
  assigned_agent_id uuid REFERENCES public.users(id) ON DELETE SET NULL,
  category_tag text,
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Add columns if they don't exist
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
    WHERE table_schema = 'public' 
    AND table_name = 'tickets' 
    AND column_name = 'sla_policy_id') THEN
    ALTER TABLE public.tickets ADD COLUMN sla_policy_id uuid;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
    WHERE table_schema = 'public' 
    AND table_name = 'tickets' 
    AND column_name = 'channel_id') THEN
    ALTER TABLE public.tickets ADD COLUMN channel_id uuid;
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_tickets_update_timestamp') THEN
    CREATE TRIGGER tr_tickets_update_timestamp
    BEFORE UPDATE ON public.tickets
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

---------------------------------------------------------------------------------------------------------------
-- (MOVED UP) 9.1: CHANNELS (Original #22)
--   Must exist before MESSAGES, because messages(channel_id) references channels(id).
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.channels (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  channel_type channel_type NOT NULL,
  external_id text NOT NULL,
  display_name text,
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_channels_update') THEN
    CREATE TRIGGER tr_channels_update
    BEFORE UPDATE ON public.channels
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

---------------------------------------------------------------------------------------------------------------
-- 10. MESSAGES (INBOUND/OUTBOUND)
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.messages (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  ticket_id uuid NOT NULL REFERENCES public.tickets(id) ON DELETE CASCADE,
  channel_id uuid NOT NULL REFERENCES public.channels(id) ON DELETE CASCADE,
  direction message_direction NOT NULL,
  status message_status NOT NULL DEFAULT 'draft',
  subject text,
  body text NOT NULL,
  from_email citext,
  to_email citext,
  cc_email citext[],
  bcc_email citext[],
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_messages_update_timestamp') THEN
    CREATE TRIGGER tr_messages_update_timestamp
    BEFORE UPDATE ON public.messages
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

---------------------------------------------------------------------------------------------------------------
-- 11. MESSAGE ATTACHMENTS (PER-MESSAGE FILES)
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.message_attachments (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  message_id uuid NOT NULL REFERENCES public.messages(id) ON DELETE CASCADE,
  file_path text NOT NULL,   -- doc_attachments or misc_files
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now()
);

---------------------------------------------------------------------------------------------------------------
-- 12. TICKET ATTACHMENTS (PER-TICKET FILES)
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.ticket_attachments (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  ticket_id uuid NOT NULL REFERENCES public.tickets(id) ON DELETE CASCADE,
  file_path text NOT NULL,
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now()
);

---------------------------------------------------------------------------------------------------------------
-- 13. DEALS (OPPORTUNITIES)
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.deals (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  name text NOT NULL,
  stage deal_stage NOT NULL DEFAULT 'prospect',
  value numeric(10,2),
  close_date date,
  owner_id uuid REFERENCES public.users(id) ON DELETE SET NULL,
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_deals_update_timestamp') THEN
    CREATE TRIGGER tr_deals_update_timestamp
    BEFORE UPDATE ON public.deals
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

---------------------------------------------------------------------------------------------------------------
-- 14. DEAL ATTACHMENTS
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.deal_attachments (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  deal_id uuid NOT NULL REFERENCES public.deals(id) ON DELETE CASCADE,
  file_path text NOT NULL,
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now()
);

---------------------------------------------------------------------------------------------------------------
-- 15. KNOWLEDGE DOCS & CHUNKS
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.knowledge_docs (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  title text NOT NULL,
  content text NOT NULL,
  author_id uuid REFERENCES public.users(id) ON DELETE SET NULL,
  status text NOT NULL DEFAULT 'draft',
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_kdocs_update_timestamp') THEN
    CREATE TRIGGER tr_kdocs_update_timestamp
    BEFORE UPDATE ON public.knowledge_docs
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS public.knowledge_doc_chunks (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  doc_id uuid NOT NULL REFERENCES public.knowledge_docs(id) ON DELETE CASCADE,
  chunk_index integer NOT NULL,
  content text NOT NULL,
  embedding vector(1536),
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_kdoc_chunks_update_timestamp') THEN
    CREATE TRIGGER tr_kdoc_chunks_update_timestamp
    BEFORE UPDATE ON public.knowledge_doc_chunks
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

CREATE INDEX IF NOT EXISTS idx_kdoc_chunks_embedding
  ON public.knowledge_doc_chunks
  USING ivfflat (embedding vector_cosine_ops)
  WITH (lists = 100);

---------------------------------------------------------------------------------------------------------------
-- 16. KNOWLEDGE DOC VERSIONS & LOCALIZATIONS
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.knowledge_doc_versions (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  doc_id uuid NOT NULL REFERENCES public.knowledge_docs(id) ON DELETE CASCADE,
  version_label text NOT NULL,
  content_snapshot text NOT NULL,
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.knowledge_doc_localizations (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  doc_id uuid NOT NULL REFERENCES public.knowledge_docs(id) ON DELETE CASCADE,
  language_code text NOT NULL,
  title text NOT NULL,
  content text NOT NULL,
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_kdoc_localizations_update') THEN
    CREATE TRIGGER tr_kdoc_localizations_update
    BEFORE UPDATE ON public.knowledge_doc_localizations
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

---------------------------------------------------------------------------------------------------------------
-- 17. KNOWLEDGE DOC CATEGORIES & LINKS
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.knowledge_doc_categories (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  name text NOT NULL,
  description text,
  parent_id uuid REFERENCES public.knowledge_doc_categories(id) ON DELETE SET NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_kdoc_categories_update_timestamp') THEN
    CREATE TRIGGER tr_kdoc_categories_update_timestamp
    BEFORE UPDATE ON public.knowledge_doc_categories
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS public.knowledge_doc_category_links (
  doc_id uuid NOT NULL REFERENCES public.knowledge_docs(id) ON DELETE CASCADE,
  category_id uuid NOT NULL REFERENCES public.knowledge_doc_categories(id) ON DELETE CASCADE,
  PRIMARY KEY (doc_id, category_id)
);

---------------------------------------------------------------------------------------------------------------
-- 18. SLA POLICIES & VIOLATIONS
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.sla_policies (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  name text NOT NULL,
  description text,
  response_time_minutes integer NOT NULL,
  resolution_time_minutes integer NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Add foreign key if it doesn't exist
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.table_constraints 
    WHERE table_schema = 'public' 
    AND table_name = 'tickets'
    AND constraint_name = 'fk_tickets_sla_policy'
  ) THEN
    ALTER TABLE public.tickets 
    ADD CONSTRAINT fk_tickets_sla_policy 
    FOREIGN KEY (sla_policy_id) 
    REFERENCES public.sla_policies(id) 
    ON DELETE SET NULL;
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS public.sla_violations (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  ticket_id uuid NOT NULL REFERENCES public.tickets(id) ON DELETE CASCADE,
  policy_id uuid NOT NULL REFERENCES public.sla_policies(id) ON DELETE CASCADE,
  type text NOT NULL, -- e.g. 'first_response_late','resolution_late'
  occurred_at timestamptz NOT NULL DEFAULT now(),
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb
);

---------------------------------------------------------------------------------------------------------------
-- 19. TICKET HISTORY (FIELD CHANGES)
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.ticket_history (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  ticket_id uuid NOT NULL REFERENCES public.tickets(id) ON DELETE CASCADE,
  changed_by uuid REFERENCES public.users(id) ON DELETE SET NULL,
  old_status ticket_status_type,
  new_status ticket_status_type,
  old_assigned_agent_id uuid,
  new_assigned_agent_id uuid,
  changed_at timestamptz DEFAULT now()
);

---------------------------------------------------------------------------------------------------------------
-- 20. SCRAPED SITES & DISCOVERED EMAILS (SMART OUTREACH)
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.scraped_sites (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid REFERENCES public.organizations(id) ON DELETE CASCADE,
  url text NOT NULL,
  status text NOT NULL DEFAULT 'pending',
  scraped_data jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_scraped_sites_update') THEN
    CREATE TRIGGER tr_scraped_sites_update
    BEFORE UPDATE ON public.scraped_sites
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS public.discovered_emails (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  site_id uuid REFERENCES public.scraped_sites(id) ON DELETE CASCADE,
  email citext NOT NULL,
  context text,
  created_at timestamptz DEFAULT now()
);

---------------------------------------------------------------------------------------------------------------
-- 21. OUTREACH CAMPAIGNS & CONTACTS (SMART OUTREACH)
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.outreach_campaigns (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  name text NOT NULL,
  status text NOT NULL DEFAULT 'draft',
  daily_email_limit int NOT NULL DEFAULT 100,
  follow_up_mode text NOT NULL DEFAULT 'weekly',
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_outreach_campaigns_update') THEN
    CREATE TRIGGER tr_outreach_campaigns_update
    BEFORE UPDATE ON public.outreach_campaigns
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS public.outreach_companies (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid REFERENCES public.organizations(id) ON DELETE CASCADE,
  campaign_id uuid REFERENCES public.outreach_campaigns(id) ON DELETE CASCADE,
  domain text NOT NULL,
  status text NOT NULL DEFAULT 'scraped',
  scraped_data jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_outreach_companies_update') THEN
    CREATE TRIGGER tr_outreach_companies_update
    BEFORE UPDATE ON public.outreach_companies
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS public.outreach_contacts (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  company_id uuid NOT NULL REFERENCES public.outreach_companies(id) ON DELETE CASCADE,
  email citext NOT NULL,
  name text NOT NULL DEFAULT 'Unknown',
  phone text,
  social_links jsonb NOT NULL DEFAULT '[]'::jsonb,
  do_not_contact boolean NOT NULL DEFAULT false,
  unsubscribed_at timestamptz,
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
  status text NOT NULL DEFAULT 'new',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_outreach_contacts_update') THEN
    CREATE TRIGGER tr_outreach_contacts_update
    BEFORE UPDATE ON public.outreach_contacts
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

---------------------------------------------------------------------------------------------------------------
-- 22. (Now used above as #9.1) - originally "CHANNELS" code; moved.
--    So we skip here in final ordering, to avoid confusion.
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
-- 23. TICKET EMBEDDINGS (FOR SEARCH OR AI)
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.ticket_embeddings (
  ticket_id uuid PRIMARY KEY REFERENCES public.tickets(id) ON DELETE CASCADE,
  embedding vector(1536),
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_ticket_embeddings_update') THEN
    CREATE TRIGGER tr_ticket_embeddings_update
    BEFORE UPDATE ON public.ticket_embeddings
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

---------------------------------------------------------------------------------------------------------------
-- 24. TICKET SUMMARIES (AI-GENERATED)
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.ticket_summaries (
  ticket_id uuid PRIMARY KEY REFERENCES public.tickets(id) ON DELETE CASCADE,
  summary text NOT NULL,
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_ticket_summaries_update') THEN
    CREATE TRIGGER tr_ticket_summaries_update
    BEFORE UPDATE ON public.ticket_summaries
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

---------------------------------------------------------------------------------------------------------------
-- 25. PLANS & ORG SUBSCRIPTIONS
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.plans (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  plan_name text NOT NULL,
  monthly_price numeric(12,2),
  features jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.org_subscriptions (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid REFERENCES public.organizations(id) ON DELETE CASCADE,
  plan_id uuid REFERENCES public.plans(id) ON DELETE SET NULL,
  status text NOT NULL DEFAULT 'active',  -- e.g. 'active','canceled'
  started_at timestamptz NOT NULL DEFAULT now(),
  ends_at timestamptz,
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb
);

---------------------------------------------------------------------------------------------------------------
-- 26. MARKETING CAMPAIGNS, LEADS, WORKFLOWS
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.marketing_campaigns (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  name text NOT NULL,
  description text,
  start_date timestamptz,
  end_date timestamptz,
  status marketing_campaign_status NOT NULL DEFAULT 'draft',
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_marketing_campaigns_update') THEN
    CREATE TRIGGER tr_marketing_campaigns_update
    BEFORE UPDATE ON public.marketing_campaigns
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS public.marketing_campaign_members (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  campaign_id uuid NOT NULL REFERENCES public.marketing_campaigns(id) ON DELETE CASCADE,
  user_id uuid REFERENCES public.users(id) ON DELETE SET NULL,
  status text NOT NULL DEFAULT 'new',
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_marketing_campaign_members_update') THEN
    CREATE TRIGGER tr_marketing_campaign_members_update
    BEFORE UPDATE ON public.marketing_campaign_members
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS public.marketing_leads (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid REFERENCES public.organizations(id) ON DELETE CASCADE,
  email citext,
  name text,
  phone text,
  source text,
  status marketing_lead_status NOT NULL DEFAULT 'new',
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_marketing_leads_update') THEN
    CREATE TRIGGER tr_marketing_leads_update
    BEFORE UPDATE ON public.marketing_leads
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS public.marketing_lead_activity (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  lead_id uuid NOT NULL REFERENCES public.marketing_leads(id) ON DELETE CASCADE,
  activity_type text NOT NULL,     -- 'email_open','link_click','web_visit','reply'
  details jsonb NOT NULL DEFAULT '{}'::jsonb,
  occurred_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.marketing_segments (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  segment_name text NOT NULL,
  filter_condition jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_marketing_segments_update') THEN
    CREATE TRIGGER tr_marketing_segments_update
    BEFORE UPDATE ON public.marketing_segments
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS public.marketing_email_templates (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid REFERENCES public.organizations(id) ON DELETE CASCADE,
  name text NOT NULL,
  subject text NOT NULL,
  body text NOT NULL,
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_marketing_email_templates_update') THEN
    CREATE TRIGGER tr_marketing_email_templates_update
    BEFORE UPDATE ON public.marketing_email_templates
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS public.marketing_workflows (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid REFERENCES public.organizations(id) ON DELETE CASCADE,
  workflow_name text NOT NULL,
  is_active boolean NOT NULL DEFAULT false,
  metadata jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_marketing_workflows_update') THEN
    CREATE TRIGGER tr_marketing_workflows_update
    BEFORE UPDATE ON public.marketing_workflows
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS public.marketing_workflow_steps (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  workflow_id uuid NOT NULL REFERENCES public.marketing_workflows(id) ON DELETE CASCADE,
  step_name text NOT NULL,
  step_type text NOT NULL,
  step_config jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_marketing_workflow_steps_update') THEN
    CREATE TRIGGER tr_marketing_workflow_steps_update
    BEFORE UPDATE ON public.marketing_workflow_steps
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

---------------------------------------------------------------------------------------------------------------
-- 27. FORMS, FORM FIELDS, SUBMISSIONS
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.forms (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  form_name text NOT NULL,
  form_fields jsonb NOT NULL DEFAULT '[]',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_forms_update') THEN
    CREATE TRIGGER tr_forms_update
    BEFORE UPDATE ON public.forms
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS public.form_fields (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  form_id uuid NOT NULL REFERENCES public.forms(id) ON DELETE CASCADE,
  field_name text NOT NULL,
  field_type text NOT NULL,
  field_config jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_form_fields_update') THEN
    CREATE TRIGGER tr_form_fields_update
    BEFORE UPDATE ON public.form_fields
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS public.form_submissions (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  form_id uuid NOT NULL REFERENCES public.forms(id) ON DELETE CASCADE,
  submitted_by uuid REFERENCES public.users(id) ON DELETE SET NULL,
  metadata jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.form_submission_answers (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  submission_id uuid NOT NULL REFERENCES public.form_submissions(id) ON DELETE CASCADE,
  field_id uuid NOT NULL REFERENCES public.form_fields(id) ON DELETE CASCADE,
  answer text,
  metadata jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz DEFAULT now()
);

---------------------------------------------------------------------------------------------------------------
-- 28. CUSTOM FIELDS (FOR TICKETS, USERS, LEADS, ETC.)
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.custom_field_definitions (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  field_name text NOT NULL,
  field_type text NOT NULL,
  field_config jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_custom_field_definitions_update') THEN
    CREATE TRIGGER tr_custom_field_definitions_update
    BEFORE UPDATE ON public.custom_field_definitions
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS public.custom_field_values (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  field_id uuid NOT NULL REFERENCES public.custom_field_definitions(id) ON DELETE CASCADE,
  entity_id uuid NOT NULL,
  field_value jsonb NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_custom_field_values_update') THEN
    CREATE TRIGGER tr_custom_field_values_update
    BEFORE UPDATE ON public.custom_field_values
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

---------------------------------------------------------------------------------------------------------------
-- 29. TO-DO TASKS & COMMENTS (FOR AGENTS/ADMINS)
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.to_do_tasks (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  assigned_to uuid REFERENCES public.users(id) ON DELETE SET NULL,
  title text NOT NULL,
  description text,
  due_date timestamptz,
  status text NOT NULL DEFAULT 'pending',
  priority text NOT NULL DEFAULT 'medium',
  metadata jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_to_do_tasks_update') THEN
    CREATE TRIGGER tr_to_do_tasks_update
    BEFORE UPDATE ON public.to_do_tasks
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS public.to_do_task_comments (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  task_id uuid NOT NULL REFERENCES public.to_do_tasks(id) ON DELETE CASCADE,
  commenter_id uuid REFERENCES public.users(id) ON DELETE SET NULL,
  body text NOT NULL,
  created_at timestamptz DEFAULT now()
);

---------------------------------------------------------------------------------------------------------------
-- 30. ADVANCED USER PREFERENCES
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.advanced_user_preferences (
  user_id uuid PRIMARY KEY REFERENCES public.users(id) ON DELETE CASCADE,
  preferences jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_adv_user_prefs_update') THEN
    CREATE TRIGGER tr_adv_user_prefs_update
    BEFORE UPDATE ON public.advanced_user_preferences
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

---------------------------------------------------------------------------------------------------------------
-- 31. AGENT SCHEDULES & SHIFT LOGS
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.agent_schedules (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  agent_id uuid NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  day_of_week int NOT NULL,  -- 0=Sunday..6=Saturday
  start_time text NOT NULL,
  end_time text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_agent_schedules_update') THEN
    CREATE TRIGGER tr_agent_schedules_update
    BEFORE UPDATE ON public.agent_schedules
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS public.agent_shift_logs (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  agent_id uuid NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  shift_start timestamptz NOT NULL,
  shift_end timestamptz,
  metadata jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_agent_shift_logs_update') THEN
    CREATE TRIGGER tr_agent_shift_logs_update
    BEFORE UPDATE ON public.agent_shift_logs
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

---------------------------------------------------------------------------------------------------------------
-- 32. ADVANCED AUTOMATIONS (MACROS, ESCALATIONS, SCRIPTS)
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.advanced_automations (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  name text NOT NULL,
  description text,
  is_active boolean NOT NULL DEFAULT false,
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_advanced_automations_update') THEN
    CREATE TRIGGER tr_advanced_automations_update
    BEFORE UPDATE ON public.advanced_automations
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS public.macros (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid REFERENCES public.organizations(id) ON DELETE CASCADE,
  name text NOT NULL,
  body text NOT NULL,
  metadata jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_macros_update') THEN
    CREATE TRIGGER tr_macros_update
    BEFORE UPDATE ON public.macros
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS public.macro_usages (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  macro_id uuid NOT NULL REFERENCES public.macros(id) ON DELETE CASCADE,
  ticket_id uuid REFERENCES public.tickets(id) ON DELETE CASCADE,
  applied_by uuid REFERENCES public.users(id) ON DELETE SET NULL,
  applied_at timestamptz DEFAULT now(),
  metadata jsonb NOT NULL DEFAULT '{}'
);

CREATE TABLE IF NOT EXISTS public.escalation_rules (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  rule_name text NOT NULL,
  condition jsonb NOT NULL,
  action jsonb NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_escalation_rules_update') THEN
    CREATE TRIGGER tr_escalation_rules_update
    BEFORE UPDATE ON public.escalation_rules
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS public.automation_scripts (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid REFERENCES public.organizations(id) ON DELETE CASCADE,
  script_name text NOT NULL,
  condition text NOT NULL,  -- can store DSL
  action text NOT NULL,     -- can store DSL
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_automation_scripts_update') THEN
    CREATE TRIGGER tr_automation_scripts_update
    BEFORE UPDATE ON public.automation_scripts
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

---------------------------------------------------------------------------------------------------------------
-- 33. PERMISSIONS & ROLE_PERMISSIONS (FINE-GRAINED ACL)
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.permissions (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  permission_name text NOT NULL,
  description text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.role_permissions (
  role_name user_role NOT NULL,
  permission_id uuid NOT NULL REFERENCES public.permissions(id) ON DELETE CASCADE,
  created_at timestamptz DEFAULT now(),
  PRIMARY KEY(role_name, permission_id)
);

---------------------------------------------------------------------------------------------------------------
-- 34. TICKET CLASSIFICATIONS (AI TRIAGE)
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.ticket_classifications (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  ticket_id uuid NOT NULL REFERENCES public.tickets(id) ON DELETE CASCADE,
  classification text NOT NULL,
  confidence numeric(5,2) NOT NULL,
  assigned_agent_id uuid REFERENCES public.users(id) ON DELETE SET NULL,
  created_at timestamptz DEFAULT now()
);

---------------------------------------------------------------------------------------------------------------
-- 35. PHONE CALLS & PHONE CALL RECORDINGS
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.phone_calls (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid REFERENCES public.organizations(id) ON DELETE CASCADE,
  ticket_id uuid REFERENCES public.tickets(id) ON DELETE CASCADE,
  caller_id uuid REFERENCES public.users(id) ON DELETE SET NULL,
  call_duration int,
  transcript text,
  metadata jsonb NOT NULL DEFAULT '{}',
  started_at timestamptz NOT NULL DEFAULT now(),
  ended_at timestamptz
);

CREATE TABLE IF NOT EXISTS public.phone_call_recordings (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid REFERENCES public.organizations(id) ON DELETE CASCADE,
  call_id uuid,  -- references phone_calls.id if we want
  file_path text NOT NULL,
  created_at timestamptz DEFAULT now()
);

---------------------------------------------------------------------------------------------------------------
-- 36. THIRD-PARTY INTEGRATIONS (SLACK, TEAMS, WHATSAPP, ETC.)
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.third_party_integrations (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  integration_type text NOT NULL,
  config jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'tr_third_party_integrations_update') THEN
    CREATE TRIGGER tr_third_party_integrations_update
    BEFORE UPDATE ON public.third_party_integrations
    FOR EACH ROW
    EXECUTE PROCEDURE public.fn_auto_update_timestamp();
  END IF;
END $$;

---------------------------------------------------------------------------------------------------------------
-- 37. IP RESTRICTIONS
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.ip_restrictions (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  allowed_ip text NOT NULL,
  description text,
  created_at timestamptz DEFAULT now()
);

---------------------------------------------------------------------------------------------------------------
-- 38. USER API TOKENS
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.user_api_tokens (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  user_id uuid NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  token text NOT NULL UNIQUE,
  metadata jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz DEFAULT now(),
  revoked_at timestamptz
);

---------------------------------------------------------------------------------------------------------------
-- 39. AUTOMATION CONDITIONS, ACTIONS, LOGS (OPTIONAL REFINEMENTS)
--    NOTE: This references "public.advanced_automations" in the foreign key, but that table isn't defined above.
--    If needed, adjust or create that table. For now, this is left as-is.
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.automation_conditions (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  automation_id uuid NOT NULL REFERENCES public.advanced_automations(id) ON DELETE CASCADE,
  condition_type text NOT NULL,
  condition_config jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.automation_actions (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  automation_id uuid NOT NULL REFERENCES public.advanced_automations(id) ON DELETE CASCADE,
  action_type text NOT NULL,
  action_config jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.automation_logs (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  automation_id uuid REFERENCES public.advanced_automations(id) ON DELETE CASCADE,
  executed_at timestamptz DEFAULT now(),
  details jsonb NOT NULL DEFAULT '{}'
);

---------------------------------------------------------------------------------------------------------------
-- 40. AUDIT LOGS
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.audit_logs (
  id bigserial PRIMARY KEY,
  actor_id uuid REFERENCES public.users(id) ON DELETE SET NULL,
  action text NOT NULL,
  entity_name text NOT NULL,
  entity_id uuid,
  changes jsonb,
  description text,
  created_at timestamptz DEFAULT now()
);

---------------------------------------------------------------------------------------------------------------
-- 41. REPORTS (STORING SNAPSHOTS OR AGGREGATE DATA)
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.reports (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  report_type text NOT NULL,
  data jsonb NOT NULL,      -- big aggregated JSON
  metadata jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TRIGGER tr_reports_update
BEFORE UPDATE ON public.reports
FOR EACH ROW
EXECUTE PROCEDURE public.fn_auto_update_timestamp();

---------------------------------------------------------------------------------------------------------------
-- 42. NOTIFICATIONS (USER-SPECIFIC ALERTS)
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.notifications (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  user_id uuid NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  notification_type text NOT NULL,  -- 'ticket_assigned','new_message','sys_alert'
  title text,
  body text,
  read_at timestamptz,
  metadata jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TRIGGER tr_notifications_update
BEFORE UPDATE ON public.notifications
FOR EACH ROW
EXECUTE PROCEDURE public.fn_auto_update_timestamp();

---------------------------------------------------------------------------------------------------------------
-- 43. SUBSCRIPTION USAGE (MONTHLY LIMITS, AI TOKENS, ETC.)
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.subscription_usage (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  usage_key text NOT NULL,   -- 'monthly_emails','ai_tokens','agent_seats'
  usage_value numeric NOT NULL DEFAULT 0,
  period_start timestamptz NOT NULL,
  period_end timestamptz NOT NULL
);

---------------------------------------------------------------------------------------------------------------
-- 44. EMAIL USAGE & EVENTS (FOR MARKETING/OUTREACH)
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.email_usage (
  org_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  usage_date date NOT NULL,
  emails_sent integer NOT NULL DEFAULT 0,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  PRIMARY KEY (org_id, usage_date)
);

CREATE TRIGGER tr_email_usage_update
BEFORE UPDATE ON public.email_usage
FOR EACH ROW
EXECUTE PROCEDURE public.fn_auto_update_timestamp();

CREATE TABLE IF NOT EXISTS public.email_events (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  message_id uuid REFERENCES public.messages(id) ON DELETE CASCADE,
  event_type text NOT NULL,  -- 'bounce','complaint','open','click'
  event_metadata jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_email_events_message_id ON public.email_events(message_id);

---------------------------------------------------------------------------------------------------------------
-- 45. INVITATIONS (ORG MEMBERSHIP)
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.invitations (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  organization_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  email citext NOT NULL,
  role user_role NOT NULL,   -- 'agent','admin'
  token text NOT NULL UNIQUE,
  expires_at timestamptz NOT NULL DEFAULT (now() + interval '7 days'),
  used_at timestamptz,
  metadata jsonb NOT NULL DEFAULT '{}'
);

---------------------------------------------------------------------------------------------------------------
-- 49. COMMENTING / COLLAB (IF WE WANT A GENERIC COMMENTS TABLE)
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.comments (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  entity_name text NOT NULL,  -- e.g. 'ticket','deal','doc'
  entity_id uuid NOT NULL,
  author_id uuid REFERENCES public.users(id) ON DELETE SET NULL,
  body text NOT NULL,
  is_private boolean NOT NULL DEFAULT false,
  metadata jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz DEFAULT now()
);

---------------------------------------------------------------------------------------------------------------
-- 50. TAGS & TICKET_TAGS (GLOBAL TAGS)
---------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.tags (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  org_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  name text NOT NULL,
  description text,
  metadata jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TRIGGER tr_tags_update
BEFORE UPDATE ON public.tags
FOR EACH ROW
EXECUTE PROCEDURE public.fn_auto_update_timestamp();

CREATE TABLE IF NOT EXISTS public.ticket_tags (
  ticket_id uuid NOT NULL REFERENCES public.tickets(id) ON DELETE CASCADE,
  tag_id uuid NOT NULL REFERENCES public.tags(id) ON DELETE CASCADE,
  created_at timestamptz DEFAULT now(),
  PRIMARY KEY (ticket_id, tag_id)
);

---------------------------------------------------------------------------------------------------------------
-- DISABLE ALL RLS FOR DEVELOPMENT
---------------------------------------------------------------------------------------------------------------
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

-- DONE. AT LEAST 50+ TABLES, WITH TRIGGERS, ENUMS, BUCKETS, AND DISABLED RLS FOR DEVELOPMENT.
-- NO DISCLAIMERS. THIS SCHEMA NEVER CHANGES.