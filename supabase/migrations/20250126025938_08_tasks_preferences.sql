-- To-Do Tasks
CREATE TABLE IF NOT EXISTS to_do_tasks (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    org_id UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    assigned_to UUID REFERENCES users(id) ON DELETE SET NULL,
    title TEXT NOT NULL,
    description TEXT,
    due_at TIMESTAMP WITH TIME ZONE,
    status TEXT DEFAULT 'open' NOT NULL,
    metadata JSONB DEFAULT '{}' NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TRIGGER tr_to_do_tasks_update
    BEFORE UPDATE ON to_do_tasks
    FOR EACH ROW
    EXECUTE FUNCTION fn_auto_update_timestamp();

-- To-Do Task Comments
CREATE TABLE IF NOT EXISTS to_do_task_comments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    task_id UUID NOT NULL REFERENCES to_do_tasks(id) ON DELETE CASCADE,
    commenter_id UUID REFERENCES users(id) ON DELETE SET NULL,
    body TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Advanced User Preferences
CREATE TABLE IF NOT EXISTS advanced_user_preferences (
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    preferences JSONB DEFAULT '{}' NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    PRIMARY KEY (user_id)
);

CREATE TRIGGER tr_adv_user_prefs_update
    BEFORE UPDATE ON advanced_user_preferences
    FOR EACH ROW
    EXECUTE FUNCTION fn_auto_update_timestamp(); 