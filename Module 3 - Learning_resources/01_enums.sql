-- ============================================================
-- Module 3 - Learning Resources
-- 01_enums.sql
-- ============================================================
CREATE TYPE resource_type_enum AS ENUM (
    'PDF',
    'VIDEO',
    'WEB',
    'SYLLABUS',
    'OTHER'
);
CREATE TYPE resource_status_enum AS ENUM (
    'DRAFT',
    'PUBLISHED',
    'ARCHIVED',
    'UNDER_REVIEW'
);
CREATE TYPE resource_visibility_enum AS ENUM (
    'PUBLIC',
    'INSTITUTION',
    'DEPARTMENT',
    'PRIVATE'
);
CREATE TYPE ocr_status_enum AS ENUM (
    'PENDING',
    'PROCESSING',
    'COMPLETED',
    'FAILED',
    'SKIPPED'
);
CREATE TYPE video_provider_enum AS ENUM (
    'YOUTUBE',
    'VIMEO',
    'SELF_HOSTED',
    'GOOGLE_DRIVE',
    'OTHER'
);
CREATE TYPE tag_status_enum AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'ARCHIVED'
);