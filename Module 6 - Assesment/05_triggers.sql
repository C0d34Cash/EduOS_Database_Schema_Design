-- ============================================================
-- Module 6 - Assessment
-- 05_triggers.sql
-- ============================================================
CREATE TRIGGER trg_question_difficulty_updated_at BEFORE
UPDATE ON question_difficulty FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_question_bank_updated_at BEFORE
UPDATE ON question_bank FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_question_options_updated_at BEFORE
UPDATE ON question_options FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_pyqs_updated_at BEFORE
UPDATE ON pyqs FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_mock_tests_updated_at BEFORE
UPDATE ON mock_tests FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_quiz_attempts_updated_at BEFORE
UPDATE ON quiz_attempts FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_submission_answers_updated_at BEFORE
UPDATE ON submission_answers FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();