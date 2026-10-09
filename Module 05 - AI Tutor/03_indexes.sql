-- ============================================================
-- Module 5 - AI Tutor
-- 03_indexes.sql
-- ============================================================
-- ai_models
CREATE INDEX idx_ai_models_provider ON ai_models (provider)
WHERE deleted_at IS NULL;
CREATE INDEX idx_ai_models_status ON ai_models (status)
WHERE deleted_at IS NULL;
CREATE INDEX idx_ai_models_is_default ON ai_models (is_default)
WHERE is_default = TRUE;
-- prompt_templates
CREATE INDEX idx_prompt_templates_type ON prompt_templates (template_type)
WHERE deleted_at IS NULL;
CREATE INDEX idx_prompt_templates_institution ON prompt_templates (institution_id)
WHERE deleted_at IS NULL;
-- chat_sessions
CREATE INDEX idx_chat_sessions_institution_id ON chat_sessions (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_chat_sessions_user_id ON chat_sessions (user_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_chat_sessions_subject_id ON chat_sessions (subject_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_chat_sessions_status ON chat_sessions (status)
WHERE deleted_at IS NULL;
CREATE INDEX idx_chat_sessions_last_message ON chat_sessions (last_message_at DESC);
-- chat_messages
CREATE INDEX idx_chat_messages_session_id ON chat_messages (session_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_chat_messages_user_id ON chat_messages (user_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_chat_messages_role ON chat_messages (role);
CREATE INDEX idx_chat_messages_created_at ON chat_messages (session_id, created_at);
-- token_usage
CREATE INDEX idx_token_usage_institution_id ON token_usage (institution_id);
CREATE INDEX idx_token_usage_user_id ON token_usage (user_id);
CREATE INDEX idx_token_usage_session_id ON token_usage (session_id);
CREATE INDEX idx_token_usage_model_id ON token_usage (model_id);
CREATE INDEX idx_token_usage_created_at ON token_usage (created_at DESC);