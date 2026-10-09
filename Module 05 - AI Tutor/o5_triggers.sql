-- ============================================================
-- Module 5 - AI Tutor
-- 05_triggers.sql
-- ============================================================
CREATE TRIGGER trg_ai_models_updated_at BEFORE
UPDATE ON ai_models FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_prompt_templates_updated_at BEFORE
UPDATE ON prompt_templates FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_chat_sessions_updated_at BEFORE
UPDATE ON chat_sessions FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_chat_messages_updated_at BEFORE
UPDATE ON chat_messages FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();