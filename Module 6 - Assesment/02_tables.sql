-- ============================================================
-- Module 6 - Assessment
-- 02_tables.sql
-- ============================================================
-- ========== 1. question_difficulty (Lookup) ==========
CREATE TABLE question_difficulty (
    id UUID PRIMARY KEY,
    code VARCHAR(30) NOT NULL UNIQUE,
    name VARCHAR(50) NOT NULL,
    level difficulty_level_enum NOT NULL,
    weight NUMERIC(4, 2) NOT NULL DEFAULT 1.0,
    color VARCHAR(20) NULL,
    metadata JSONB NOT NULL DEFAULT '{}',
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);
COMMENT ON TABLE question_difficulty IS 'Difficulty levels lookup table';
-- ========== 2. question_bank ==========
CREATE TABLE question_bank (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    subject_id UUID NULL,
    unit_id UUID NULL,
    topic_id UUID NULL,
    question_type question_type_enum NOT NULL,
    difficulty_id UUID NULL,
    difficulty_level difficulty_level_enum NOT NULL DEFAULT 'MEDIUM',
    question_text TEXT NOT NULL,
    explanation TEXT NULL,
    marks NUMERIC(5, 2) NOT NULL DEFAULT 1.0,
    negative_marks NUMERIC(5, 2) NOT NULL DEFAULT 0.0,
    estimated_time_sec INTEGER NULL,
    status question_status_enum NOT NULL DEFAULT 'DRAFT',
    is_pyq BOOLEAN NOT NULL DEFAULT FALSE,
    is_ai_generated BOOLEAN NOT NULL DEFAULT FALSE,
    source VARCHAR(150) NULL,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL
);
COMMENT ON TABLE question_bank IS 'Central repository of all questions';
-- ========== 3. question_options ==========
CREATE TABLE question_options (
    id UUID PRIMARY KEY,
    question_id UUID NOT NULL,
    institution_id UUID NOT NULL,
    option_text TEXT NOT NULL,
    is_correct BOOLEAN NOT NULL DEFAULT FALSE,
    sort_order SMALLINT NOT NULL DEFAULT 0,
    explanation TEXT NULL,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL
);
COMMENT ON TABLE question_options IS 'Options for MCQ / True-False questions';
-- ========== 4. question_tags ==========
CREATE TABLE question_tags (
    id UUID PRIMARY KEY,
    question_id UUID NOT NULL,
    tag_id UUID NOT NULL,
    institution_id UUID NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_question_tags UNIQUE (question_id, tag_id)
);
COMMENT ON TABLE question_tags IS 'Many-to-many tags for questions';
-- ========== 5. pyqs ==========
CREATE TABLE pyqs (
    id UUID PRIMARY KEY,
    question_id UUID NOT NULL,
    institution_id UUID NOT NULL,
    exam_name VARCHAR(150) NOT NULL,
    -- e.g. GATE, University Final
    exam_year SMALLINT NOT NULL,
    exam_session VARCHAR(50) NULL,
    -- e.g. "Set A", "Morning"
    paper_code VARCHAR(50) NULL,
    question_number VARCHAR(20) NULL,
    marks NUMERIC(5, 2) NULL,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_pyqs_question UNIQUE (question_id)
);
COMMENT ON TABLE pyqs IS 'Previous Year Questions metadata';
-- ========== 6. mock_tests ==========
CREATE TABLE mock_tests (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    subject_id UUID NULL,
    title VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL,
    description TEXT NULL,
    instructions TEXT NULL,
    total_questions INTEGER NOT NULL DEFAULT 0,
    total_marks NUMERIC(8, 2) NOT NULL DEFAULT 0,
    duration_minutes INTEGER NOT NULL,
    passing_marks NUMERIC(8, 2) NULL,
    status mock_test_status_enum NOT NULL DEFAULT 'DRAFT',
    is_public BOOLEAN NOT NULL DEFAULT FALSE,
    start_time TIMESTAMPTZ NULL,
    end_time TIMESTAMPTZ NULL,
    max_attempts INTEGER NOT NULL DEFAULT 1,
    shuffle_questions BOOLEAN NOT NULL DEFAULT TRUE,
    shuffle_options BOOLEAN NOT NULL DEFAULT TRUE,
    show_results_immediately BOOLEAN NOT NULL DEFAULT TRUE,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_mock_tests_slug UNIQUE (institution_id, slug)
);
COMMENT ON TABLE mock_tests IS 'Mock tests / quizzes configuration';
-- ========== 7. mock_test_questions ==========
CREATE TABLE mock_test_questions (
    id UUID PRIMARY KEY,
    mock_test_id UUID NOT NULL,
    question_id UUID NOT NULL,
    institution_id UUID NOT NULL,
    sort_order INTEGER NOT NULL DEFAULT 0,
    marks NUMERIC(5, 2) NULL,
    -- override question marks
    negative_marks NUMERIC(5, 2) NULL,
    metadata JSONB NOT NULL DEFAULT '{}',
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_mock_test_questions UNIQUE (mock_test_id, question_id)
);
COMMENT ON TABLE mock_test_questions IS 'Questions assigned to a mock test';
-- ========== 8. quiz_attempts ==========
CREATE TABLE quiz_attempts (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    mock_test_id UUID NOT NULL,
    user_id UUID NOT NULL,
    attempt_number INTEGER NOT NULL DEFAULT 1,
    status attempt_status_enum NOT NULL DEFAULT 'IN_PROGRESS',
    started_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    submitted_at TIMESTAMPTZ NULL,
    time_taken_seconds INTEGER NULL,
    total_marks NUMERIC(8, 2) NULL,
    obtained_marks NUMERIC(8, 2) NULL,
    percentage NUMERIC(5, 2) NULL,
    correct_count INTEGER NULL,
    incorrect_count INTEGER NULL,
    skipped_count INTEGER NULL,
    evaluation_status evaluation_status_enum NOT NULL DEFAULT 'PENDING',
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL
);
COMMENT ON TABLE quiz_attempts IS 'User attempts of mock tests / quizzes';
-- ========== 9. submission_answers ==========
CREATE TABLE submission_answers (
    id UUID PRIMARY KEY,
    attempt_id UUID NOT NULL,
    question_id UUID NOT NULL,
    institution_id UUID NOT NULL,
    selected_option_ids UUID [] NULL,
    -- for MCQs
    answer_text TEXT NULL,
    -- for subjective
    is_correct BOOLEAN NULL,
    marks_obtained NUMERIC(5, 2) NULL,
    time_spent_seconds INTEGER NULL,
    evaluation_status evaluation_status_enum NOT NULL DEFAULT 'PENDING',
    evaluator_id UUID NULL,
    feedback TEXT NULL,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_submission_answers UNIQUE (attempt_id, question_id)
);
COMMENT ON TABLE submission_answers IS 'Individual answers submitted in a quiz attempt';