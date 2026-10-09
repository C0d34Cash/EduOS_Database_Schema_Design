-- ============================================================
-- Module 2 - Academic Structure
-- 05_triggers.sql
-- ============================================================
-- Re-use the same function from Module 1 (if already created)
-- CREATE OR REPLACE FUNCTION update_updated_at_column() ...
CREATE TRIGGER trg_departments_updated_at BEFORE
UPDATE ON departments FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_programs_updated_at BEFORE
UPDATE ON programs FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_academic_years_updated_at BEFORE
UPDATE ON academic_years FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_semesters_updated_at BEFORE
UPDATE ON semesters FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_subjects_updated_at BEFORE
UPDATE ON subjects FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_units_updated_at BEFORE
UPDATE ON units FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_syllabus_topics_updated_at BEFORE
UPDATE ON syllabus_topics FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();