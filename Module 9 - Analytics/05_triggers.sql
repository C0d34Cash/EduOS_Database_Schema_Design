-- ============================================================
-- Module 9 - Analytics
-- 05_triggers.sql
-- ============================================================
CREATE TRIGGER trg_subject_mastery_updated_at BEFORE
UPDATE ON subject_mastery FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_weak_topics_updated_at BEFORE
UPDATE ON weak_topics FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_study_metrics_updated_at BEFORE
UPDATE ON study_metrics FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_flashcard_memory_updated_at BEFORE
UPDATE ON flashcard_memory FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_recommendations_updated_at BEFORE
UPDATE ON recommendations FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_performance_reports_updated_at BEFORE
UPDATE ON performance_reports FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();