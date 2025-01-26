-- Marketing Campaign Status Type
CREATE TYPE public.marketing_campaign_status AS ENUM (
    'draft',
    'active',
    'completed',
    'paused'
);

-- Marketing Lead Status Type
CREATE TYPE public.marketing_lead_status AS ENUM (
    'new',
    'engaged',
    'qualified',
    'converted',
    'unsubscribed'
);

-- Marketing Campaigns
CREATE TABLE IF NOT EXISTS marketing_campaigns (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    org_id UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    description TEXT,
    start_date TIMESTAMP WITH TIME ZONE,
    end_date TIMESTAMP WITH TIME ZONE,
    status public.marketing_campaign_status DEFAULT 'draft' NOT NULL,
    metadata JSONB DEFAULT '{}' NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TRIGGER tr_marketing_campaigns_update
    BEFORE UPDATE ON marketing_campaigns
    FOR EACH ROW
    EXECUTE FUNCTION fn_auto_update_timestamp();

-- Marketing Campaign Members
CREATE TABLE IF NOT EXISTS marketing_campaign_members (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    campaign_id UUID NOT NULL REFERENCES marketing_campaigns(id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    status TEXT DEFAULT 'new' NOT NULL,
    metadata JSONB DEFAULT '{}' NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TRIGGER tr_marketing_campaign_members_update
    BEFORE UPDATE ON marketing_campaign_members
    FOR EACH ROW
    EXECUTE FUNCTION fn_auto_update_timestamp();

-- Marketing Leads
CREATE TABLE IF NOT EXISTS marketing_leads (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    org_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    email public.citext,
    name TEXT,
    phone TEXT,
    source TEXT,
    status public.marketing_lead_status DEFAULT 'new' NOT NULL,
    metadata JSONB DEFAULT '{}' NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TRIGGER tr_marketing_leads_update
    BEFORE UPDATE ON marketing_leads
    FOR EACH ROW
    EXECUTE FUNCTION fn_auto_update_timestamp();

-- Marketing Lead Activity
CREATE TABLE IF NOT EXISTS marketing_lead_activity (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    lead_id UUID NOT NULL REFERENCES marketing_leads(id) ON DELETE CASCADE,
    activity_type TEXT NOT NULL,
    details JSONB DEFAULT '{}' NOT NULL,
    occurred_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL
);

-- Marketing Email Templates
CREATE TABLE IF NOT EXISTS marketing_email_templates (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    org_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    subject TEXT NOT NULL,
    body TEXT NOT NULL,
    metadata JSONB DEFAULT '{}' NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TRIGGER tr_marketing_email_templates_update
    BEFORE UPDATE ON marketing_email_templates
    FOR EACH ROW
    EXECUTE FUNCTION fn_auto_update_timestamp();

-- Marketing Segments
CREATE TABLE IF NOT EXISTS marketing_segments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    org_id UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    segment_name TEXT NOT NULL,
    filter_condition JSONB DEFAULT '{}' NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TRIGGER tr_marketing_segments_update
    BEFORE UPDATE ON marketing_segments
    FOR EACH ROW
    EXECUTE FUNCTION fn_auto_update_timestamp();

-- Marketing Workflows
CREATE TABLE IF NOT EXISTS marketing_workflows (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    org_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    workflow_name TEXT NOT NULL,
    is_active BOOLEAN DEFAULT false NOT NULL,
    metadata JSONB DEFAULT '{}' NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TRIGGER tr_marketing_workflows_update
    BEFORE UPDATE ON marketing_workflows
    FOR EACH ROW
    EXECUTE FUNCTION fn_auto_update_timestamp();

-- Marketing Workflow Steps
CREATE TABLE IF NOT EXISTS marketing_workflow_steps (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    workflow_id UUID NOT NULL REFERENCES marketing_workflows(id) ON DELETE CASCADE,
    step_order INTEGER NOT NULL,
    action_type TEXT NOT NULL,
    action_config JSONB DEFAULT '{}' NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TRIGGER tr_marketing_workflow_steps_update
    BEFORE UPDATE ON marketing_workflow_steps
    FOR EACH ROW
    EXECUTE FUNCTION fn_auto_update_timestamp(); 