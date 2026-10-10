-- ============================================================
-- Module 9 - Analytics
-- 02_tables.sql
-- ============================================================
-- ========== 1. subject_mastery ==========
CREATE TABLE subject_mastery (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    user_id UUID NOT NULL,
    subject_id UUID NOT NULL,
    mastery_score NUMERIC(5, 2) NOT NULL DEFAULT 0.00,
    -- 0 to 100
    mastery_level mastery_level_enum NOT NULL DEFAULT 'NOVICE',
    total_time_seconds BIGINT NOT NULL DEFAULT 0,
    questions_attempted INTEGER NOT NULL DEFAULT 0,
    questions_correct INTEGER NOT NULL DEFAULT 0,
    accuracy_percent NUMERIC(5, 2) NULL,
    last_activity_at TIMESTAMPTZ NULL,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_subject_mastery UNIQUE (user_id, subject_id),
    CONSTRAINT chk_mastery_score CHECK (
        mastery_score >= 0
        AND mastery_score <= 100
    )
);
COMMENT ON TABLE subject_mastery IS 'Overall mastery level of a student in a subject';
-- ========== 2. weak_topics ==========
CREATE TABLE weak_topics (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    user_id UUID NOT NULL,
    subject_id UUID NOT NULL,
    unit_id UUID NULL,
    topic_id UUID NOT NULL,
    weakness_score NUMERIC(5, 2) NOT NULL DEFAULT 0.00,
    -- higher = weaker
    accuracy_percent NUMERIC(5, 2) NULL,
    attempts_count INTEGER NOT NULL DEFAULT 0,
    last_attempted_at TIMESTAMPTZ NULL,
    is_resolved BOOLEAN NOT NULL DEFAULT FALSE,
    resolved_at TIMESTAMPTZ NULL,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_weak_topics UNIQUE (user_id, topic_id)
);
COMMENT ON TABLE weak_topics IS 'Identifies topics where the student is weak';
-- ========== 3. study_metrics ==========
CREATE TABLE study_metrics (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    user_id UUID NOT NULL,
    metric_date DATE NOT NULL,
    study_seconds INTEGER NOT NULL DEFAULT 0,
    sessions_count INTEGER NOT NULL DEFAULT 0,
    questions_attempted INTEGER NOT NULL DEFAULT 0,
    questions_correct INTEGER NOT NULL DEFAULT 0,
    xp_earned INTEGER NOT NULL DEFAULT 0,
    resources_viewed INTEGER NOT NULL DEFAULT 0,
    ai_tutor_messages INTEGER NOT NULL DEFAULT 0,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_study_metrics UNIQUE (user_id, metric_date)
);
COMMENT ON TABLE study_metrics IS 'Daily aggregated study metrics for analytics';
-- ========== 4. flashcard_memory ==========
CREATE TABLE flashcard_memory (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    user_id UUID NOT NULL,
    flashcard_id UUID NOT NULL,
    -- will link to Module 10
    ease_factor NUMERIC(4, 2) NOT NULL DEFAULT 2.50,
    interval_days INTEGER NOT NULL DEFAULT 0,
    repetitions INTEGER NOT NULL DEFAULT 0,
    next_review_at TIMESTAMPTZ NULL,
    last_reviewed_at TIMESTAMPTZ NULL,
    quality SMALLINT NULL,
    -- 0-5 SM-2 quality
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_flashcard_memory UNIQUE (user_id, flashcard_id)
);
COMMENT ON TABLE flashcard_memory IS 'Spaced repetition memory state for flashcards (SM-2 algorithm)';
-- ========== 5. recommendations ==========
CREATE TABLE recommendations (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    user_id UUID NOT NULL,
    recommendation_type recommendation_type_enum NOT NULL,
    priority recommendation_priority_enum NOT NULL DEFAULT 'MEDIUM',
    status recommendation_status_enum NOT NULL DEFAULT 'PENDING',
    title VARCHAR(255) NOT NULL,
    description TEXT NULL,
    subject_id UUID NULL,
    unit_id UUID NULL,
    topic_id UUID NULL,
    resource_id UUID NULL,
    question_id UUID NULL,
    reason TEXT NULL,
    score NUMERIC(5, 4) NULL,
    -- confidence score
    expires_at TIMESTAMPTZ NULL,
    accepted_at TIMESTAMPTZ NULL,
    completed_at TIMESTAMPTZ NULL,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL
);
COMMENT ON TABLE recommendations IS 'AI-generated personalized recommendations for students';
-- ========== 6. performance_reports ==========
CREATE TABLE performance_reports (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    user_id UUID NOT NULL,
    report_type report_type_enum NOT NULL DEFAULT 'WEEKLY',
    title VARCHAR(255) NOT NULL,
    period_start DATE NOT NULL,
    period_end DATE NOT NULL,
    status report_status_enum NOT NULL DEFAULT 'GENERATING',
    summary TEXT NULL,
    strengths JSONB NOT NULL DEFAULT '[]',
    weaknesses JSONB NOT NULL DEFAULT '[]',
    recommendations JSONB NOT NULL DEFAULT '[]',
    metrics JSONB NOT NULL DEFAULT '{}',
    file_path TEXT NULL,
    -- generated PDF path
    generated_at TIMESTAMPTZ NULL,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL
);
COMMENT ON TABLE performance_reports IS 'Generated performance reports for students';