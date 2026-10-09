-- ============================================================
-- Module 5 - AI Tutor
-- 01_enums.sql
-- ============================================================
CREATE TYPE ai_model_provider_enum AS ENUM (
    'OPENAI',
    'ANTHROPIC',
    'GOOGLE',
    'GROQ',
    'MISTRAL',
    'LOCAL',
    'CUSTOM'
);
CREATE TYPE ai_model_status_enum AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'DEPRECATED'
);
CREATE TYPE prompt_template_type_enum AS ENUM (
    'SYSTEM',
    'USER',
    'TUTOR',
    'SUMMARY',
    'QUIZ_GENERATION',
    'EXPLANATION',
    'CUSTOM'
);
CREATE TYPE chat_session_status_enum AS ENUM (
    'ACTIVE',
    'ARCHIVED',
    'DELETED'
);
CREATE TYPE message_role_enum AS ENUM (
    'SYSTEM',
    'USER',
    'ASSISTANT',
    'TOOL'
);
CREATE TYPE message_status_enum AS ENUM (
    'PENDING',
    'STREAMING',
    'COMPLETED',
    'FAILED',
    'CANCELLED'
);