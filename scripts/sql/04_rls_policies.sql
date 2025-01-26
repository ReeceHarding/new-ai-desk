-- Enable RLS on all tables
ALTER TABLE organizations ENABLE ROW LEVEL SECURITY;
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE knowledge_docs ENABLE ROW LEVEL SECURITY;
ALTER TABLE campaigns ENABLE ROW LEVEL SECURITY;
ALTER TABLE campaign_steps ENABLE ROW LEVEL SECURITY;
ALTER TABLE contacts ENABLE ROW LEVEL SECURITY;
ALTER TABLE campaign_contacts ENABLE ROW LEVEL SECURITY;
ALTER TABLE email_events ENABLE ROW LEVEL SECURITY;

-- Organizations policies
CREATE POLICY "Users can view their own organization"
    ON organizations FOR SELECT
    USING (id IN (
        SELECT organization_id FROM profiles
        WHERE auth.uid() = id
    ));

-- Profiles policies
CREATE POLICY "Users can view profiles in their organization"
    ON profiles FOR SELECT
    USING (organization_id IN (
        SELECT organization_id FROM profiles
        WHERE auth.uid() = id
    ));

CREATE POLICY "Users can update their own profile"
    ON profiles FOR UPDATE
    USING (auth.uid() = id);

-- Knowledge docs policies
CREATE POLICY "Users can view knowledge docs in their organization"
    ON knowledge_docs FOR SELECT
    USING (organization_id IN (
        SELECT organization_id FROM profiles
        WHERE auth.uid() = id
    ));

CREATE POLICY "Users can insert knowledge docs in their organization"
    ON knowledge_docs FOR INSERT
    WITH CHECK (organization_id IN (
        SELECT organization_id FROM profiles
        WHERE auth.uid() = id
    ));

-- Campaigns policies
CREATE POLICY "Users can view campaigns in their organization"
    ON campaigns FOR ALL
    USING (organization_id IN (
        SELECT organization_id FROM profiles
        WHERE auth.uid() = id
    ));

-- Campaign steps policies
CREATE POLICY "Users can manage campaign steps in their organization"
    ON campaign_steps FOR ALL
    USING (campaign_id IN (
        SELECT id FROM campaigns
        WHERE organization_id IN (
            SELECT organization_id FROM profiles
            WHERE auth.uid() = id
        )
    ));

-- Contacts policies
CREATE POLICY "Users can manage contacts in their organization"
    ON contacts FOR ALL
    USING (organization_id IN (
        SELECT organization_id FROM profiles
        WHERE auth.uid() = id
    ));

-- Campaign contacts policies
CREATE POLICY "Users can manage campaign contacts in their organization"
    ON campaign_contacts FOR ALL
    USING (campaign_id IN (
        SELECT id FROM campaigns
        WHERE organization_id IN (
            SELECT organization_id FROM profiles
            WHERE auth.uid() = id
        )
    ));

-- Email events policies
CREATE POLICY "Users can view email events in their organization"
    ON email_events FOR SELECT
    USING (campaign_contact_id IN (
        SELECT id FROM campaign_contacts
        WHERE campaign_id IN (
            SELECT id FROM campaigns
            WHERE organization_id IN (
                SELECT organization_id FROM profiles
                WHERE auth.uid() = id
            )
        )
    )); 