-- ============================================================
-- Module 4 - OCR & AI Knowledge
-- 01_enums.sql
-- ============================================================
CREATE TYPE ocr_document_status_enum AS ENUM (
    'PENDING',
    'PROCESSING',
    'COMPLETED',
    'FAILED',
    'PARTIAL'
);
CREATE TYPE chunk_type_enum AS ENUM (
    'PARAGRAPH',
    'HEADING',
    'LIST',
    'TABLE',
    'CODE',
    'EQUATION',
    'CAPTION',
    'OTHER'
);
CREATE TYPE embedding_model_enum AS ENUM (
    'TEXT_EMBEDDING_3_SMALL',
    'TEXT_EMBEDDING_3_LARGE',
    'BGE_LARGE',
    'BGE_M3',
    'CUSTOM'
);
CREATE TYPE citation_type_enum AS ENUM (
    'DIRECT_QUOTE',
    'PARAPHRASE',
    'SUMMARY',
    'REFERENCE'
);