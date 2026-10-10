-- ============================================================
-- Module 7 - Learning Progress
-- 02_tables.sql
-- ============================================================
-- ========== 1. learning_progress ==========
CREATE TABLE learning_progress (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    user_id UUID NOT NULL,
    subject_id UUID NOT NULL,
    unit_id UUID NULL,
    topic_id UUID NULL,
    status progress_status_enum NOT NULL DEFAULT 'NOT_STARTED',
    progress_percent NUMERIC(5, 2) NOT NULL DEFAULT 0.00,
    -- 0.00 to 100.00
    time_spent_seconds INTEGER NOT NULL DEFAULT 0,
    last_accessed_at TIMESTAMPTZ NULL,
    completed_at TIMESTAMPTZ NULL,
    mastery_score NUMERIC(5, 2) NULL,
    -- 0.00 to 100.00
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_learning_progress UNIQUE (user_id, subject_id, unit_id, topic_id),
    CONSTRAINT chk_progress_percent CHECK (
        progress_percent >= 0
        AND progress_percent <= 100
    )
);
COMMENT ON TABLE learning_progress IS 'Overall learning progress of a student on subject/unit/topic';
-- ========== 2. completed_units ==========
CREATE TABLE completed_units (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    user_id UUID NOT NULL,
    subject_id UUID NOT NULL,
    unit_id UUID NOT NULL,
    completed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    time_spent_seconds INTEGER NOT NULL DEFAULT 0,
    score NUMERIC(5, 2) NULL,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_completed_units UNIQUE (user_id, unit_id)
);
COMMENT ON TABLE completed_units IS 'Tracks units marked as completed by students';
-- ========== 3. watch_history ==========
CREATE TABLE watch_history (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    user_id UUID NOT NULL,
    resource_id UUID NOT NULL,
    -- must be a video resource
    video_id UUID NULL,
    -- optional direct link to videos table
    watched_seconds INTEGER NOT NULL DEFAULT 0,
    total_duration INTEGER NULL,
    progress_percent NUMERIC(5, 2) NOT NULL DEFAULT 0.00,
    is_completed BOOLEAN NOT NULL DEFAULT FALSE,
    last_watched_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_watch_history UNIQUE (user_id, resource_id),
    CONSTRAINT chk_watch_progress CHECK (
        progress_percent >= 0
        AND progress_percent <= 100
    )
);
COMMENT ON TABLE watch_history IS 'Tracks video watching progress of users';
-- ========== 4. reading_history ==========
CREATE TABLE reading_history (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    user_id UUID NOT NULL,
    resource_id UUID NOT NULL,
    -- usually PDF
    pdf_document_id UUID NULL,
    last_page INTEGER NULL,
    total_pages INTEGER NULL,
    progress_percent NUMERIC(5, 2) NOT NULL DEFAULT 0.00,
    time_spent_seconds INTEGER NOT NULL DEFAULT 0,
    is_completed BOOLEAN NOT NULL DEFAULT FALSE,
    last_read_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_reading_history UNIQUE (user_id, resource_id),
    CONSTRAINT chk_reading_progress CHECK (
        progress_percent >= 0
        AND progress_percent <= 100
    )
);
COMMENT ON TABLE reading_history IS 'Tracks PDF / document reading progress';
-- ========== 5. study_sessions ==========
CREATE TABLE study_sessions (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    user_id UUID NOT NULL,
    subject_id UUID NULL,
    unit_id UUID NULL,
    topic_id UUID NULL,
    resource_id UUID NULL,
    session_type study_session_type_enum NOT NULL DEFAULT 'OTHER',
    status study_session_status_enum NOT NULL DEFAULT 'ACTIVE',
    started_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ended_at TIMESTAMPTZ NULL,
    duration_seconds INTEGER NULL,
    focus_score NUMERIC(5, 2) NULL,
    -- optional AI-calculated
    activity_data JSONB NOT NULL DEFAULT '{}',
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL
);
COMMENT ON TABLE study_sessions IS 'Records individual study sessions of students';