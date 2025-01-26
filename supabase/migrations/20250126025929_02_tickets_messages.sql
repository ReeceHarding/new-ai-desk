-- Create ticket status enum
CREATE TYPE ticket_status_type AS ENUM (
    'open',
    'pending',
    'resolved',
    'closed'
);

-- Create tickets table
CREATE TABLE IF NOT EXISTS tickets (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title TEXT NOT NULL,
    description TEXT,
    status ticket_status_type NOT NULL DEFAULT 'open',
    priority TEXT NOT NULL DEFAULT 'medium',
    customer_id UUID REFERENCES users(id),
    assigned_agent_id UUID REFERENCES users(id),
    org_id UUID REFERENCES organizations(id),
    channel_id UUID,
    sla_policy_id UUID,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER tr_tickets_update_timestamp
    BEFORE UPDATE ON tickets
    FOR EACH ROW
    EXECUTE FUNCTION fn_auto_update_timestamp();

-- Create message type enum
CREATE TYPE message_direction AS ENUM (
    'inbound',
    'outbound'
);

CREATE TYPE message_status AS ENUM (
    'sent',
    'delivered',
    'read',
    'failed'
);

-- Create messages table
CREATE TABLE IF NOT EXISTS messages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    content TEXT NOT NULL,
    ticket_id UUID REFERENCES tickets(id),
    sender_id UUID REFERENCES users(id),
    channel_id UUID,
    direction message_direction,
    status message_status DEFAULT 'sent',
    type TEXT NOT NULL DEFAULT 'reply',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER tr_messages_update_timestamp
    BEFORE UPDATE ON messages
    FOR EACH ROW
    EXECUTE FUNCTION fn_auto_update_timestamp(); 