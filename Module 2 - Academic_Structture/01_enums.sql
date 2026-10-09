-- ============================================================
-- Module 2 - Academic Structure
-- 01_enums.sql
-- ============================================================
CREATE TYPE department_status_enum AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'ARCHIVED'
);
CREATE TYPE degree_type_enum AS ENUM (
    'UNDERGRADUATE',
    'POSTGRADUATE',
    'DIPLOMA',
    'DOCTORATE',
    'CERTIFICATE'
);
CREATE TYPE program_status_enum AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'DISCONTINUED'
);
CREATE TYPE academic_year_status_enum AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'ARCHIVED'
);
CREATE TYPE semester_status_enum AS ENUM (
    'UPCOMING',
    'ACTIVE',
    'COMPLETED',
    'CANCELLED'
);
CREATE TYPE subject_type_enum AS ENUM (
    'CORE',
    'ELECTIVE',
    'LAB',
    'PROJECT',
    'SEMINAR',
    'INTERNSHIP'
);
CREATE TYPE subject_status_enum AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'ARCHIVED'
);
CREATE TYPE unit_status_enum AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'ARCHIVED'
);
CREATE TYPE topic_difficulty_enum AS ENUM ('EASY', 'MEDIUM', 'HARD');
CREATE TYPE topic_status_enum AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'ARCHIVED'
);