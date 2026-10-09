-- ============================================================
-- Module 4 - OCR & AI Knowledge
-- 05_triggers.sql
-- ============================================================
CREATE TRIGGER trg_ocr_documents_updated_at BEFORE
UPDATE ON ocr_documents FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_document_pages_updated_at BEFORE
UPDATE ON document_pages FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_text_chunks_updated_at BEFORE
UPDATE ON text_chunks FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_embeddings_updated_at BEFORE
UPDATE ON embeddings FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_citation_contexts_updated_at BEFORE
UPDATE ON citation_contexts FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();