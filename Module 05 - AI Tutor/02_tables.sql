-- ============================================================
-- Module 5 - AI Tutor
-- 02_tables.sql
-- ============================================================
-- ========== 1. ai_models ==========
CREATE TABLE ai_models (
    id UUID PRIMARY KEY,
    institution_id UUID NULL,
    -- NULL = global model
    provider ai_model_provider_enum NOT NULL,
    model_name VARCHAR(100) NOT NULL,
    -- e.g. gpt-4o, claude-3-5-sonnet
    display_name VARCHAR(150) NOT NULL,
    context_window INTEGER NOT NULL,
    -- max tokens
    max_output_tokens INTEGER NULL,
    supports_vision BOOLEAN NOT NULL DEFAULT FALSE,
    supports_tools BOOLEAN NOT NULL DEFAULT FALSE,
    input_cost_per_1m NUMERIC(10, 4) NULL,
    -- USD
    output_cost_per_1m NUMERIC(10, 4) NULL,
    status ai_model_status_enum NOT NULL DEFAULT 'ACTIVE',
    is_default BOOLEAN NOT NULL DEFAULT FALSE,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_ai_models_provider_name UNIQUE (provider, model_name)
);
COMMENT ON TABLE ai_models IS 'Registry of available AI models';
-- ========== 2. prompt_templates ==========
CREATE TABLE prompt_templates (
    id UUID PRIMARY KEY,
    institution_id UUID NULL,
    -- NULL = system-wide
    code VARCHAR(100) NOT NULL,
    name VARCHAR(150) NOT NULL,
    description TEXT NULL,
    template_type prompt_template_type_enum NOT NULL DEFAULT 'TUTOR',
    system_prompt TEXT NULL,
    user_prompt_template TEXT NULL,
    variables JSONB NOT NULL DEFAULT '[]',
    -- list of expected variables
    model_id UUID NULL,
    -- preferred model
    temperature NUMERIC(3, 2) NULL DEFAULT 0.7,
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_prompt_templates_code UNIQUE (code)
);
COMMENT ON TABLE prompt_templates IS 'Reusable prompt templates for AI Tutor';
-- ========== 3. chat_sessions ==========
CREATE TABLE chat_sessions (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    user_id UUID NOT NULL,
    subject_id UUID NULL,
    unit_id UUID NULL,
    topic_id UUID NULL,
    resource_id UUID NULL,
    title VARCHAR(255) NULL,
    status chat_session_status_enum NOT NULL DEFAULT 'ACTIVE',
    model_id UUID NULL,
    prompt_template_id UUID NULL,
    total_messages INTEGER NOT NULL DEFAULT 0,
    total_tokens INTEGER NOT NULL DEFAULT 0,
    last_message_at TIMESTAMPTZ NULL,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL
);
COMMENT ON TABLE chat_sessions IS 'AI Tutor conversation sessions';
-- ========== 4. chat_messages ==========
CREATE TABLE chat_messages (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    session_id UUID NOT NULL,
    user_id UUID NULL,
    -- NULL for assistant messages
    role message_role_enum NOT NULL,
    content TEXT NOT NULL,
    status message_status_enum NOT NULL DEFAULT 'COMPLETED',
    model_id UUID NULL,
    prompt_tokens INTEGER NULL,
    completion_tokens INTEGER NULL,
    total_tokens INTEGER NULL,
    finish_reason VARCHAR(50) NULL,
    tool_calls JSONB NULL,
    citations JSONB NULL,
    -- array of citation references
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL
);
COMMENT ON TABLE chat_messages IS 'Individual messages inside a chat session';
-- ========== 5. token_usage ==========
CREATE TABLE token_usage (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    user_id UUID NOT NULL,
    session_id UUID NULL,
    message_id UUID NULL,
    model_id UUID NOT NULL,
    prompt_tokens INTEGER NOT NULL DEFAULT 0,
    completion_tokens INTEGER NOT NULL DEFAULT 0,
    total_tokens INTEGER NOT NULL DEFAULT 0,
    cost_usd NUMERIC(12, 6) NULL,
    request_type VARCHAR(50) NULL,
    -- chat, embedding, etc.
    metadata JSONB NOT NULL DEFAULT '{}',
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);
COMMENT ON TABLE token_usage IS 'Tracks token consumption and cost for billing & analytics';