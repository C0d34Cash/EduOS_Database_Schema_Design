-- ============================================================
-- Module 4 - OCR & AI Knowledge
-- 02_tables.sql
-- ============================================================
-- ========== 1. ocr_documents ==========
CREATE TABLE ocr_documents (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    resource_id UUID NOT NULL,
    -- FK → resources.id (usually pdf_documents)
    pdf_document_id UUID NULL,
    -- optional direct link
    status ocr_document_status_enum NOT NULL DEFAULT 'PENDING',
    total_pages INTEGER NULL,
    processed_pages INTEGER NOT NULL DEFAULT 0,
    language VARCHAR(10) NOT NULL DEFAULT 'en',
    ocr_engine VARCHAR(50) NULL,
    -- e.g. 'tesseract', 'google_vision', 'azure'
    error_message TEXT NULL,
    started_at TIMESTAMPTZ NULL,
    completed_at TIMESTAMPTZ NULL,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_ocr_documents_resource UNIQUE (resource_id)
);
COMMENT ON TABLE ocr_documents IS 'Tracks OCR processing job for a document';
-- ========== 2. document_pages ==========
CREATE TABLE document_pages (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    ocr_document_id UUID NOT NULL,
    resource_id UUID NOT NULL,
    page_number INTEGER NOT NULL,
    width INTEGER NULL,
    height INTEGER NULL,
    raw_text TEXT NULL,
    -- full page text
    confidence_score NUMERIC(5, 2) NULL,
    -- 0.00 - 100.00
    image_path TEXT NULL,
    -- optional page image
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_document_pages_page UNIQUE (ocr_document_id, page_number)
);
COMMENT ON TABLE document_pages IS 'Individual pages extracted from OCR documents';
-- ========== 3. text_chunks ==========
CREATE TABLE text_chunks (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    ocr_document_id UUID NOT NULL,
    document_page_id UUID NULL,
    resource_id UUID NOT NULL,
    subject_id UUID NULL,
    unit_id UUID NULL,
    topic_id UUID NULL,
    chunk_index INTEGER NOT NULL,
    -- sequential order
    content TEXT NOT NULL,
    chunk_type chunk_type_enum NOT NULL DEFAULT 'PARAGRAPH',
    token_count INTEGER NULL,
    start_page INTEGER NULL,
    end_page INTEGER NULL,
    bounding_box JSONB NULL,
    -- optional coordinates
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL
);
COMMENT ON TABLE text_chunks IS 'Semantically meaningful text chunks for embedding & retrieval';
-- ========== 4. embeddings ==========
CREATE TABLE embeddings (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    chunk_id UUID NOT NULL,
    -- FK → text_chunks.id
    resource_id UUID NOT NULL,
    model embedding_model_enum NOT NULL DEFAULT 'TEXT_EMBEDDING_3_SMALL',
    model_version VARCHAR(50) NULL,
    dimensions INTEGER NOT NULL,
    -- e.g. 1536, 3072
    embedding VECTOR NOT NULL,
    -- requires pgvector extension
    token_count INTEGER NULL,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_embeddings_chunk_model UNIQUE (chunk_id, model)
);
COMMENT ON TABLE embeddings IS 'Vector embeddings of text chunks (requires pgvector)';
-- ========== 5. citation_contexts ==========
CREATE TABLE citation_contexts (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    chunk_id UUID NOT NULL,
    resource_id UUID NOT NULL,
    chat_message_id UUID NULL,
    -- will link to Module 5 later
    citation_type citation_type_enum NOT NULL DEFAULT 'DIRECT_QUOTE',
    cited_text TEXT NOT NULL,
    context_before TEXT NULL,
    context_after TEXT NULL,
    relevance_score NUMERIC(5, 4) NULL,
    -- 0.0000 - 1.0000
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL
);
COMMENT ON TABLE citation_contexts IS 'Stores citation references used by AI Tutor answers';