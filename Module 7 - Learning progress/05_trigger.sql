-- ============================================================
-- Module 7 - Learning Progress
-- 05_triggers.sql
-- ============================================================
CREATE TRIGGER trg_learning_progress_updated_at BEFORE
UPDATE ON learning_progress FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_completed_units_updated_at BEFORE
UPDATE ON completed_units FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_watch_history_updated_at BEFORE
UPDATE ON watch_history FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_reading_history_updated_at BEFORE
UPDATE ON reading_history FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_study_sessions_updated_at BEFORE
UPDATE ON study_sessions FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();