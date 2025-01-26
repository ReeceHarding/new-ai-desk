-- Automation Scripts
CREATE TABLE IF NOT EXISTS automation_scripts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    org_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    script_name TEXT NOT NULL,
    condition TEXT NOT NULL,
    action TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TRIGGER tr_automation_scripts_update
    BEFORE UPDATE ON automation_scripts
    FOR EACH ROW
    EXECUTE FUNCTION fn_auto_update_timestamp();

-- Automation Conditions
CREATE TABLE IF NOT EXISTS automation_conditions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    automation_id UUID NOT NULL REFERENCES automation_scripts(id) ON DELETE CASCADE,
    condition_type TEXT NOT NULL,
    condition_config JSONB DEFAULT '{}' NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Automation Actions
CREATE TABLE IF NOT EXISTS automation_actions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    automation_id UUID NOT NULL REFERENCES automation_scripts(id) ON DELETE CASCADE,
    action_type TEXT NOT NULL,
    action_config JSONB DEFAULT '{}' NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Automation Logs
CREATE TABLE IF NOT EXISTS automation_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    automation_id UUID REFERENCES automation_scripts(id) ON DELETE CASCADE,
    executed_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    details JSONB DEFAULT '{}' NOT NULL
);

-- Permissions
CREATE TABLE IF NOT EXISTS permissions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    permission_name TEXT NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Role Permissions
CREATE TABLE IF NOT EXISTS role_permissions (
    role_name public.user_role NOT NULL,
    permission_id UUID NOT NULL REFERENCES permissions(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    PRIMARY KEY (role_name, permission_id)
); 