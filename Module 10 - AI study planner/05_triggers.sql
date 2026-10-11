-- ============================================================
-- Module 10 - AI Study Planner
-- 05_triggers.sql
-- ============================================================
CREATE TRIGGER trg_ai_notes_updated_at BEFORE
UPDATE ON ai_notes FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_flashcard_decks_updated_at BEFORE
UPDATE ON flashcard_decks FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_flashcards_updated_at BEFORE
UPDATE ON flashcards FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_planner_schedules_updated_at BEFORE
UPDATE ON planner_schedules FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_planner_tasks_updated_at BEFORE
UPDATE ON planner_tasks FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();