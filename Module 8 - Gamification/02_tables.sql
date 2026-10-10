-- ============================================================
-- Module 8 - Gamification
-- 02_tables.sql
-- ============================================================
-- ========== 1. user_progression ==========
CREATE TABLE user_progression (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    user_id UUID NOT NULL,
    total_xp BIGINT NOT NULL DEFAULT 0,
    current_level INTEGER NOT NULL DEFAULT 1,
    current_xp INTEGER NOT NULL DEFAULT 0,
    -- XP in current level
    xp_to_next_level INTEGER NOT NULL DEFAULT 100,
    total_study_seconds BIGINT NOT NULL DEFAULT 0,
    total_questions_attempted INTEGER NOT NULL DEFAULT 0,
    total_correct_answers INTEGER NOT NULL DEFAULT 0,
    current_streak_days INTEGER NOT NULL DEFAULT 0,
    longest_streak_days INTEGER NOT NULL DEFAULT 0,
    last_activity_at TIMESTAMPTZ NULL,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_user_progression_user UNIQUE (user_id)
);
COMMENT ON TABLE user_progression IS 'Overall XP, level and progression of a user';
-- ========== 2. study_streaks ==========
CREATE TABLE study_streaks (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    user_id UUID NOT NULL,
    current_streak INTEGER NOT NULL DEFAULT 0,
    longest_streak INTEGER NOT NULL DEFAULT 0,
    last_study_date DATE NULL,
    streak_start_date DATE NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_study_streaks_user UNIQUE (user_id)
);
COMMENT ON TABLE study_streaks IS 'Tracks daily study streaks of users';
-- ========== 3. achievements ==========
CREATE TABLE achievements (
    id UUID PRIMARY KEY,
    institution_id UUID NULL,
    -- NULL = global
    code VARCHAR(100) NOT NULL,
    name VARCHAR(150) NOT NULL,
    description TEXT NULL,
    category achievement_category_enum NOT NULL DEFAULT 'STUDY',
    rarity achievement_rarity_enum NOT NULL DEFAULT 'COMMON',
    xp_reward INTEGER NOT NULL DEFAULT 0,
    icon VARCHAR(100) NULL,
    badge_id UUID NULL,
    -- optional linked badge
    criteria JSONB NOT NULL DEFAULT '{}',
    -- conditions to unlock
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    is_hidden BOOLEAN NOT NULL DEFAULT FALSE,
    sort_order INTEGER NOT NULL DEFAULT 0,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_achievements_code UNIQUE (code)
);
COMMENT ON TABLE achievements IS 'Definition of all achievable achievements';
-- ========== 4. user_achievements ==========
CREATE TABLE user_achievements (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    user_id UUID NOT NULL,
    achievement_id UUID NOT NULL,
    unlocked_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    progress_percent NUMERIC(5, 2) NOT NULL DEFAULT 100.00,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_user_achievements UNIQUE (user_id, achievement_id)
);
COMMENT ON TABLE user_achievements IS 'Achievements unlocked by users';
-- ========== 5. badges ==========
CREATE TABLE badges (
    id UUID PRIMARY KEY,
    institution_id UUID NULL,
    -- NULL = global
    code VARCHAR(100) NOT NULL,
    name VARCHAR(150) NOT NULL,
    description TEXT NULL,
    badge_type badge_type_enum NOT NULL DEFAULT 'BRONZE',
    icon VARCHAR(100) NULL,
    color VARCHAR(20) NULL,
    xp_reward INTEGER NOT NULL DEFAULT 0,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_badges_code UNIQUE (code)
);
COMMENT ON TABLE badges IS 'Badge definitions';
-- ========== 6. unit_stars ==========
CREATE TABLE unit_stars (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    user_id UUID NOT NULL,
    subject_id UUID NOT NULL,
    unit_id UUID NOT NULL,
    stars SMALLINT NOT NULL DEFAULT 0,
    -- 0 to 3 (or 5)
    earned_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_unit_stars UNIQUE (user_id, unit_id),
    CONSTRAINT chk_unit_stars CHECK (
        stars >= 0
        AND stars <= 5
    )
);
COMMENT ON TABLE unit_stars IS 'Stars earned by students on completing units';
-- ========== 7. leaderboards ==========
CREATE TABLE leaderboards (
    id UUID PRIMARY KEY,
    institution_id UUID NULL,
    department_id UUID NULL,
    subject_id UUID NULL,
    name VARCHAR(150) NOT NULL,
    leaderboard_type leaderboard_type_enum NOT NULL DEFAULT 'INSTITUTION',
    period leaderboard_period_enum NOT NULL DEFAULT 'WEEKLY',
    start_date DATE NULL,
    end_date DATE NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL
);
COMMENT ON TABLE leaderboards IS 'Leaderboard configurations';
-- Optional: leaderboard_entries (recommended for performance)
CREATE TABLE leaderboard_entries (
    id UUID PRIMARY KEY,
    leaderboard_id UUID NOT NULL,
    institution_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rank INTEGER NOT NULL,
    score BIGINT NOT NULL DEFAULT 0,
    xp BIGINT NOT NULL DEFAULT 0,
    metadata JSONB NOT NULL DEFAULT '{}',
    calculated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_leaderboard_entries UNIQUE (leaderboard_id, user_id)
);
COMMENT ON TABLE leaderboard_entries IS 'Cached ranking entries for leaderboards';