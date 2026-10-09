-- ============================================================
-- Module 2 - Academic Structure
-- 02_tables.sql
-- ============================================================
-- ========== 1. departments ==========
CREATE TABLE departments (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    code VARCHAR(20) NOT NULL,
    slug VARCHAR(100) NOT NULL,
    name VARCHAR(150) NOT NULL,
    short_name VARCHAR(50) NULL,
    description TEXT NULL,
    icon VARCHAR(50) NULL,
    color VARCHAR(20) NULL,
    head_user_id UUID NULL,
    status department_status_enum NOT NULL DEFAULT 'ACTIVE',
    sort_order SMALLINT NOT NULL DEFAULT 0,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_departments_code_institution UNIQUE (institution_id, code),
    CONSTRAINT uq_departments_slug_institution UNIQUE (institution_id, slug)
);
COMMENT ON TABLE departments IS 'Academic departments / branches (CSE, ECE, ME, etc.)';
-- ========== 2. programs ==========
CREATE TABLE programs (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    department_id UUID NOT NULL,
    code VARCHAR(30) NOT NULL,
    slug VARCHAR(120) NOT NULL,
    name VARCHAR(200) NOT NULL,
    degree_type degree_type_enum NOT NULL DEFAULT 'UNDERGRADUATE',
    duration_years SMALLINT NOT NULL DEFAULT 4,
    total_semesters SMALLINT NOT NULL DEFAULT 8,
    status program_status_enum NOT NULL DEFAULT 'ACTIVE',
    is_lateral_entry_allowed BOOLEAN NOT NULL DEFAULT TRUE,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_programs_code_institution UNIQUE (institution_id, code),
    CONSTRAINT uq_programs_slug_institution UNIQUE (institution_id, slug)
);
COMMENT ON TABLE programs IS 'Degree programs (B.Tech, M.Tech, BCA, etc.)';
-- ========== 3. academic_years ==========
CREATE TABLE academic_years (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    code VARCHAR(30) NOT NULL,
    name VARCHAR(100) NOT NULL,
    start_year SMALLINT NOT NULL,
    end_year SMALLINT NOT NULL,
    is_current BOOLEAN NOT NULL DEFAULT FALSE,
    status academic_year_status_enum NOT NULL DEFAULT 'ACTIVE',
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_academic_years_code_institution UNIQUE (institution_id, code),
    CONSTRAINT chk_academic_years_years CHECK (end_year > start_year)
);
COMMENT ON TABLE academic_years IS 'Academic year / batch definition (2023-27, 2024-28, etc.)';
-- ========== 4. semesters ==========
CREATE TABLE semesters (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    academic_year_id UUID NOT NULL,
    program_id UUID NULL,
    number SMALLINT NOT NULL,
    code VARCHAR(20) NOT NULL,
    name VARCHAR(100) NOT NULL,
    start_date DATE NULL,
    end_date DATE NULL,
    is_current BOOLEAN NOT NULL DEFAULT FALSE,
    status semester_status_enum NOT NULL DEFAULT 'UPCOMING',
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_semesters_number UNIQUE (
        institution_id,
        academic_year_id,
        program_id,
        number
    ),
    CONSTRAINT chk_semesters_dates CHECK (
        end_date IS NULL
        OR start_date IS NULL
        OR end_date >= start_date
    )
);
COMMENT ON TABLE semesters IS 'Semester definition within an academic year / program';
-- ========== 5. subjects ==========
CREATE TABLE subjects (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    department_id UUID NOT NULL,
    program_id UUID NULL,
    semester_id UUID NULL,
    code VARCHAR(30) NOT NULL,
    slug VARCHAR(120) NOT NULL,
    name VARCHAR(200) NOT NULL,
    short_name VARCHAR(80) NULL,
    credit_hours NUMERIC(4, 1) NOT NULL DEFAULT 3.0,
    theory_hours SMALLINT NULL,
    practical_hours SMALLINT NULL,
    subject_type subject_type_enum NOT NULL DEFAULT 'CORE',
    status subject_status_enum NOT NULL DEFAULT 'ACTIVE',
    description TEXT NULL,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_subjects_code_institution UNIQUE (institution_id, code),
    CONSTRAINT uq_subjects_slug_institution UNIQUE (institution_id, slug)
);
COMMENT ON TABLE subjects IS 'Individual subjects / courses';
-- ========== 6. units ==========
CREATE TABLE units (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    subject_id UUID NOT NULL,
    number SMALLINT NOT NULL,
    code VARCHAR(30) NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT NULL,
    estimated_hours NUMERIC(5, 1) NULL,
    sort_order SMALLINT NOT NULL DEFAULT 0,
    status unit_status_enum NOT NULL DEFAULT 'ACTIVE',
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_units_number_subject UNIQUE (subject_id, number)
);
COMMENT ON TABLE units IS 'Units / modules inside a subject';
-- ========== 7. syllabus_topics ==========
CREATE TABLE syllabus_topics (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    unit_id UUID NOT NULL,
    subject_id UUID NOT NULL,
    -- denormalized for performance
    number SMALLINT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NULL,
    learning_outcomes TEXT [] NULL,
    difficulty topic_difficulty_enum NOT NULL DEFAULT 'MEDIUM',
    estimated_minutes SMALLINT NULL,
    sort_order SMALLINT NOT NULL DEFAULT 0,
    status topic_status_enum NOT NULL DEFAULT 'ACTIVE',
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_syllabus_topics_number UNIQUE (unit_id, number)
);
COMMENT ON TABLE syllabus_topics IS 'Fine-grained topics inside a unit (used by AI Tutor, Progress, Assessment)';