-- ============================================================
-- Module 3 - Learning Resources
-- 02_tables.sql
-- ============================================================
-- ========== 1. resources (Base table) ==========
CREATE TABLE resources (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    resource_type resource_type_enum NOT NULL,
    title VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL,
    description TEXT NULL,
    subject_id UUID NULL,
    unit_id UUID NULL,
    topic_id UUID NULL,
    department_id UUID NULL,
    uploaded_by UUID NULL,
    status resource_status_enum NOT NULL DEFAULT 'DRAFT',
    visibility resource_visibility_enum NOT NULL DEFAULT 'INSTITUTION',
    is_official BOOLEAN NOT NULL DEFAULT FALSE,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    published_at TIMESTAMPTZ NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_resources_slug_institution UNIQUE (institution_id, slug)
);
COMMENT ON TABLE resources IS 'Central registry of every learning resource (polymorphic base)';
-- ========== 2. pdf_documents ==========
CREATE TABLE pdf_documents (
    id UUID PRIMARY KEY,
    resource_id UUID NOT NULL,
    institution_id UUID NOT NULL,
    file_name VARCHAR(255) NOT NULL,
    file_size_bytes BIGINT NOT NULL,
    page_count INTEGER NULL,
    mime_type VARCHAR(100) NOT NULL DEFAULT 'application/pdf',
    storage_path TEXT NOT NULL,
    storage_provider VARCHAR(50) NOT NULL DEFAULT 'S3',
    checksum_sha256 VARCHAR(64) NULL,
    is_searchable BOOLEAN NOT NULL DEFAULT FALSE,
    ocr_status ocr_status_enum NOT NULL DEFAULT 'PENDING',
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_pdf_documents_resource UNIQUE (resource_id)
);
COMMENT ON TABLE pdf_documents IS 'Detailed information for PDF learning resources';
-- ========== 3. videos ==========
CREATE TABLE videos (
    id UUID PRIMARY KEY,
    resource_id UUID NOT NULL,
    institution_id UUID NOT NULL,
    provider video_provider_enum NOT NULL DEFAULT 'YOUTUBE',
    external_id VARCHAR(150) NULL,
    url TEXT NOT NULL,
    duration_seconds INTEGER NULL,
    thumbnail_url TEXT NULL,
    embed_code TEXT NULL,
    is_downloadable BOOLEAN NOT NULL DEFAULT FALSE,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_videos_resource UNIQUE (resource_id)
);
COMMENT ON TABLE videos IS 'Video learning resources (YouTube, Vimeo, self-hosted, etc.)';
-- ========== 4. web_resources ==========
CREATE TABLE web_resources (
    id UUID PRIMARY KEY,
    resource_id UUID NOT NULL,
    institution_id UUID NOT NULL,
    url TEXT NOT NULL,
    domain VARCHAR(255) NULL,
    favicon_url TEXT NULL,
    is_verified BOOLEAN NOT NULL DEFAULT FALSE,
    last_checked_at TIMESTAMPTZ NULL,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_web_resources_resource UNIQUE (resource_id)
);
COMMENT ON TABLE web_resources IS 'External web links and articles';
-- ========== 5. official_syllabus ==========
CREATE TABLE official_syllabus (
    id UUID PRIMARY KEY,
    resource_id UUID NOT NULL,
    institution_id UUID NOT NULL,
    program_id UUID NULL,
    academic_year_id UUID NULL,
    semester_id UUID NULL,
    regulation_year SMALLINT NULL,
    official_code VARCHAR(50) NULL,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_official_syllabus_resource UNIQUE (resource_id)
);
COMMENT ON TABLE official_syllabus IS 'Official syllabus documents released by the institution/university';
-- ========== 6. tags ==========
CREATE TABLE tags (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(120) NOT NULL,
    color VARCHAR(20) NULL,
    description TEXT NULL,
    usage_count INTEGER NOT NULL DEFAULT 0,
    status tag_status_enum NOT NULL DEFAULT 'ACTIVE',
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_tags_slug_institution UNIQUE (institution_id, slug),
    CONSTRAINT uq_tags_name_institution UNIQUE (institution_id, name)
);
COMMENT ON TABLE tags IS 'Global tagging system for learning resources';
-- ========== 7. resource_tags (Junction) ==========
CREATE TABLE resource_tags (
    id UUID PRIMARY KEY,
    resource_id UUID NOT NULL,
    tag_id UUID NOT NULL,
    institution_id UUID NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_resource_tags UNIQUE (resource_id, tag_id)
);
COMMENT ON TABLE resource_tags IS 'Many-to-many relationship between resources and tags';