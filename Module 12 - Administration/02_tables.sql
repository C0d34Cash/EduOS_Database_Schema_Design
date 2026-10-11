-- ============================================================
-- Module 12 - Administration
-- 02_tables.sql
-- ============================================================
-- ========== 1. audit_logs ==========
CREATE TABLE audit_logs (
    id UUID PRIMARY KEY,
    institution_id UUID NULL,
    user_id UUID NULL,
    action audit_action_enum NOT NULL,
    entity_type VARCHAR(100) NOT NULL,
    -- e.g. 'users', 'subjects'
    entity_id UUID NULL,
    old_values JSONB NULL,
    new_values JSONB NULL,
    ip_address INET NULL,
    user_agent TEXT NULL,
    request_id UUID NULL,
    metadata JSONB NOT NULL DEFAULT '{}',
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (created_at);
COMMENT ON TABLE audit_logs IS 'Immutable audit trail of important system actions';
-- Example partitions (extend as needed)
CREATE TABLE audit_logs_2026_10 PARTITION OF audit_logs FOR
VALUES
FROM ('2026-10-01') TO ('2026-11-01');
CREATE TABLE audit_logs_2026_11 PARTITION OF audit_logs FOR
VALUES
FROM ('2026-11-01') TO ('2026-12-01');
-- ========== 2. ocr_queue ==========
CREATE TABLE ocr_queue (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    resource_id UUID NOT NULL,
    pdf_document_id UUID NULL,
    status ocr_queue_status_enum NOT NULL DEFAULT 'QUEUED',
    priority SMALLINT NOT NULL DEFAULT 5,
    -- 1 = highest
    attempts SMALLINT NOT NULL DEFAULT 0,
    max_attempts SMALLINT NOT NULL DEFAULT 3,
    error_message TEXT NULL,
    started_at TIMESTAMPTZ NULL,
    completed_at TIMESTAMPTZ NULL,
    worker_id VARCHAR(100) NULL,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL
);
COMMENT ON TABLE ocr_queue IS 'Queue for OCR processing jobs';
-- ========== 3. system_metrics ==========
CREATE TABLE system_metrics (
    id UUID PRIMARY KEY,
    institution_id UUID NULL,
    -- NULL = global
    metric_name VARCHAR(100) NOT NULL,
    metric_value NUMERIC(18, 4) NOT NULL,
    metric_unit VARCHAR(30) NULL,
    tags JSONB NOT NULL DEFAULT '{}',
    recorded_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);
COMMENT ON TABLE system_metrics IS 'Time-series system and application metrics';
-- ========== 4. feature_flags ==========
CREATE TABLE feature_flags (
    id UUID PRIMARY KEY,
    institution_id UUID NULL,
    -- NULL = global flag
    code VARCHAR(100) NOT NULL,
    name VARCHAR(150) NOT NULL,
    description TEXT NULL,
    status feature_flag_status_enum NOT NULL DEFAULT 'DISABLED',
    is_permanent BOOLEAN NOT NULL DEFAULT FALSE,
    rollout_percentage SMALLINT NOT NULL DEFAULT 0,
    -- 0-100
    allowed_user_ids UUID [] NULL,
    allowed_roles TEXT [] NULL,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_feature_flags_code UNIQUE (code),
    CONSTRAINT chk_rollout CHECK (
        rollout_percentage >= 0
        AND rollout_percentage <= 100
    )
);
COMMENT ON TABLE feature_flags IS 'Feature toggles for gradual rollouts and experiments';
-- ========== 5. configurations ==========
CREATE TABLE configurations (
    id UUID PRIMARY KEY,
    institution_id UUID NULL,
    -- NULL = global config
    key VARCHAR(150) NOT NULL,
    value TEXT NOT NULL,
    data_type config_data_type_enum NOT NULL DEFAULT 'STRING',
    description TEXT NULL,
    is_sensitive BOOLEAN NOT NULL DEFAULT FALSE,
    is_readonly BOOLEAN NOT NULL DEFAULT FALSE,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_configurations_key UNIQUE (institution_id, key)
);
COMMENT ON TABLE configurations IS 'System and institution-level configuration key-value store';