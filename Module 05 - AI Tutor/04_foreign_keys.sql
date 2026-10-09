-- ============================================================
-- Module 5 - AI Tutor
-- 04_foreign_keys.sql
-- ============================================================
-- ai_models
ALTER TABLE ai_models
ADD CONSTRAINT fk_ai_models_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_ai_models_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- prompt_templates
ALTER TABLE prompt_templates
ADD CONSTRAINT fk_prompt_templates_model FOREIGN KEY (model_id) REFERENCES ai_models(id),
    ADD CONSTRAINT fk_prompt_templates_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_prompt_templates_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- chat_sessions
ALTER TABLE chat_sessions
ADD CONSTRAINT fk_chat_sessions_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_chat_sessions_subject FOREIGN KEY (subject_id) REFERENCES subjects(id),
    ADD CONSTRAINT fk_chat_sessions_unit FOREIGN KEY (unit_id) REFERENCES units(id),
    ADD CONSTRAINT fk_chat_sessions_topic FOREIGN KEY (topic_id) REFERENCES syllabus_topics(id),
    ADD CONSTRAINT fk_chat_sessions_resource FOREIGN KEY (resource_id) REFERENCES resources(id),
    ADD CONSTRAINT fk_chat_sessions_model FOREIGN KEY (model_id) REFERENCES ai_models(id),
    ADD CONSTRAINT fk_chat_sessions_prompt_template FOREIGN KEY (prompt_template_id) REFERENCES prompt_templates(id),
    ADD CONSTRAINT fk_chat_sessions_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_chat_sessions_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- chat_messages
ALTER TABLE chat_messages
ADD CONSTRAINT fk_chat_messages_session FOREIGN KEY (session_id) REFERENCES chat_sessions(id),
    ADD CONSTRAINT fk_chat_messages_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_chat_messages_model FOREIGN KEY (model_id) REFERENCES ai_models(id),
    ADD CONSTRAINT fk_chat_messages_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_chat_messages_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- token_usage
ALTER TABLE token_usage
ADD CONSTRAINT fk_token_usage_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_token_usage_session FOREIGN KEY (session_id) REFERENCES chat_sessions(id),
    ADD CONSTRAINT fk_token_usage_message FOREIGN KEY (message_id) REFERENCES chat_messages(id),
    ADD CONSTRAINT fk_token_usage_model FOREIGN KEY (model_id) REFERENCES ai_models(id);