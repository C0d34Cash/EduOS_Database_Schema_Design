-- ============================================================
-- Module 11 - Notifications
-- 05_triggers.sql
-- ============================================================
CREATE TRIGGER trg_notification_templates_updated_at BEFORE
UPDATE ON notification_templates FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_notifications_updated_at BEFORE
UPDATE ON notifications FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_announcements_updated_at BEFORE
UPDATE ON announcements FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();