-- ============================================================
-- Module 9 - Analytics
-- 01_enums.sql
-- ============================================================
CREATE TYPE mastery_level_enum AS ENUM (
    'NOVICE',
    'BEGINNER',
    'INTERMEDIATE',
    'ADVANCED',
    'MASTER'
);
CREATE TYPE recommendation_type_enum AS ENUM (
    'TOPIC_REVISION',
    'PRACTICE_QUIZ',
    'WATCH_VIDEO',
    'READ_RESOURCE',
    'AI_TUTOR',
    'FLASHCARDS',
    'CUSTOM'
);
CREATE TYPE recommendation_priority_enum AS ENUM (
    'LOW',
    'MEDIUM',
    'HIGH',
    'CRITICAL'
);
CREATE TYPE recommendation_status_enum AS ENUM (
    'PENDING',
    'VIEWED',
    'ACCEPTED',
    'DISMISSED',
    'COMPLETED'
);
CREATE TYPE report_type_enum AS ENUM (
    'DAILY',
    'WEEKLY',
    'MONTHLY',
    'SEMESTER',
    'CUSTOM'
);
CREATE TYPE report_status_enum AS ENUM (
    'GENERATING',
    'READY',
    'FAILED',
    'ARCHIVED'
);