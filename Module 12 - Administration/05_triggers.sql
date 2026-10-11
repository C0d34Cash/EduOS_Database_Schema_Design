-- ============================================================
-- Module 12 - Administration
-- 05_triggers.sql
-- ============================================================
CREATE TRIGGER trg_ocr_queue_updated_at BEFORE
UPDATE ON ocr_queue FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_feature_flags_updated_at BEFORE
UPDATE ON feature_flags FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_configurations_updated_at BEFORE
UPDATE ON configurations FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();