-- ============================================================
-- Module 3 - Learning Resources
-- 05_triggers.sql
-- ============================================================
CREATE TRIGGER trg_resources_updated_at BEFORE
UPDATE ON resources FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_pdf_documents_updated_at BEFORE
UPDATE ON pdf_documents FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_videos_updated_at BEFORE
UPDATE ON videos FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_web_resources_updated_at BEFORE
UPDATE ON web_resources FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_official_syllabus_updated_at BEFORE
UPDATE ON official_syllabus FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_tags_updated_at BEFORE
UPDATE ON tags FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();