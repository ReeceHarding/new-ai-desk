--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 15.10 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY storage.s3_multipart_uploads_parts DROP CONSTRAINT IF EXISTS s3_multipart_uploads_parts_upload_id_fkey;
ALTER TABLE IF EXISTS ONLY storage.s3_multipart_uploads_parts DROP CONSTRAINT IF EXISTS s3_multipart_uploads_parts_bucket_id_fkey;
ALTER TABLE IF EXISTS ONLY storage.s3_multipart_uploads DROP CONSTRAINT IF EXISTS s3_multipart_uploads_bucket_id_fkey;
ALTER TABLE IF EXISTS ONLY storage.objects DROP CONSTRAINT IF EXISTS "objects_bucketId_fkey";
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.user_api_tokens DROP CONSTRAINT IF EXISTS user_api_tokens_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.to_do_tasks DROP CONSTRAINT IF EXISTS to_do_tasks_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.to_do_tasks DROP CONSTRAINT IF EXISTS to_do_tasks_assigned_to_fkey;
ALTER TABLE IF EXISTS ONLY public.to_do_task_comments DROP CONSTRAINT IF EXISTS to_do_task_comments_task_id_fkey;
ALTER TABLE IF EXISTS ONLY public.to_do_task_comments DROP CONSTRAINT IF EXISTS to_do_task_comments_commenter_id_fkey;
ALTER TABLE IF EXISTS ONLY public.tickets DROP CONSTRAINT IF EXISTS tickets_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.tickets DROP CONSTRAINT IF EXISTS tickets_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.tickets DROP CONSTRAINT IF EXISTS tickets_assigned_agent_id_fkey;
ALTER TABLE IF EXISTS ONLY public.ticket_tags DROP CONSTRAINT IF EXISTS ticket_tags_ticket_id_fkey;
ALTER TABLE IF EXISTS ONLY public.ticket_tags DROP CONSTRAINT IF EXISTS ticket_tags_tag_id_fkey;
ALTER TABLE IF EXISTS ONLY public.ticket_summaries DROP CONSTRAINT IF EXISTS ticket_summaries_ticket_id_fkey;
ALTER TABLE IF EXISTS ONLY public.ticket_history DROP CONSTRAINT IF EXISTS ticket_history_ticket_id_fkey;
ALTER TABLE IF EXISTS ONLY public.ticket_history DROP CONSTRAINT IF EXISTS ticket_history_changed_by_fkey;
ALTER TABLE IF EXISTS ONLY public.ticket_embeddings DROP CONSTRAINT IF EXISTS ticket_embeddings_ticket_id_fkey;
ALTER TABLE IF EXISTS ONLY public.ticket_classifications DROP CONSTRAINT IF EXISTS ticket_classifications_ticket_id_fkey;
ALTER TABLE IF EXISTS ONLY public.ticket_classifications DROP CONSTRAINT IF EXISTS ticket_classifications_assigned_agent_id_fkey;
ALTER TABLE IF EXISTS ONLY public.ticket_attachments DROP CONSTRAINT IF EXISTS ticket_attachments_ticket_id_fkey;
ALTER TABLE IF EXISTS ONLY public.third_party_integrations DROP CONSTRAINT IF EXISTS third_party_integrations_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.teams DROP CONSTRAINT IF EXISTS teams_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.team_members DROP CONSTRAINT IF EXISTS team_members_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.team_members DROP CONSTRAINT IF EXISTS team_members_team_id_fkey;
ALTER TABLE IF EXISTS ONLY public.tags DROP CONSTRAINT IF EXISTS tags_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.subscription_usage DROP CONSTRAINT IF EXISTS subscription_usage_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.sla_violations DROP CONSTRAINT IF EXISTS sla_violations_ticket_id_fkey;
ALTER TABLE IF EXISTS ONLY public.sla_violations DROP CONSTRAINT IF EXISTS sla_violations_policy_id_fkey;
ALTER TABLE IF EXISTS ONLY public.sla_policies DROP CONSTRAINT IF EXISTS sla_policies_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.scraped_sites DROP CONSTRAINT IF EXISTS scraped_sites_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.role_permissions DROP CONSTRAINT IF EXISTS role_permissions_permission_id_fkey;
ALTER TABLE IF EXISTS ONLY public.reports DROP CONSTRAINT IF EXISTS reports_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.plans DROP CONSTRAINT IF EXISTS plans_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.phone_calls DROP CONSTRAINT IF EXISTS phone_calls_ticket_id_fkey;
ALTER TABLE IF EXISTS ONLY public.phone_calls DROP CONSTRAINT IF EXISTS phone_calls_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.phone_calls DROP CONSTRAINT IF EXISTS phone_calls_caller_id_fkey;
ALTER TABLE IF EXISTS ONLY public.phone_call_recordings DROP CONSTRAINT IF EXISTS phone_call_recordings_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.outreach_contacts DROP CONSTRAINT IF EXISTS outreach_contacts_company_id_fkey;
ALTER TABLE IF EXISTS ONLY public.outreach_companies DROP CONSTRAINT IF EXISTS outreach_companies_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.outreach_companies DROP CONSTRAINT IF EXISTS outreach_companies_campaign_id_fkey;
ALTER TABLE IF EXISTS ONLY public.outreach_campaigns DROP CONSTRAINT IF EXISTS outreach_campaigns_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.organization_members DROP CONSTRAINT IF EXISTS organization_members_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.organization_members DROP CONSTRAINT IF EXISTS organization_members_organization_id_fkey;
ALTER TABLE IF EXISTS ONLY public.notifications DROP CONSTRAINT IF EXISTS notifications_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.messages DROP CONSTRAINT IF EXISTS messages_ticket_id_fkey;
ALTER TABLE IF EXISTS ONLY public.messages DROP CONSTRAINT IF EXISTS messages_sender_id_fkey;
ALTER TABLE IF EXISTS ONLY public.messages DROP CONSTRAINT IF EXISTS messages_channel_id_fkey;
ALTER TABLE IF EXISTS ONLY public.message_attachments DROP CONSTRAINT IF EXISTS message_attachments_message_id_fkey;
ALTER TABLE IF EXISTS ONLY public.marketing_workflows DROP CONSTRAINT IF EXISTS marketing_workflows_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.marketing_workflow_steps DROP CONSTRAINT IF EXISTS marketing_workflow_steps_workflow_id_fkey;
ALTER TABLE IF EXISTS ONLY public.marketing_segments DROP CONSTRAINT IF EXISTS marketing_segments_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.marketing_leads DROP CONSTRAINT IF EXISTS marketing_leads_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.marketing_lead_activity DROP CONSTRAINT IF EXISTS marketing_lead_activity_lead_id_fkey;
ALTER TABLE IF EXISTS ONLY public.marketing_email_templates DROP CONSTRAINT IF EXISTS marketing_email_templates_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.marketing_campaigns DROP CONSTRAINT IF EXISTS marketing_campaigns_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.marketing_campaign_members DROP CONSTRAINT IF EXISTS marketing_campaign_members_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.marketing_campaign_members DROP CONSTRAINT IF EXISTS marketing_campaign_members_campaign_id_fkey;
ALTER TABLE IF EXISTS ONLY public.macros DROP CONSTRAINT IF EXISTS macros_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.macro_usages DROP CONSTRAINT IF EXISTS macro_usages_ticket_id_fkey;
ALTER TABLE IF EXISTS ONLY public.macro_usages DROP CONSTRAINT IF EXISTS macro_usages_macro_id_fkey;
ALTER TABLE IF EXISTS ONLY public.macro_usages DROP CONSTRAINT IF EXISTS macro_usages_applied_by_fkey;
ALTER TABLE IF EXISTS ONLY public.knowledge_docs DROP CONSTRAINT IF EXISTS knowledge_docs_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.knowledge_doc_versions DROP CONSTRAINT IF EXISTS knowledge_doc_versions_doc_id_fkey;
ALTER TABLE IF EXISTS ONLY public.knowledge_doc_localizations DROP CONSTRAINT IF EXISTS knowledge_doc_localizations_doc_id_fkey;
ALTER TABLE IF EXISTS ONLY public.knowledge_doc_chunks DROP CONSTRAINT IF EXISTS knowledge_doc_chunks_doc_id_fkey;
ALTER TABLE IF EXISTS ONLY public.knowledge_doc_category_links DROP CONSTRAINT IF EXISTS knowledge_doc_category_links_doc_id_fkey;
ALTER TABLE IF EXISTS ONLY public.knowledge_doc_category_links DROP CONSTRAINT IF EXISTS knowledge_doc_category_links_category_id_fkey;
ALTER TABLE IF EXISTS ONLY public.knowledge_doc_categories DROP CONSTRAINT IF EXISTS knowledge_doc_categories_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.ip_restrictions DROP CONSTRAINT IF EXISTS ip_restrictions_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.forms DROP CONSTRAINT IF EXISTS forms_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.form_submissions DROP CONSTRAINT IF EXISTS form_submissions_submitted_by_fkey;
ALTER TABLE IF EXISTS ONLY public.form_submissions DROP CONSTRAINT IF EXISTS form_submissions_form_id_fkey;
ALTER TABLE IF EXISTS ONLY public.form_submission_answers DROP CONSTRAINT IF EXISTS form_submission_answers_submission_id_fkey;
ALTER TABLE IF EXISTS ONLY public.form_submission_answers DROP CONSTRAINT IF EXISTS form_submission_answers_field_id_fkey;
ALTER TABLE IF EXISTS ONLY public.form_fields DROP CONSTRAINT IF EXISTS form_fields_form_id_fkey;
ALTER TABLE IF EXISTS ONLY public.escalation_rules DROP CONSTRAINT IF EXISTS escalation_rules_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.email_usage DROP CONSTRAINT IF EXISTS email_usage_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.email_events DROP CONSTRAINT IF EXISTS email_events_message_id_fkey;
ALTER TABLE IF EXISTS ONLY public.discovered_emails DROP CONSTRAINT IF EXISTS discovered_emails_site_id_fkey;
ALTER TABLE IF EXISTS ONLY public.deals DROP CONSTRAINT IF EXISTS deals_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.deals DROP CONSTRAINT IF EXISTS deals_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.deals DROP CONSTRAINT IF EXISTS deals_assigned_agent_id_fkey;
ALTER TABLE IF EXISTS ONLY public.deal_attachments DROP CONSTRAINT IF EXISTS deal_attachments_deal_id_fkey;
ALTER TABLE IF EXISTS ONLY public.custom_field_values DROP CONSTRAINT IF EXISTS custom_field_values_definition_id_fkey;
ALTER TABLE IF EXISTS ONLY public.custom_field_definitions DROP CONSTRAINT IF EXISTS custom_field_definitions_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.comments DROP CONSTRAINT IF EXISTS comments_author_id_fkey;
ALTER TABLE IF EXISTS ONLY public.channels DROP CONSTRAINT IF EXISTS channels_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.automation_scripts DROP CONSTRAINT IF EXISTS automation_scripts_org_id_fkey;
ALTER TABLE IF EXISTS ONLY public.automation_logs DROP CONSTRAINT IF EXISTS automation_logs_automation_id_fkey;
ALTER TABLE IF EXISTS ONLY public.automation_conditions DROP CONSTRAINT IF EXISTS automation_conditions_automation_id_fkey;
ALTER TABLE IF EXISTS ONLY public.automation_actions DROP CONSTRAINT IF EXISTS automation_actions_automation_id_fkey;
ALTER TABLE IF EXISTS ONLY public.audit_logs DROP CONSTRAINT IF EXISTS audit_logs_actor_id_fkey;
ALTER TABLE IF EXISTS ONLY public.agent_shift_logs DROP CONSTRAINT IF EXISTS agent_shift_logs_agent_id_fkey;
ALTER TABLE IF EXISTS ONLY public.agent_schedules DROP CONSTRAINT IF EXISTS agent_schedules_agent_id_fkey;
ALTER TABLE IF EXISTS ONLY public.advanced_user_preferences DROP CONSTRAINT IF EXISTS advanced_user_preferences_user_id_fkey;
DROP TRIGGER IF EXISTS update_objects_updated_at ON storage.objects;
DROP TRIGGER IF EXISTS tr_users_update_timestamp ON public.users;
DROP TRIGGER IF EXISTS tr_to_do_tasks_update ON public.to_do_tasks;
DROP TRIGGER IF EXISTS tr_tickets_update_timestamp ON public.tickets;
DROP TRIGGER IF EXISTS tr_ticket_summaries_update ON public.ticket_summaries;
DROP TRIGGER IF EXISTS tr_ticket_embeddings_update ON public.ticket_embeddings;
DROP TRIGGER IF EXISTS tr_third_party_integrations_update ON public.third_party_integrations;
DROP TRIGGER IF EXISTS tr_teams_update_timestamp ON public.teams;
DROP TRIGGER IF EXISTS tr_tags_update ON public.tags;
DROP TRIGGER IF EXISTS tr_scraped_sites_update ON public.scraped_sites;
DROP TRIGGER IF EXISTS tr_reports_update ON public.reports;
DROP TRIGGER IF EXISTS tr_plans_update_timestamp ON public.plans;
DROP TRIGGER IF EXISTS tr_outreach_contacts_update ON public.outreach_contacts;
DROP TRIGGER IF EXISTS tr_outreach_companies_update ON public.outreach_companies;
DROP TRIGGER IF EXISTS tr_outreach_campaigns_update ON public.outreach_campaigns;
DROP TRIGGER IF EXISTS tr_organizations_update_timestamp ON public.organizations;
DROP TRIGGER IF EXISTS tr_org_members_update_timestamp ON public.organization_members;
DROP TRIGGER IF EXISTS tr_notifications_update ON public.notifications;
DROP TRIGGER IF EXISTS tr_messages_update_timestamp ON public.messages;
DROP TRIGGER IF EXISTS tr_marketing_workflows_update ON public.marketing_workflows;
DROP TRIGGER IF EXISTS tr_marketing_workflow_steps_update ON public.marketing_workflow_steps;
DROP TRIGGER IF EXISTS tr_marketing_segments_update ON public.marketing_segments;
DROP TRIGGER IF EXISTS tr_marketing_leads_update ON public.marketing_leads;
DROP TRIGGER IF EXISTS tr_marketing_email_templates_update ON public.marketing_email_templates;
DROP TRIGGER IF EXISTS tr_marketing_campaigns_update ON public.marketing_campaigns;
DROP TRIGGER IF EXISTS tr_marketing_campaign_members_update ON public.marketing_campaign_members;
DROP TRIGGER IF EXISTS tr_macros_update ON public.macros;
DROP TRIGGER IF EXISTS tr_kdocs_update_timestamp ON public.knowledge_docs;
DROP TRIGGER IF EXISTS tr_kdoc_localizations_update ON public.knowledge_doc_localizations;
DROP TRIGGER IF EXISTS tr_kdoc_chunks_update_timestamp ON public.knowledge_doc_chunks;
DROP TRIGGER IF EXISTS tr_kdoc_categories_update_timestamp ON public.knowledge_doc_categories;
DROP TRIGGER IF EXISTS tr_forms_update ON public.forms;
DROP TRIGGER IF EXISTS tr_form_fields_update ON public.form_fields;
DROP TRIGGER IF EXISTS tr_escalation_rules_update ON public.escalation_rules;
DROP TRIGGER IF EXISTS tr_email_usage_update ON public.email_usage;
DROP TRIGGER IF EXISTS tr_deals_update_timestamp ON public.deals;
DROP TRIGGER IF EXISTS tr_custom_field_values_update ON public.custom_field_values;
DROP TRIGGER IF EXISTS tr_custom_field_definitions_update ON public.custom_field_definitions;
DROP TRIGGER IF EXISTS tr_channels_update ON public.channels;
DROP TRIGGER IF EXISTS tr_automation_scripts_update ON public.automation_scripts;
DROP TRIGGER IF EXISTS tr_agent_shift_logs_update ON public.agent_shift_logs;
DROP TRIGGER IF EXISTS tr_agent_schedules_update ON public.agent_schedules;
DROP TRIGGER IF EXISTS tr_adv_user_prefs_update ON public.advanced_user_preferences;
DROP INDEX IF EXISTS storage.name_prefix_search;
DROP INDEX IF EXISTS storage.idx_objects_bucket_id_name;
DROP INDEX IF EXISTS storage.idx_multipart_uploads_list;
DROP INDEX IF EXISTS storage.bucketid_objname;
DROP INDEX IF EXISTS storage.bname;
DROP INDEX IF EXISTS public.idx_kdoc_chunks_embedding;
DROP INDEX IF EXISTS public.idx_email_events_message_id;
ALTER TABLE IF EXISTS ONLY storage.s3_multipart_uploads DROP CONSTRAINT IF EXISTS s3_multipart_uploads_pkey;
ALTER TABLE IF EXISTS ONLY storage.s3_multipart_uploads_parts DROP CONSTRAINT IF EXISTS s3_multipart_uploads_parts_pkey;
ALTER TABLE IF EXISTS ONLY storage.objects DROP CONSTRAINT IF EXISTS objects_pkey;
ALTER TABLE IF EXISTS ONLY storage.migrations DROP CONSTRAINT IF EXISTS migrations_pkey;
ALTER TABLE IF EXISTS ONLY storage.migrations DROP CONSTRAINT IF EXISTS migrations_name_key;
ALTER TABLE IF EXISTS ONLY storage.buckets DROP CONSTRAINT IF EXISTS buckets_pkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.user_api_tokens DROP CONSTRAINT IF EXISTS user_api_tokens_token_key;
ALTER TABLE IF EXISTS ONLY public.user_api_tokens DROP CONSTRAINT IF EXISTS user_api_tokens_pkey;
ALTER TABLE IF EXISTS ONLY public.to_do_tasks DROP CONSTRAINT IF EXISTS to_do_tasks_pkey;
ALTER TABLE IF EXISTS ONLY public.to_do_task_comments DROP CONSTRAINT IF EXISTS to_do_task_comments_pkey;
ALTER TABLE IF EXISTS ONLY public.tickets DROP CONSTRAINT IF EXISTS tickets_pkey;
ALTER TABLE IF EXISTS ONLY public.ticket_tags DROP CONSTRAINT IF EXISTS ticket_tags_pkey;
ALTER TABLE IF EXISTS ONLY public.ticket_summaries DROP CONSTRAINT IF EXISTS ticket_summaries_pkey;
ALTER TABLE IF EXISTS ONLY public.ticket_history DROP CONSTRAINT IF EXISTS ticket_history_pkey;
ALTER TABLE IF EXISTS ONLY public.ticket_embeddings DROP CONSTRAINT IF EXISTS ticket_embeddings_pkey;
ALTER TABLE IF EXISTS ONLY public.ticket_classifications DROP CONSTRAINT IF EXISTS ticket_classifications_pkey;
ALTER TABLE IF EXISTS ONLY public.ticket_attachments DROP CONSTRAINT IF EXISTS ticket_attachments_pkey;
ALTER TABLE IF EXISTS ONLY public.third_party_integrations DROP CONSTRAINT IF EXISTS third_party_integrations_pkey;
ALTER TABLE IF EXISTS ONLY public.teams DROP CONSTRAINT IF EXISTS teams_pkey;
ALTER TABLE IF EXISTS ONLY public.team_members DROP CONSTRAINT IF EXISTS team_members_pkey;
ALTER TABLE IF EXISTS ONLY public.tags DROP CONSTRAINT IF EXISTS tags_pkey;
ALTER TABLE IF EXISTS ONLY public.subscription_usage DROP CONSTRAINT IF EXISTS subscription_usage_pkey;
ALTER TABLE IF EXISTS ONLY public.sla_violations DROP CONSTRAINT IF EXISTS sla_violations_pkey;
ALTER TABLE IF EXISTS ONLY public.sla_policies DROP CONSTRAINT IF EXISTS sla_policies_pkey;
ALTER TABLE IF EXISTS ONLY public.scraped_sites DROP CONSTRAINT IF EXISTS scraped_sites_pkey;
ALTER TABLE IF EXISTS ONLY public.role_permissions DROP CONSTRAINT IF EXISTS role_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.reports DROP CONSTRAINT IF EXISTS reports_pkey;
ALTER TABLE IF EXISTS ONLY public.plans DROP CONSTRAINT IF EXISTS plans_pkey;
ALTER TABLE IF EXISTS ONLY public.phone_calls DROP CONSTRAINT IF EXISTS phone_calls_pkey;
ALTER TABLE IF EXISTS ONLY public.phone_call_recordings DROP CONSTRAINT IF EXISTS phone_call_recordings_pkey;
ALTER TABLE IF EXISTS ONLY public.permissions DROP CONSTRAINT IF EXISTS permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.outreach_contacts DROP CONSTRAINT IF EXISTS outreach_contacts_pkey;
ALTER TABLE IF EXISTS ONLY public.outreach_companies DROP CONSTRAINT IF EXISTS outreach_companies_pkey;
ALTER TABLE IF EXISTS ONLY public.outreach_campaigns DROP CONSTRAINT IF EXISTS outreach_campaigns_pkey;
ALTER TABLE IF EXISTS ONLY public.organizations DROP CONSTRAINT IF EXISTS organizations_pkey;
ALTER TABLE IF EXISTS ONLY public.organization_members DROP CONSTRAINT IF EXISTS organization_members_pkey;
ALTER TABLE IF EXISTS ONLY public.notifications DROP CONSTRAINT IF EXISTS notifications_pkey;
ALTER TABLE IF EXISTS ONLY public.messages DROP CONSTRAINT IF EXISTS messages_pkey;
ALTER TABLE IF EXISTS ONLY public.message_attachments DROP CONSTRAINT IF EXISTS message_attachments_pkey;
ALTER TABLE IF EXISTS ONLY public.marketing_workflows DROP CONSTRAINT IF EXISTS marketing_workflows_pkey;
ALTER TABLE IF EXISTS ONLY public.marketing_workflow_steps DROP CONSTRAINT IF EXISTS marketing_workflow_steps_pkey;
ALTER TABLE IF EXISTS ONLY public.marketing_segments DROP CONSTRAINT IF EXISTS marketing_segments_pkey;
ALTER TABLE IF EXISTS ONLY public.marketing_leads DROP CONSTRAINT IF EXISTS marketing_leads_pkey;
ALTER TABLE IF EXISTS ONLY public.marketing_lead_activity DROP CONSTRAINT IF EXISTS marketing_lead_activity_pkey;
ALTER TABLE IF EXISTS ONLY public.marketing_email_templates DROP CONSTRAINT IF EXISTS marketing_email_templates_pkey;
ALTER TABLE IF EXISTS ONLY public.marketing_campaigns DROP CONSTRAINT IF EXISTS marketing_campaigns_pkey;
ALTER TABLE IF EXISTS ONLY public.marketing_campaign_members DROP CONSTRAINT IF EXISTS marketing_campaign_members_pkey;
ALTER TABLE IF EXISTS ONLY public.macros DROP CONSTRAINT IF EXISTS macros_pkey;
ALTER TABLE IF EXISTS ONLY public.macro_usages DROP CONSTRAINT IF EXISTS macro_usages_pkey;
ALTER TABLE IF EXISTS ONLY public.knowledge_docs DROP CONSTRAINT IF EXISTS knowledge_docs_pkey;
ALTER TABLE IF EXISTS ONLY public.knowledge_doc_versions DROP CONSTRAINT IF EXISTS knowledge_doc_versions_pkey;
ALTER TABLE IF EXISTS ONLY public.knowledge_doc_localizations DROP CONSTRAINT IF EXISTS knowledge_doc_localizations_pkey;
ALTER TABLE IF EXISTS ONLY public.knowledge_doc_chunks DROP CONSTRAINT IF EXISTS knowledge_doc_chunks_pkey;
ALTER TABLE IF EXISTS ONLY public.knowledge_doc_category_links DROP CONSTRAINT IF EXISTS knowledge_doc_category_links_pkey;
ALTER TABLE IF EXISTS ONLY public.knowledge_doc_categories DROP CONSTRAINT IF EXISTS knowledge_doc_categories_pkey;
ALTER TABLE IF EXISTS ONLY public.ip_restrictions DROP CONSTRAINT IF EXISTS ip_restrictions_pkey;
ALTER TABLE IF EXISTS ONLY public.forms DROP CONSTRAINT IF EXISTS forms_pkey;
ALTER TABLE IF EXISTS ONLY public.form_submissions DROP CONSTRAINT IF EXISTS form_submissions_pkey;
ALTER TABLE IF EXISTS ONLY public.form_submission_answers DROP CONSTRAINT IF EXISTS form_submission_answers_pkey;
ALTER TABLE IF EXISTS ONLY public.form_fields DROP CONSTRAINT IF EXISTS form_fields_pkey;
ALTER TABLE IF EXISTS ONLY public.escalation_rules DROP CONSTRAINT IF EXISTS escalation_rules_pkey;
ALTER TABLE IF EXISTS ONLY public.email_usage DROP CONSTRAINT IF EXISTS email_usage_pkey;
ALTER TABLE IF EXISTS ONLY public.email_events DROP CONSTRAINT IF EXISTS email_events_pkey;
ALTER TABLE IF EXISTS ONLY public.discovered_emails DROP CONSTRAINT IF EXISTS discovered_emails_pkey;
ALTER TABLE IF EXISTS ONLY public.deals DROP CONSTRAINT IF EXISTS deals_pkey;
ALTER TABLE IF EXISTS ONLY public.deal_attachments DROP CONSTRAINT IF EXISTS deal_attachments_pkey;
ALTER TABLE IF EXISTS ONLY public.custom_field_values DROP CONSTRAINT IF EXISTS custom_field_values_pkey;
ALTER TABLE IF EXISTS ONLY public.custom_field_definitions DROP CONSTRAINT IF EXISTS custom_field_definitions_pkey;
ALTER TABLE IF EXISTS ONLY public.comments DROP CONSTRAINT IF EXISTS comments_pkey;
ALTER TABLE IF EXISTS ONLY public.channels DROP CONSTRAINT IF EXISTS channels_pkey;
ALTER TABLE IF EXISTS ONLY public.automation_scripts DROP CONSTRAINT IF EXISTS automation_scripts_pkey;
ALTER TABLE IF EXISTS ONLY public.automation_logs DROP CONSTRAINT IF EXISTS automation_logs_pkey;
ALTER TABLE IF EXISTS ONLY public.automation_conditions DROP CONSTRAINT IF EXISTS automation_conditions_pkey;
ALTER TABLE IF EXISTS ONLY public.automation_actions DROP CONSTRAINT IF EXISTS automation_actions_pkey;
ALTER TABLE IF EXISTS ONLY public.audit_logs DROP CONSTRAINT IF EXISTS audit_logs_pkey;
ALTER TABLE IF EXISTS ONLY public.agent_shift_logs DROP CONSTRAINT IF EXISTS agent_shift_logs_pkey;
ALTER TABLE IF EXISTS ONLY public.agent_schedules DROP CONSTRAINT IF EXISTS agent_schedules_pkey;
ALTER TABLE IF EXISTS ONLY public.advanced_user_preferences DROP CONSTRAINT IF EXISTS advanced_user_preferences_pkey;
ALTER TABLE IF EXISTS public.audit_logs ALTER COLUMN id DROP DEFAULT;
DROP TABLE IF EXISTS storage.s3_multipart_uploads_parts;
DROP TABLE IF EXISTS storage.s3_multipart_uploads;
DROP TABLE IF EXISTS storage.objects;
DROP TABLE IF EXISTS storage.migrations;
DROP TABLE IF EXISTS storage.buckets;
DROP TABLE IF EXISTS public.users;
DROP TABLE IF EXISTS public.user_api_tokens;
DROP TABLE IF EXISTS public.to_do_tasks;
DROP TABLE IF EXISTS public.to_do_task_comments;
DROP TABLE IF EXISTS public.tickets;
DROP TABLE IF EXISTS public.ticket_tags;
DROP TABLE IF EXISTS public.ticket_summaries;
DROP TABLE IF EXISTS public.ticket_history;
DROP TABLE IF EXISTS public.ticket_embeddings;
DROP TABLE IF EXISTS public.ticket_classifications;
DROP TABLE IF EXISTS public.ticket_attachments;
DROP TABLE IF EXISTS public.third_party_integrations;
DROP TABLE IF EXISTS public.teams;
DROP TABLE IF EXISTS public.team_members;
DROP TABLE IF EXISTS public.tags;
DROP TABLE IF EXISTS public.subscription_usage;
DROP TABLE IF EXISTS public.sla_violations;
DROP TABLE IF EXISTS public.sla_policies;
DROP TABLE IF EXISTS public.scraped_sites;
DROP TABLE IF EXISTS public.role_permissions;
DROP TABLE IF EXISTS public.reports;
DROP TABLE IF EXISTS public.plans;
DROP TABLE IF EXISTS public.phone_calls;
DROP TABLE IF EXISTS public.phone_call_recordings;
DROP TABLE IF EXISTS public.permissions;
DROP TABLE IF EXISTS public.outreach_contacts;
DROP TABLE IF EXISTS public.outreach_companies;
DROP TABLE IF EXISTS public.outreach_campaigns;
DROP TABLE IF EXISTS public.organizations;
DROP TABLE IF EXISTS public.organization_members;
DROP TABLE IF EXISTS public.notifications;
DROP TABLE IF EXISTS public.messages;
DROP TABLE IF EXISTS public.message_attachments;
DROP TABLE IF EXISTS public.marketing_workflows;
DROP TABLE IF EXISTS public.marketing_workflow_steps;
DROP TABLE IF EXISTS public.marketing_segments;
DROP TABLE IF EXISTS public.marketing_leads;
DROP TABLE IF EXISTS public.marketing_lead_activity;
DROP TABLE IF EXISTS public.marketing_email_templates;
DROP TABLE IF EXISTS public.marketing_campaigns;
DROP TABLE IF EXISTS public.marketing_campaign_members;
DROP TABLE IF EXISTS public.macros;
DROP TABLE IF EXISTS public.macro_usages;
DROP TABLE IF EXISTS public.knowledge_docs;
DROP TABLE IF EXISTS public.knowledge_doc_versions;
DROP TABLE IF EXISTS public.knowledge_doc_localizations;
DROP TABLE IF EXISTS public.knowledge_doc_chunks;
DROP TABLE IF EXISTS public.knowledge_doc_category_links;
DROP TABLE IF EXISTS public.knowledge_doc_categories;
DROP TABLE IF EXISTS public.ip_restrictions;
DROP TABLE IF EXISTS public.forms;
DROP TABLE IF EXISTS public.form_submissions;
DROP TABLE IF EXISTS public.form_submission_answers;
DROP TABLE IF EXISTS public.form_fields;
DROP TABLE IF EXISTS public.escalation_rules;
DROP TABLE IF EXISTS public.email_usage;
DROP TABLE IF EXISTS public.email_events;
DROP TABLE IF EXISTS public.discovered_emails;
DROP TABLE IF EXISTS public.deals;
DROP TABLE IF EXISTS public.deal_attachments;
DROP TABLE IF EXISTS public.custom_field_values;
DROP TABLE IF EXISTS public.custom_field_definitions;
DROP TABLE IF EXISTS public.comments;
DROP TABLE IF EXISTS public.channels;
DROP TABLE IF EXISTS public.automation_scripts;
DROP TABLE IF EXISTS public.automation_logs;
DROP TABLE IF EXISTS public.automation_conditions;
DROP TABLE IF EXISTS public.automation_actions;
DROP SEQUENCE IF EXISTS public.audit_logs_id_seq;
DROP TABLE IF EXISTS public.audit_logs;
DROP TABLE IF EXISTS public.agent_shift_logs;
DROP TABLE IF EXISTS public.agent_schedules;
DROP TABLE IF EXISTS public.advanced_user_preferences;
DROP FUNCTION IF EXISTS storage.update_updated_at_column();
DROP FUNCTION IF EXISTS storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text);
DROP FUNCTION IF EXISTS storage.operation();
DROP FUNCTION IF EXISTS storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text);
DROP FUNCTION IF EXISTS storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text);
DROP FUNCTION IF EXISTS storage.get_size_by_bucket();
DROP FUNCTION IF EXISTS storage.foldername(name text);
DROP FUNCTION IF EXISTS storage.filename(name text);
DROP FUNCTION IF EXISTS storage.extension(name text);
DROP FUNCTION IF EXISTS storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb);
DROP FUNCTION IF EXISTS public.fn_auto_update_timestamp();
DROP TYPE IF EXISTS public.user_role;
DROP TYPE IF EXISTS public.ticket_status_type;
DROP TYPE IF EXISTS public.message_status;
DROP TYPE IF EXISTS public.message_direction;
DROP TYPE IF EXISTS public.marketing_lead_status;
DROP TYPE IF EXISTS public.marketing_campaign_status;
DROP TYPE IF EXISTS public.deal_stage;
DROP TYPE IF EXISTS public.channel_type;
DROP SCHEMA IF EXISTS storage;
DROP SCHEMA IF EXISTS public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA storage;


