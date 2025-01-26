-- Email Events
CREATE TABLE IF NOT EXISTS email_events (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    message_id UUID REFERENCES messages(id) ON DELETE CASCADE,
    event_type TEXT NOT NULL,
    event_metadata JSONB DEFAULT '{}' NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_email_events_message_id ON email_events(message_id);

-- Email Usage
CREATE TABLE IF NOT EXISTS email_usage (
    org_id UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    usage_date DATE NOT NULL,
    emails_sent INTEGER DEFAULT 0 NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    PRIMARY KEY (org_id, usage_date)
);

CREATE TRIGGER tr_email_usage_update
    BEFORE UPDATE ON email_usage
    FOR EACH ROW
    EXECUTE FUNCTION fn_auto_update_timestamp(); 