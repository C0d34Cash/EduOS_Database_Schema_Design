-- ============================================================
-- Module 10 - AI Study Planner
-- 02_tables.sql
-- ============================================================
-- ========== 1. ai_notes ==========
CREATE TABLE ai_notes (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    user_id UUID NOT NULL,
    subject_id UUID NULL,
    unit_id UUID NULL,
    topic_id UUID NULL,
    resource_id UUID NULL,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    summary TEXT NULL,
    source note_source_enum NOT NULL DEFAULT 'MANUAL',
    status note_status_enum NOT NULL DEFAULT 'ACTIVE',
    is_favorite BOOLEAN NOT NULL DEFAULT FALSE,
    tags TEXT [] NULL,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL
);
COMMENT ON TABLE ai_notes IS 'AI-generated or manual study notes';
-- ========== 2. flashcard_decks ==========
CREATE TABLE flashcard_decks (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    user_id UUID NOT NULL,
    -- owner
    subject_id UUID NULL,
    unit_id UUID NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NULL,
    visibility deck_visibility_enum NOT NULL DEFAULT 'PRIVATE',
    card_count INTEGER NOT NULL DEFAULT 0,
    is_ai_generated BOOLEAN NOT NULL DEFAULT FALSE,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL
);
COMMENT ON TABLE flashcard_decks IS 'Collections of flashcards';
-- ========== 3. flashcards ==========
CREATE TABLE flashcards (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    deck_id UUID NOT NULL,
    user_id UUID NOT NULL,
    front TEXT NOT NULL,
    back TEXT NOT NULL,
    hint TEXT NULL,
    explanation TEXT NULL,
    subject_id UUID NULL,
    unit_id UUID NULL,
    topic_id UUID NULL,
    status flashcard_status_enum NOT NULL DEFAULT 'ACTIVE',
    position INTEGER NOT NULL DEFAULT 0,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL
);
COMMENT ON TABLE flashcards IS 'Individual flashcards inside a deck';
-- ========== 4. planner_schedules ==========
CREATE TABLE planner_schedules (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    user_id UUID NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status schedule_status_enum NOT NULL DEFAULT 'DRAFT',
    is_ai_generated BOOLEAN NOT NULL DEFAULT FALSE,
    goal TEXT NULL,
    -- e.g. "Complete Unit 3"
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT chk_planner_dates CHECK (end_date >= start_date)
);
COMMENT ON TABLE planner_schedules IS 'AI or manual study plans / schedules';
-- ========== 5. planner_tasks ==========
CREATE TABLE planner_tasks (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    schedule_id UUID NOT NULL,
    user_id UUID NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NULL,
    task_type task_type_enum NOT NULL DEFAULT 'CUSTOM',
    priority task_priority_enum NOT NULL DEFAULT 'MEDIUM',
    status task_status_enum NOT NULL DEFAULT 'PENDING',
    subject_id UUID NULL,
    unit_id UUID NULL,
    topic_id UUID NULL,
    resource_id UUID NULL,
    due_date DATE NULL,
    due_time TIME NULL,
    estimated_minutes INTEGER NULL,
    completed_at TIMESTAMPTZ NULL,
    sort_order INTEGER NOT NULL DEFAULT 0,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL
);
COMMENT ON TABLE planner_tasks IS 'Individual tasks inside a study plan';