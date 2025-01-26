-- Channel Type Enum
CREATE TYPE public.channel_type AS ENUM (
    'email',
    'whatsapp',
    'sms',
    'instagram',
    'chat',
    'slack'
);

-- Channels
CREATE TABLE IF NOT EXISTS channels (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    org_id UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    channel_type public.channel_type NOT NULL,
    external_id TEXT NOT NULL,
    display_name TEXT,
    metadata JSONB DEFAULT '{}' NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TRIGGER tr_channels_update
    BEFORE UPDATE ON channels
    FOR EACH ROW
    EXECUTE FUNCTION fn_auto_update_timestamp();

-- Third Party Integrations
CREATE TABLE IF NOT EXISTS third_party_integrations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    org_id UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    integration_type TEXT NOT NULL,
    access_token TEXT,
    refresh_token TEXT,
    metadata JSONB DEFAULT '{}' NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TRIGGER tr_third_party_integrations_update
    BEFORE UPDATE ON third_party_integrations
    FOR EACH ROW
    EXECUTE FUNCTION fn_auto_update_timestamp(); 