--
-- Name: channel_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.channel_type AS ENUM (
    'email',
    'whatsapp',
    'sms',
    'instagram',
    'chat',
    'slack'
);


--
-- Name: deal_stage; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.deal_stage AS ENUM (
    'prospect',
    'qualified',
    'proposal',
    'won',
    'lost'
);


--
-- Name: marketing_campaign_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.marketing_campaign_status AS ENUM (
    'draft',
    'active',
    'completed',
    'paused'
);


--
-- Name: marketing_lead_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.marketing_lead_status AS ENUM (
    'new',
    'engaged',
    'qualified',
    'converted',
    'unsubscribed'
);


--
-- Name: message_direction; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.message_direction AS ENUM (
    'inbound',
    'outbound'
);


--
-- Name: message_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.message_status AS ENUM (
    'queued',
    'sent',
    'read',
    'draft',
    'error'
);


--
-- Name: ticket_status_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.ticket_status_type AS ENUM (
    'open',
    'pending',
    'closed',
    'archived'
);


--
-- Name: user_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.user_role AS ENUM (
    'customer',
    'agent',
    'admin'
);


--
-- Name: fn_auto_update_timestamp(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.fn_auto_update_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;


--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
  v_order_by text;
  v_sort_order text;
begin
  case
    when sortcolumn = 'name' then
      v_order_by = 'name';
    when sortcolumn = 'updated_at' then
      v_order_by = 'updated_at';
    when sortcolumn = 'created_at' then
      v_order_by = 'created_at';
    when sortcolumn = 'last_accessed_at' then
      v_order_by = 'last_accessed_at';
    else
      v_order_by = 'name';
  end case;

  case
    when sortorder = 'asc' then
      v_sort_order = 'asc';
    when sortorder = 'desc' then
      v_sort_order = 'desc';
    else
      v_sort_order = 'asc';
  end case;

  v_order_by = v_order_by || ' ' || v_sort_order;

  return query execute
    'with folders as (
       select path_tokens[$1] as folder
       from storage.objects
         where objects.name ilike $2 || $3 || ''%''
           and bucket_id = $4
           and array_length(objects.path_tokens, 1) <> $1
       group by folder
       order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: advanced_user_preferences; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.advanced_user_preferences (
    user_id uuid NOT NULL,
    preferences jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: agent_schedules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agent_schedules (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    agent_id uuid NOT NULL,
    day_of_week integer NOT NULL,
    start_time text NOT NULL,
    end_time text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: agent_shift_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agent_shift_logs (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    agent_id uuid NOT NULL,
    shift_start timestamp with time zone NOT NULL,
    shift_end timestamp with time zone,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audit_logs (
    id bigint NOT NULL,
    actor_id uuid,
    action text NOT NULL,
    entity_name text NOT NULL,
    entity_id uuid,
    changes jsonb,
    description text,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: audit_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.audit_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: audit_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.audit_logs_id_seq OWNED BY public.audit_logs.id;


--
-- Name: automation_actions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.automation_actions (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    automation_id uuid NOT NULL,
    action_type text NOT NULL,
    action_config jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: automation_conditions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.automation_conditions (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    automation_id uuid NOT NULL,
    condition_type text NOT NULL,
    condition_config jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: automation_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.automation_logs (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    automation_id uuid,
    executed_at timestamp with time zone DEFAULT now(),
    details jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: automation_scripts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.automation_scripts (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid,
    script_name text NOT NULL,
    condition text NOT NULL,
    action text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: channels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.channels (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid NOT NULL,
    channel_type public.channel_type NOT NULL,
    external_id text NOT NULL,
    display_name text,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comments (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    entity_name text NOT NULL,
    entity_id uuid NOT NULL,
    author_id uuid,
    body text NOT NULL,
    is_private boolean DEFAULT false NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: custom_field_definitions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.custom_field_definitions (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid,
    entity_type text NOT NULL,
    field_name text NOT NULL,
    field_type text NOT NULL,
    field_label text NOT NULL,
    options jsonb DEFAULT '[]'::jsonb NOT NULL,
    is_required boolean DEFAULT false NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: custom_field_values; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.custom_field_values (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    definition_id uuid NOT NULL,
    entity_id uuid NOT NULL,
    value text,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: deal_attachments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.deal_attachments (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    deal_id uuid NOT NULL,
    file_path text NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: deals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.deals (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid NOT NULL,
    deal_name text NOT NULL,
    stage public.deal_stage DEFAULT 'prospect'::public.deal_stage NOT NULL,
    deal_value numeric(12,2),
    customer_id uuid,
    assigned_agent_id uuid,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: discovered_emails; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.discovered_emails (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    site_id uuid,
    email public.citext NOT NULL,
    context text,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: email_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.email_events (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    message_id uuid,
    event_type text NOT NULL,
    event_metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: email_usage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.email_usage (
    org_id uuid NOT NULL,
    usage_date date NOT NULL,
    emails_sent integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: escalation_rules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.escalation_rules (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid NOT NULL,
    rule_name text NOT NULL,
    condition jsonb NOT NULL,
    action jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: form_fields; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.form_fields (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    form_id uuid NOT NULL,
    field_type text NOT NULL,
    label text NOT NULL,
    options jsonb DEFAULT '[]'::jsonb NOT NULL,
    required boolean DEFAULT false NOT NULL,
    order_index integer DEFAULT 0 NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: form_submission_answers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.form_submission_answers (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    submission_id uuid NOT NULL,
    field_id uuid NOT NULL,
    answer text,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: form_submissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.form_submissions (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    form_id uuid NOT NULL,
    submitted_by uuid,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: forms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.forms (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid,
    form_name text NOT NULL,
    description text,
    is_active boolean DEFAULT false NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: ip_restrictions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ip_restrictions (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid NOT NULL,
    allowed_ip text NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: knowledge_doc_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.knowledge_doc_categories (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid NOT NULL,
    name text NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: knowledge_doc_category_links; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.knowledge_doc_category_links (
    doc_id uuid NOT NULL,
    category_id uuid NOT NULL
);


--
-- Name: knowledge_doc_chunks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.knowledge_doc_chunks (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    doc_id uuid NOT NULL,
    chunk_index integer NOT NULL,
    chunk_content text NOT NULL,
    embedding public.vector(1536),
    token_length integer DEFAULT 0 NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: knowledge_doc_localizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.knowledge_doc_localizations (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    doc_id uuid NOT NULL,
    locale text NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: knowledge_doc_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.knowledge_doc_versions (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    doc_id uuid NOT NULL,
    version_label text NOT NULL,
    content_snapshot text NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: knowledge_docs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.knowledge_docs (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    file_path text,
    source_url text,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: macro_usages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.macro_usages (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    macro_id uuid NOT NULL,
    ticket_id uuid,
    applied_by uuid,
    applied_at timestamp with time zone DEFAULT now(),
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: macros; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.macros (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid,
    name text NOT NULL,
    body text NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: marketing_campaign_members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.marketing_campaign_members (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    campaign_id uuid NOT NULL,
    user_id uuid,
    status text DEFAULT 'new'::text NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: marketing_campaigns; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.marketing_campaigns (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid NOT NULL,
    name text NOT NULL,
    description text,
    start_date timestamp with time zone,
    end_date timestamp with time zone,
    status public.marketing_campaign_status DEFAULT 'draft'::public.marketing_campaign_status NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: marketing_email_templates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.marketing_email_templates (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid,
    name text NOT NULL,
    subject text NOT NULL,
    body text NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: marketing_lead_activity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.marketing_lead_activity (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    lead_id uuid NOT NULL,
    activity_type text NOT NULL,
    details jsonb DEFAULT '{}'::jsonb NOT NULL,
    occurred_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: marketing_leads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.marketing_leads (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid,
    email public.citext,
    name text,
    phone text,
    source text,
    status public.marketing_lead_status DEFAULT 'new'::public.marketing_lead_status NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: marketing_segments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.marketing_segments (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid NOT NULL,
    segment_name text NOT NULL,
    filter_condition jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: marketing_workflow_steps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.marketing_workflow_steps (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    workflow_id uuid NOT NULL,
    step_order integer NOT NULL,
    action_type text NOT NULL,
    action_config jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: marketing_workflows; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.marketing_workflows (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid,
    workflow_name text NOT NULL,
    is_active boolean DEFAULT false NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: message_attachments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.message_attachments (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    message_id uuid NOT NULL,
    file_path text NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.messages (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    ticket_id uuid NOT NULL,
    sender_id uuid,
    direction public.message_direction NOT NULL,
    subject text NOT NULL,
    body text NOT NULL,
    status public.message_status DEFAULT 'queued'::public.message_status NOT NULL,
    confidence_score numeric(5,2) DEFAULT 0 NOT NULL,
    is_ai_generated boolean DEFAULT false NOT NULL,
    sent_at timestamp with time zone,
    received_at timestamp with time zone,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    platform_message_id text,
    channel_id uuid
);


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    notification_type text NOT NULL,
    title text,
    body text,
    read_at timestamp with time zone,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: organization_members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organization_members (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    organization_id uuid NOT NULL,
    user_id uuid NOT NULL,
    role_in_org public.user_role NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organizations (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    name text NOT NULL,
    logo_url text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: outreach_campaigns; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.outreach_campaigns (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid NOT NULL,
    name text NOT NULL,
    status text DEFAULT 'draft'::text NOT NULL,
    daily_email_limit integer DEFAULT 100 NOT NULL,
    follow_up_mode text DEFAULT 'weekly'::text NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: outreach_companies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.outreach_companies (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid,
    campaign_id uuid,
    domain text NOT NULL,
    status text DEFAULT 'scraped'::text NOT NULL,
    scraped_data jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: outreach_contacts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.outreach_contacts (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    company_id uuid NOT NULL,
    email public.citext NOT NULL,
    name text DEFAULT 'Unknown'::text NOT NULL,
    phone text,
    social_links jsonb DEFAULT '[]'::jsonb NOT NULL,
    do_not_contact boolean DEFAULT false NOT NULL,
    unsubscribed_at timestamp with time zone,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    status text DEFAULT 'new'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.permissions (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    permission_name text NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: phone_call_recordings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.phone_call_recordings (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid,
    call_id uuid,
    file_path text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: phone_calls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.phone_calls (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid,
    ticket_id uuid,
    caller_id uuid,
    call_duration integer,
    transcript text,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    ended_at timestamp with time zone
);


--
-- Name: plans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.plans (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid NOT NULL,
    name text NOT NULL,
    description text,
    price numeric DEFAULT 0 NOT NULL,
    billing_interval text NOT NULL,
    features jsonb DEFAULT '{}'::jsonb NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: reports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reports (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid NOT NULL,
    report_type text NOT NULL,
    data jsonb NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: role_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role_permissions (
    role_name public.user_role NOT NULL,
    permission_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: scraped_sites; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scraped_sites (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid,
    url text NOT NULL,
    status text DEFAULT 'pending'::text NOT NULL,
    scraped_data jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: sla_policies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sla_policies (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid NOT NULL,
    name text NOT NULL,
    first_response_hours integer NOT NULL,
    resolution_hours integer NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: sla_violations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sla_violations (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    ticket_id uuid NOT NULL,
    policy_id uuid NOT NULL,
    type text NOT NULL,
    occurred_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: subscription_usage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.subscription_usage (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid NOT NULL,
    usage_key text NOT NULL,
    usage_value numeric DEFAULT 0 NOT NULL,
    period_start timestamp with time zone NOT NULL,
    period_end timestamp with time zone NOT NULL
);


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tags (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid NOT NULL,
    name text NOT NULL,
    description text,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: team_members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.team_members (
    team_id uuid NOT NULL,
    user_id uuid NOT NULL,
    role_in_team text,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teams (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: third_party_integrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.third_party_integrations (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid NOT NULL,
    integration_type text NOT NULL,
    access_token text,
    refresh_token text,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: ticket_attachments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ticket_attachments (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    ticket_id uuid NOT NULL,
    file_path text NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: ticket_classifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ticket_classifications (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    ticket_id uuid NOT NULL,
    classification text NOT NULL,
    confidence numeric(5,2) NOT NULL,
    assigned_agent_id uuid,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: ticket_embeddings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ticket_embeddings (
    ticket_id uuid NOT NULL,
    embedding public.vector(1536),
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: ticket_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ticket_history (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    ticket_id uuid NOT NULL,
    changed_by uuid,
    old_status public.ticket_status_type,
    new_status public.ticket_status_type,
    old_assigned_agent_id uuid,
    new_assigned_agent_id uuid,
    changed_at timestamp with time zone DEFAULT now()
);


--
-- Name: ticket_summaries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ticket_summaries (
    ticket_id uuid NOT NULL,
    summary text NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: ticket_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ticket_tags (
    ticket_id uuid NOT NULL,
    tag_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: tickets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tickets (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid NOT NULL,
    status public.ticket_status_type DEFAULT 'open'::public.ticket_status_type NOT NULL,
    subject text NOT NULL,
    description text,
    customer_id uuid,
    assigned_agent_id uuid,
    category_tag text,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    sla_policy_id uuid,
    channel_id uuid
);


--
-- Name: to_do_task_comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.to_do_task_comments (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    task_id uuid NOT NULL,
    commenter_id uuid,
    body text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: to_do_tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.to_do_tasks (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    org_id uuid NOT NULL,
    assigned_to uuid,
    title text NOT NULL,
    description text,
    due_at timestamp with time zone,
    status text DEFAULT 'open'::text NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: user_api_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_api_tokens (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    token text NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    revoked_at timestamp with time zone
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    role public.user_role NOT NULL,
    org_id uuid,
    email public.citext NOT NULL,
    display_name text,
    google_refresh_token text,
    google_access_token text,
    skills text[] DEFAULT '{}'::text[],
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text
);


--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: -
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: objects; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: -
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: audit_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs ALTER COLUMN id SET DEFAULT nextval('public.audit_logs_id_seq'::regclass);


--
-- Name: advanced_user_preferences advanced_user_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.advanced_user_preferences
    ADD CONSTRAINT advanced_user_preferences_pkey PRIMARY KEY (user_id);


--
-- Name: agent_schedules agent_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_schedules
    ADD CONSTRAINT agent_schedules_pkey PRIMARY KEY (id);


--
-- Name: agent_shift_logs agent_shift_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_shift_logs
    ADD CONSTRAINT agent_shift_logs_pkey PRIMARY KEY (id);


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- Name: automation_actions automation_actions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.automation_actions
    ADD CONSTRAINT automation_actions_pkey PRIMARY KEY (id);


--
-- Name: automation_conditions automation_conditions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.automation_conditions
    ADD CONSTRAINT automation_conditions_pkey PRIMARY KEY (id);


--
-- Name: automation_logs automation_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.automation_logs
    ADD CONSTRAINT automation_logs_pkey PRIMARY KEY (id);


--
-- Name: automation_scripts automation_scripts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.automation_scripts
    ADD CONSTRAINT automation_scripts_pkey PRIMARY KEY (id);


--
-- Name: channels channels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: custom_field_definitions custom_field_definitions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_field_definitions
    ADD CONSTRAINT custom_field_definitions_pkey PRIMARY KEY (id);


--
-- Name: custom_field_values custom_field_values_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_field_values
    ADD CONSTRAINT custom_field_values_pkey PRIMARY KEY (id);


--
-- Name: deal_attachments deal_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal_attachments
    ADD CONSTRAINT deal_attachments_pkey PRIMARY KEY (id);


--
-- Name: deals deals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_pkey PRIMARY KEY (id);


--
-- Name: discovered_emails discovered_emails_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discovered_emails
    ADD CONSTRAINT discovered_emails_pkey PRIMARY KEY (id);


--
-- Name: email_events email_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_events
    ADD CONSTRAINT email_events_pkey PRIMARY KEY (id);


--
-- Name: email_usage email_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_usage
    ADD CONSTRAINT email_usage_pkey PRIMARY KEY (org_id, usage_date);


--
-- Name: escalation_rules escalation_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.escalation_rules
    ADD CONSTRAINT escalation_rules_pkey PRIMARY KEY (id);


--
-- Name: form_fields form_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.form_fields
    ADD CONSTRAINT form_fields_pkey PRIMARY KEY (id);


--
-- Name: form_submission_answers form_submission_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.form_submission_answers
    ADD CONSTRAINT form_submission_answers_pkey PRIMARY KEY (id);


--
-- Name: form_submissions form_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.form_submissions
    ADD CONSTRAINT form_submissions_pkey PRIMARY KEY (id);


--
-- Name: forms forms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.forms
    ADD CONSTRAINT forms_pkey PRIMARY KEY (id);


--
-- Name: ip_restrictions ip_restrictions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ip_restrictions
    ADD CONSTRAINT ip_restrictions_pkey PRIMARY KEY (id);


--
-- Name: knowledge_doc_categories knowledge_doc_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.knowledge_doc_categories
    ADD CONSTRAINT knowledge_doc_categories_pkey PRIMARY KEY (id);


--
-- Name: knowledge_doc_category_links knowledge_doc_category_links_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.knowledge_doc_category_links
    ADD CONSTRAINT knowledge_doc_category_links_pkey PRIMARY KEY (doc_id, category_id);


--
-- Name: knowledge_doc_chunks knowledge_doc_chunks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.knowledge_doc_chunks
    ADD CONSTRAINT knowledge_doc_chunks_pkey PRIMARY KEY (id);


--
-- Name: knowledge_doc_localizations knowledge_doc_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.knowledge_doc_localizations
    ADD CONSTRAINT knowledge_doc_localizations_pkey PRIMARY KEY (id);


--
-- Name: knowledge_doc_versions knowledge_doc_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.knowledge_doc_versions
    ADD CONSTRAINT knowledge_doc_versions_pkey PRIMARY KEY (id);


--
-- Name: knowledge_docs knowledge_docs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.knowledge_docs
    ADD CONSTRAINT knowledge_docs_pkey PRIMARY KEY (id);


--
-- Name: macro_usages macro_usages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.macro_usages
    ADD CONSTRAINT macro_usages_pkey PRIMARY KEY (id);


--
-- Name: macros macros_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.macros
    ADD CONSTRAINT macros_pkey PRIMARY KEY (id);


--
-- Name: marketing_campaign_members marketing_campaign_members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketing_campaign_members
    ADD CONSTRAINT marketing_campaign_members_pkey PRIMARY KEY (id);


--
-- Name: marketing_campaigns marketing_campaigns_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketing_campaigns
    ADD CONSTRAINT marketing_campaigns_pkey PRIMARY KEY (id);


--
-- Name: marketing_email_templates marketing_email_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketing_email_templates
    ADD CONSTRAINT marketing_email_templates_pkey PRIMARY KEY (id);


--
-- Name: marketing_lead_activity marketing_lead_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketing_lead_activity
    ADD CONSTRAINT marketing_lead_activity_pkey PRIMARY KEY (id);


--
-- Name: marketing_leads marketing_leads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketing_leads
    ADD CONSTRAINT marketing_leads_pkey PRIMARY KEY (id);


--
-- Name: marketing_segments marketing_segments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketing_segments
    ADD CONSTRAINT marketing_segments_pkey PRIMARY KEY (id);


--
-- Name: marketing_workflow_steps marketing_workflow_steps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketing_workflow_steps
    ADD CONSTRAINT marketing_workflow_steps_pkey PRIMARY KEY (id);


--
-- Name: marketing_workflows marketing_workflows_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketing_workflows
    ADD CONSTRAINT marketing_workflows_pkey PRIMARY KEY (id);


--
-- Name: message_attachments message_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_attachments
    ADD CONSTRAINT message_attachments_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: organization_members organization_members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_members
    ADD CONSTRAINT organization_members_pkey PRIMARY KEY (id);


--
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: outreach_campaigns outreach_campaigns_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.outreach_campaigns
    ADD CONSTRAINT outreach_campaigns_pkey PRIMARY KEY (id);


--
-- Name: outreach_companies outreach_companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.outreach_companies
    ADD CONSTRAINT outreach_companies_pkey PRIMARY KEY (id);


--
-- Name: outreach_contacts outreach_contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.outreach_contacts
    ADD CONSTRAINT outreach_contacts_pkey PRIMARY KEY (id);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: phone_call_recordings phone_call_recordings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.phone_call_recordings
    ADD CONSTRAINT phone_call_recordings_pkey PRIMARY KEY (id);


--
-- Name: phone_calls phone_calls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.phone_calls
    ADD CONSTRAINT phone_calls_pkey PRIMARY KEY (id);


--
-- Name: plans plans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plans
    ADD CONSTRAINT plans_pkey PRIMARY KEY (id);


--
-- Name: reports reports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);


--
-- Name: role_permissions role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (role_name, permission_id);


--
-- Name: scraped_sites scraped_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scraped_sites
    ADD CONSTRAINT scraped_sites_pkey PRIMARY KEY (id);


--
-- Name: sla_policies sla_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sla_policies
    ADD CONSTRAINT sla_policies_pkey PRIMARY KEY (id);


--
-- Name: sla_violations sla_violations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sla_violations
    ADD CONSTRAINT sla_violations_pkey PRIMARY KEY (id);


--
-- Name: subscription_usage subscription_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subscription_usage
    ADD CONSTRAINT subscription_usage_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: team_members team_members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.team_members
    ADD CONSTRAINT team_members_pkey PRIMARY KEY (team_id, user_id);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: third_party_integrations third_party_integrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.third_party_integrations
    ADD CONSTRAINT third_party_integrations_pkey PRIMARY KEY (id);


--
-- Name: ticket_attachments ticket_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ticket_attachments
    ADD CONSTRAINT ticket_attachments_pkey PRIMARY KEY (id);


--
-- Name: ticket_classifications ticket_classifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ticket_classifications
    ADD CONSTRAINT ticket_classifications_pkey PRIMARY KEY (id);


--
-- Name: ticket_embeddings ticket_embeddings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ticket_embeddings
    ADD CONSTRAINT ticket_embeddings_pkey PRIMARY KEY (ticket_id);


--
-- Name: ticket_history ticket_history_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ticket_history
    ADD CONSTRAINT ticket_history_pkey PRIMARY KEY (id);


--
-- Name: ticket_summaries ticket_summaries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ticket_summaries
    ADD CONSTRAINT ticket_summaries_pkey PRIMARY KEY (ticket_id);


--
-- Name: ticket_tags ticket_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ticket_tags
    ADD CONSTRAINT ticket_tags_pkey PRIMARY KEY (ticket_id, tag_id);


--
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (id);


--
-- Name: to_do_task_comments to_do_task_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.to_do_task_comments
    ADD CONSTRAINT to_do_task_comments_pkey PRIMARY KEY (id);


--
-- Name: to_do_tasks to_do_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.to_do_tasks
    ADD CONSTRAINT to_do_tasks_pkey PRIMARY KEY (id);


--
-- Name: user_api_tokens user_api_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_api_tokens
    ADD CONSTRAINT user_api_tokens_pkey PRIMARY KEY (id);


--
-- Name: user_api_tokens user_api_tokens_token_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_api_tokens
    ADD CONSTRAINT user_api_tokens_token_key UNIQUE (token);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: idx_email_events_message_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_email_events_message_id ON public.email_events USING btree (message_id);


--
-- Name: idx_kdoc_chunks_embedding; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_kdoc_chunks_embedding ON public.knowledge_doc_chunks USING ivfflat (embedding public.vector_cosine_ops) WITH (lists='100');


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: advanced_user_preferences tr_adv_user_prefs_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_adv_user_prefs_update BEFORE UPDATE ON public.advanced_user_preferences FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: agent_schedules tr_agent_schedules_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_agent_schedules_update BEFORE UPDATE ON public.agent_schedules FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: agent_shift_logs tr_agent_shift_logs_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_agent_shift_logs_update BEFORE UPDATE ON public.agent_shift_logs FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: automation_scripts tr_automation_scripts_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_automation_scripts_update BEFORE UPDATE ON public.automation_scripts FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: channels tr_channels_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_channels_update BEFORE UPDATE ON public.channels FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: custom_field_definitions tr_custom_field_definitions_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_custom_field_definitions_update BEFORE UPDATE ON public.custom_field_definitions FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: custom_field_values tr_custom_field_values_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_custom_field_values_update BEFORE UPDATE ON public.custom_field_values FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: deals tr_deals_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_deals_update_timestamp BEFORE UPDATE ON public.deals FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: email_usage tr_email_usage_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_email_usage_update BEFORE UPDATE ON public.email_usage FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: escalation_rules tr_escalation_rules_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_escalation_rules_update BEFORE UPDATE ON public.escalation_rules FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: form_fields tr_form_fields_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_form_fields_update BEFORE UPDATE ON public.form_fields FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: forms tr_forms_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_forms_update BEFORE UPDATE ON public.forms FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: knowledge_doc_categories tr_kdoc_categories_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_kdoc_categories_update_timestamp BEFORE UPDATE ON public.knowledge_doc_categories FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: knowledge_doc_chunks tr_kdoc_chunks_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_kdoc_chunks_update_timestamp BEFORE UPDATE ON public.knowledge_doc_chunks FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: knowledge_doc_localizations tr_kdoc_localizations_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_kdoc_localizations_update BEFORE UPDATE ON public.knowledge_doc_localizations FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: knowledge_docs tr_kdocs_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_kdocs_update_timestamp BEFORE UPDATE ON public.knowledge_docs FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: macros tr_macros_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_macros_update BEFORE UPDATE ON public.macros FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: marketing_campaign_members tr_marketing_campaign_members_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_marketing_campaign_members_update BEFORE UPDATE ON public.marketing_campaign_members FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: marketing_campaigns tr_marketing_campaigns_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_marketing_campaigns_update BEFORE UPDATE ON public.marketing_campaigns FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: marketing_email_templates tr_marketing_email_templates_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_marketing_email_templates_update BEFORE UPDATE ON public.marketing_email_templates FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: marketing_leads tr_marketing_leads_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_marketing_leads_update BEFORE UPDATE ON public.marketing_leads FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: marketing_segments tr_marketing_segments_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_marketing_segments_update BEFORE UPDATE ON public.marketing_segments FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: marketing_workflow_steps tr_marketing_workflow_steps_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_marketing_workflow_steps_update BEFORE UPDATE ON public.marketing_workflow_steps FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: marketing_workflows tr_marketing_workflows_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_marketing_workflows_update BEFORE UPDATE ON public.marketing_workflows FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: messages tr_messages_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_messages_update_timestamp BEFORE UPDATE ON public.messages FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: notifications tr_notifications_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_notifications_update BEFORE UPDATE ON public.notifications FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: organization_members tr_org_members_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_org_members_update_timestamp BEFORE UPDATE ON public.organization_members FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: organizations tr_organizations_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_organizations_update_timestamp BEFORE UPDATE ON public.organizations FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: outreach_campaigns tr_outreach_campaigns_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_outreach_campaigns_update BEFORE UPDATE ON public.outreach_campaigns FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: outreach_companies tr_outreach_companies_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_outreach_companies_update BEFORE UPDATE ON public.outreach_companies FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: outreach_contacts tr_outreach_contacts_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_outreach_contacts_update BEFORE UPDATE ON public.outreach_contacts FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: plans tr_plans_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_plans_update_timestamp BEFORE UPDATE ON public.plans FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: reports tr_reports_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_reports_update BEFORE UPDATE ON public.reports FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: scraped_sites tr_scraped_sites_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_scraped_sites_update BEFORE UPDATE ON public.scraped_sites FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: tags tr_tags_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_tags_update BEFORE UPDATE ON public.tags FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: teams tr_teams_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_teams_update_timestamp BEFORE UPDATE ON public.teams FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: third_party_integrations tr_third_party_integrations_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_third_party_integrations_update BEFORE UPDATE ON public.third_party_integrations FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: ticket_embeddings tr_ticket_embeddings_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_ticket_embeddings_update BEFORE UPDATE ON public.ticket_embeddings FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: ticket_summaries tr_ticket_summaries_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_ticket_summaries_update BEFORE UPDATE ON public.ticket_summaries FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: tickets tr_tickets_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_tickets_update_timestamp BEFORE UPDATE ON public.tickets FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: to_do_tasks tr_to_do_tasks_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_to_do_tasks_update BEFORE UPDATE ON public.to_do_tasks FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: users tr_users_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_users_update_timestamp BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.fn_auto_update_timestamp();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: advanced_user_preferences advanced_user_preferences_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.advanced_user_preferences
    ADD CONSTRAINT advanced_user_preferences_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: agent_schedules agent_schedules_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_schedules
    ADD CONSTRAINT agent_schedules_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: agent_shift_logs agent_shift_logs_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_shift_logs
    ADD CONSTRAINT agent_shift_logs_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: audit_logs audit_logs_actor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: automation_actions automation_actions_automation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.automation_actions
    ADD CONSTRAINT automation_actions_automation_id_fkey FOREIGN KEY (automation_id) REFERENCES public.automation_scripts(id) ON DELETE CASCADE;


--
-- Name: automation_conditions automation_conditions_automation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.automation_conditions
    ADD CONSTRAINT automation_conditions_automation_id_fkey FOREIGN KEY (automation_id) REFERENCES public.automation_scripts(id) ON DELETE CASCADE;


--
-- Name: automation_logs automation_logs_automation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.automation_logs
    ADD CONSTRAINT automation_logs_automation_id_fkey FOREIGN KEY (automation_id) REFERENCES public.automation_scripts(id) ON DELETE CASCADE;


--
-- Name: automation_scripts automation_scripts_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.automation_scripts
    ADD CONSTRAINT automation_scripts_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: channels channels_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: comments comments_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: custom_field_definitions custom_field_definitions_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_field_definitions
    ADD CONSTRAINT custom_field_definitions_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: custom_field_values custom_field_values_definition_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_field_values
    ADD CONSTRAINT custom_field_values_definition_id_fkey FOREIGN KEY (definition_id) REFERENCES public.custom_field_definitions(id) ON DELETE CASCADE;


--
-- Name: deal_attachments deal_attachments_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal_attachments
    ADD CONSTRAINT deal_attachments_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deals(id) ON DELETE CASCADE;


--
-- Name: deals deals_assigned_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_assigned_agent_id_fkey FOREIGN KEY (assigned_agent_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: deals deals_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: deals deals_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: discovered_emails discovered_emails_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discovered_emails
    ADD CONSTRAINT discovered_emails_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.scraped_sites(id) ON DELETE CASCADE;


--
-- Name: email_events email_events_message_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_events
    ADD CONSTRAINT email_events_message_id_fkey FOREIGN KEY (message_id) REFERENCES public.messages(id) ON DELETE CASCADE;


--
-- Name: email_usage email_usage_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_usage
    ADD CONSTRAINT email_usage_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: escalation_rules escalation_rules_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.escalation_rules
    ADD CONSTRAINT escalation_rules_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: form_fields form_fields_form_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.form_fields
    ADD CONSTRAINT form_fields_form_id_fkey FOREIGN KEY (form_id) REFERENCES public.forms(id) ON DELETE CASCADE;


--
-- Name: form_submission_answers form_submission_answers_field_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.form_submission_answers
    ADD CONSTRAINT form_submission_answers_field_id_fkey FOREIGN KEY (field_id) REFERENCES public.form_fields(id) ON DELETE CASCADE;


--
-- Name: form_submission_answers form_submission_answers_submission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.form_submission_answers
    ADD CONSTRAINT form_submission_answers_submission_id_fkey FOREIGN KEY (submission_id) REFERENCES public.form_submissions(id) ON DELETE CASCADE;


--
-- Name: form_submissions form_submissions_form_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.form_submissions
    ADD CONSTRAINT form_submissions_form_id_fkey FOREIGN KEY (form_id) REFERENCES public.forms(id) ON DELETE CASCADE;


--
-- Name: form_submissions form_submissions_submitted_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.form_submissions
    ADD CONSTRAINT form_submissions_submitted_by_fkey FOREIGN KEY (submitted_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: forms forms_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.forms
    ADD CONSTRAINT forms_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: ip_restrictions ip_restrictions_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ip_restrictions
    ADD CONSTRAINT ip_restrictions_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: knowledge_doc_categories knowledge_doc_categories_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.knowledge_doc_categories
    ADD CONSTRAINT knowledge_doc_categories_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: knowledge_doc_category_links knowledge_doc_category_links_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.knowledge_doc_category_links
    ADD CONSTRAINT knowledge_doc_category_links_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.knowledge_doc_categories(id) ON DELETE CASCADE;


--
-- Name: knowledge_doc_category_links knowledge_doc_category_links_doc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.knowledge_doc_category_links
    ADD CONSTRAINT knowledge_doc_category_links_doc_id_fkey FOREIGN KEY (doc_id) REFERENCES public.knowledge_docs(id) ON DELETE CASCADE;


--
-- Name: knowledge_doc_chunks knowledge_doc_chunks_doc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.knowledge_doc_chunks
    ADD CONSTRAINT knowledge_doc_chunks_doc_id_fkey FOREIGN KEY (doc_id) REFERENCES public.knowledge_docs(id) ON DELETE CASCADE;


--
-- Name: knowledge_doc_localizations knowledge_doc_localizations_doc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.knowledge_doc_localizations
    ADD CONSTRAINT knowledge_doc_localizations_doc_id_fkey FOREIGN KEY (doc_id) REFERENCES public.knowledge_docs(id) ON DELETE CASCADE;


--
-- Name: knowledge_doc_versions knowledge_doc_versions_doc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.knowledge_doc_versions
    ADD CONSTRAINT knowledge_doc_versions_doc_id_fkey FOREIGN KEY (doc_id) REFERENCES public.knowledge_docs(id) ON DELETE CASCADE;


--
-- Name: knowledge_docs knowledge_docs_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.knowledge_docs
    ADD CONSTRAINT knowledge_docs_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: macro_usages macro_usages_applied_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.macro_usages
    ADD CONSTRAINT macro_usages_applied_by_fkey FOREIGN KEY (applied_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: macro_usages macro_usages_macro_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.macro_usages
    ADD CONSTRAINT macro_usages_macro_id_fkey FOREIGN KEY (macro_id) REFERENCES public.macros(id) ON DELETE CASCADE;


--
-- Name: macro_usages macro_usages_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.macro_usages
    ADD CONSTRAINT macro_usages_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.tickets(id) ON DELETE CASCADE;


--
-- Name: macros macros_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.macros
    ADD CONSTRAINT macros_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: marketing_campaign_members marketing_campaign_members_campaign_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketing_campaign_members
    ADD CONSTRAINT marketing_campaign_members_campaign_id_fkey FOREIGN KEY (campaign_id) REFERENCES public.marketing_campaigns(id) ON DELETE CASCADE;


--
-- Name: marketing_campaign_members marketing_campaign_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketing_campaign_members
    ADD CONSTRAINT marketing_campaign_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: marketing_campaigns marketing_campaigns_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketing_campaigns
    ADD CONSTRAINT marketing_campaigns_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: marketing_email_templates marketing_email_templates_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketing_email_templates
    ADD CONSTRAINT marketing_email_templates_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: marketing_lead_activity marketing_lead_activity_lead_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketing_lead_activity
    ADD CONSTRAINT marketing_lead_activity_lead_id_fkey FOREIGN KEY (lead_id) REFERENCES public.marketing_leads(id) ON DELETE CASCADE;


--
-- Name: marketing_leads marketing_leads_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketing_leads
    ADD CONSTRAINT marketing_leads_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: marketing_segments marketing_segments_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketing_segments
    ADD CONSTRAINT marketing_segments_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: marketing_workflow_steps marketing_workflow_steps_workflow_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketing_workflow_steps
    ADD CONSTRAINT marketing_workflow_steps_workflow_id_fkey FOREIGN KEY (workflow_id) REFERENCES public.marketing_workflows(id) ON DELETE CASCADE;


--
-- Name: marketing_workflows marketing_workflows_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketing_workflows
    ADD CONSTRAINT marketing_workflows_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: message_attachments message_attachments_message_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_attachments
    ADD CONSTRAINT message_attachments_message_id_fkey FOREIGN KEY (message_id) REFERENCES public.messages(id) ON DELETE CASCADE;


--
-- Name: messages messages_channel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_channel_id_fkey FOREIGN KEY (channel_id) REFERENCES public.channels(id) ON DELETE SET NULL;


--
-- Name: messages messages_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: messages messages_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.tickets(id) ON DELETE CASCADE;


--
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: organization_members organization_members_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_members
    ADD CONSTRAINT organization_members_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: organization_members organization_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_members
    ADD CONSTRAINT organization_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: outreach_campaigns outreach_campaigns_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.outreach_campaigns
    ADD CONSTRAINT outreach_campaigns_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: outreach_companies outreach_companies_campaign_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.outreach_companies
    ADD CONSTRAINT outreach_companies_campaign_id_fkey FOREIGN KEY (campaign_id) REFERENCES public.outreach_campaigns(id) ON DELETE CASCADE;


--
-- Name: outreach_companies outreach_companies_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.outreach_companies
    ADD CONSTRAINT outreach_companies_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: outreach_contacts outreach_contacts_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.outreach_contacts
    ADD CONSTRAINT outreach_contacts_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.outreach_companies(id) ON DELETE CASCADE;


--
-- Name: phone_call_recordings phone_call_recordings_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.phone_call_recordings
    ADD CONSTRAINT phone_call_recordings_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: phone_calls phone_calls_caller_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.phone_calls
    ADD CONSTRAINT phone_calls_caller_id_fkey FOREIGN KEY (caller_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: phone_calls phone_calls_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.phone_calls
    ADD CONSTRAINT phone_calls_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: phone_calls phone_calls_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.phone_calls
    ADD CONSTRAINT phone_calls_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.tickets(id) ON DELETE CASCADE;


--
-- Name: plans plans_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plans
    ADD CONSTRAINT plans_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: reports reports_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: role_permissions role_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- Name: scraped_sites scraped_sites_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scraped_sites
    ADD CONSTRAINT scraped_sites_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: sla_policies sla_policies_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sla_policies
    ADD CONSTRAINT sla_policies_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: sla_violations sla_violations_policy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sla_violations
    ADD CONSTRAINT sla_violations_policy_id_fkey FOREIGN KEY (policy_id) REFERENCES public.sla_policies(id) ON DELETE CASCADE;


--
-- Name: sla_violations sla_violations_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sla_violations
    ADD CONSTRAINT sla_violations_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.tickets(id) ON DELETE CASCADE;


--
-- Name: subscription_usage subscription_usage_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subscription_usage
    ADD CONSTRAINT subscription_usage_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: tags tags_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: team_members team_members_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.team_members
    ADD CONSTRAINT team_members_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(id) ON DELETE CASCADE;


--
-- Name: team_members team_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.team_members
    ADD CONSTRAINT team_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: teams teams_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: third_party_integrations third_party_integrations_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.third_party_integrations
    ADD CONSTRAINT third_party_integrations_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: ticket_attachments ticket_attachments_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ticket_attachments
    ADD CONSTRAINT ticket_attachments_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.tickets(id) ON DELETE CASCADE;


--
-- Name: ticket_classifications ticket_classifications_assigned_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ticket_classifications
    ADD CONSTRAINT ticket_classifications_assigned_agent_id_fkey FOREIGN KEY (assigned_agent_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: ticket_classifications ticket_classifications_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ticket_classifications
    ADD CONSTRAINT ticket_classifications_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.tickets(id) ON DELETE CASCADE;


--
-- Name: ticket_embeddings ticket_embeddings_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ticket_embeddings
    ADD CONSTRAINT ticket_embeddings_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.tickets(id) ON DELETE CASCADE;


--
-- Name: ticket_history ticket_history_changed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ticket_history
    ADD CONSTRAINT ticket_history_changed_by_fkey FOREIGN KEY (changed_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: ticket_history ticket_history_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ticket_history
    ADD CONSTRAINT ticket_history_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.tickets(id) ON DELETE CASCADE;


--
-- Name: ticket_summaries ticket_summaries_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ticket_summaries
    ADD CONSTRAINT ticket_summaries_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.tickets(id) ON DELETE CASCADE;


--
-- Name: ticket_tags ticket_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ticket_tags
    ADD CONSTRAINT ticket_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- Name: ticket_tags ticket_tags_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ticket_tags
    ADD CONSTRAINT ticket_tags_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.tickets(id) ON DELETE CASCADE;


--
-- Name: tickets tickets_assigned_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_assigned_agent_id_fkey FOREIGN KEY (assigned_agent_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: tickets tickets_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: tickets tickets_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: to_do_task_comments to_do_task_comments_commenter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.to_do_task_comments
    ADD CONSTRAINT to_do_task_comments_commenter_id_fkey FOREIGN KEY (commenter_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: to_do_task_comments to_do_task_comments_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.to_do_task_comments
    ADD CONSTRAINT to_do_task_comments_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.to_do_tasks(id) ON DELETE CASCADE;


--
-- Name: to_do_tasks to_do_tasks_assigned_to_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.to_do_tasks
    ADD CONSTRAINT to_do_tasks_assigned_to_fkey FOREIGN KEY (assigned_to) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: to_do_tasks to_do_tasks_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.to_do_tasks
    ADD CONSTRAINT to_do_tasks_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: user_api_tokens user_api_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_api_tokens
    ADD CONSTRAINT user_api_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: users users_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_org_id_fkey FOREIGN KEY (org_id) REFERENCES public.organizations(id) ON DELETE SET NULL;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- PostgreSQL database dump complete
--


