-- ============================================================
-- Module 7 - Learning Progress
-- 01_enums.sql
-- ============================================================
CREATE TYPE progress_status_enum AS ENUM (
    'NOT_STARTED',
    'IN_PROGRESS',
    'COMPLETED',
    'MASTERED'
);
CREATE TYPE study_session_type_enum AS ENUM (
    'READING',
    'WATCHING',
    'PRACTICE',
    'REVISION',
    'AI_TUTOR',
    'QUIZ',
    'OTHER'
);
CREATE TYPE study_session_status_enum AS ENUM (
    'ACTIVE',
    'COMPLETED',
    'INTERRUPTED',
    'ABANDONED'
);