-- ============================================================
-- Module 10 - AI Study Planner
-- 01_enums.sql
-- ============================================================
CREATE TYPE note_source_enum AS ENUM (
    'MANUAL',
    'AI_GENERATED',
    'OCR',
    'CHAT',
    'IMPORTED'
);
CREATE TYPE note_status_enum AS ENUM (
    'ACTIVE',
    'ARCHIVED',
    'DELETED'
);
CREATE TYPE deck_visibility_enum AS ENUM (
    'PRIVATE',
    'INSTITUTION',
    'PUBLIC'
);
CREATE TYPE flashcard_status_enum AS ENUM (
    'ACTIVE',
    'SUSPENDED',
    'ARCHIVED'
);
CREATE TYPE schedule_status_enum AS ENUM (
    'DRAFT',
    'ACTIVE',
    'COMPLETED',
    'CANCELLED'
);
CREATE TYPE task_type_enum AS ENUM (
    'STUDY_TOPIC',
    'REVISE_UNIT',
    'PRACTICE_QUIZ',
    'WATCH_VIDEO',
    'READ_PDF',
    'FLASHCARDS',
    'AI_TUTOR',
    'CUSTOM'
);
CREATE TYPE task_priority_enum AS ENUM (
    'LOW',
    'MEDIUM',
    'HIGH',
    'URGENT'
);
CREATE TYPE task_status_enum AS ENUM (
    'PENDING',
    'IN_PROGRESS',
    'COMPLETED',
    'SKIPPED',
    'CANCELLED'
);