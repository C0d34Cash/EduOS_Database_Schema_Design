-- ============================================================
-- Module 6 - Assessment
-- 01_enums.sql
-- ============================================================

CREATE TYPE question_type_enum AS ENUM (
    'MCQ_SINGLE',
    'MCQ_MULTIPLE',
    'TRUE_FALSE',
    'SHORT_ANSWER',
    'LONG_ANSWER',
    'NUMERICAL',
    'MATCHING',
    'FILL_BLANK'
);

CREATE TYPE question_status_enum AS ENUM (
    'DRAFT',
    'PUBLISHED',
    'ARCHIVED',
    'UNDER_REVIEW'
);

CREATE TYPE difficulty_level_enum AS ENUM (
    'EASY',
    'MEDIUM',
    'HARD',
    'VERY_HARD'
);

CREATE TYPE mock_test_status_enum AS ENUM (
    'DRAFT',
    'PUBLISHED',
    'ARCHIVED',
    'SCHEDULED'
);

CREATE TYPE attempt_status_enum AS ENUM (
    'IN_PROGRESS',
    'SUBMITTED',
    'EVALUATED',
    'ABANDONED',
    'EXPIRED'
);

CREATE TYPE evaluation_status_enum AS ENUM (
    'PENDING',
    'AUTO_EVALUATED',
    'MANUAL_EVALUATED',
    'RE_EVALUATED'
);
