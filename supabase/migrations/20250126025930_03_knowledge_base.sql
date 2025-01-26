-- Knowledge Base Tables
CREATE TABLE IF NOT EXISTS knowledge_docs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    org_id UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    file_path TEXT,
    source_url TEXT,
    metadata JSONB DEFAULT '{}' NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TRIGGER tr_kdocs_update_timestamp
    BEFORE UPDATE ON knowledge_docs
    FOR EACH ROW
    EXECUTE FUNCTION fn_auto_update_timestamp();

CREATE TABLE IF NOT EXISTS knowledge_doc_chunks (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    doc_id UUID NOT NULL REFERENCES knowledge_docs(id) ON DELETE CASCADE,
    chunk_index INTEGER NOT NULL,
    chunk_content TEXT NOT NULL,
    embedding vector(1536),
    token_length INTEGER DEFAULT 0 NOT NULL,
    metadata JSONB DEFAULT '{}' NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_kdoc_chunks_embedding ON knowledge_doc_chunks 
    USING ivfflat (embedding vector_cosine_ops)
    WITH (lists = 100);

CREATE TRIGGER tr_kdoc_chunks_update_timestamp
    BEFORE UPDATE ON knowledge_doc_chunks
    FOR EACH ROW
    EXECUTE FUNCTION fn_auto_update_timestamp();

CREATE TABLE IF NOT EXISTS knowledge_doc_categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    org_id UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TRIGGER tr_kdoc_categories_update_timestamp
    BEFORE UPDATE ON knowledge_doc_categories
    FOR EACH ROW
    EXECUTE FUNCTION fn_auto_update_timestamp();

CREATE TABLE IF NOT EXISTS knowledge_doc_category_links (
    doc_id UUID NOT NULL REFERENCES knowledge_docs(id) ON DELETE CASCADE,
    category_id UUID NOT NULL REFERENCES knowledge_doc_categories(id) ON DELETE CASCADE,
    PRIMARY KEY (doc_id, category_id)
);

CREATE TABLE IF NOT EXISTS knowledge_doc_versions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    doc_id UUID NOT NULL REFERENCES knowledge_docs(id) ON DELETE CASCADE,
    version_label TEXT NOT NULL,
    content_snapshot TEXT NOT NULL,
    metadata JSONB DEFAULT '{}' NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TABLE IF NOT EXISTS knowledge_doc_localizations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    doc_id UUID NOT NULL REFERENCES knowledge_docs(id) ON DELETE CASCADE,
    locale TEXT NOT NULL,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    metadata JSONB DEFAULT '{}' NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TRIGGER tr_kdoc_localizations_update
    BEFORE UPDATE ON knowledge_doc_localizations
    FOR EACH ROW
    EXECUTE FUNCTION fn_auto_update_timestamp(); 
