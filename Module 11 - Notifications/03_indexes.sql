-- ============================================================
-- Module 11 - Notifications
-- 03_indexes.sql
-- ============================================================
-- notification_templates
CREATE INDEX idx_notification_templates_type ON notification_templates (notification_type)
WHERE deleted_at IS NULL;
CREATE INDEX idx_notification_templates_channel ON notification_templates (channel);
CREATE INDEX idx_notification_templates_active ON notification_templates (is_active)
WHERE is_active = TRUE;
-- notifications
CREATE INDEX idx_notifications_user_id ON notifications (user_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_notifications_status ON notifications (status)
WHERE deleted_at IS NULL;
CREATE INDEX idx_notifications_type ON notifications (notification_type);
CREATE INDEX idx_notifications_channel ON notifications (channel);
CREATE INDEX idx_notifications_created_at ON notifications (created_at DESC);
CREATE INDEX idx_notifications_unread ON notifications (user_id, status)
WHERE status != 'READ'
    AND deleted_at IS NULL;
-- announcements
CREATE INDEX idx_announcements_institution_id ON announcements (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_announcements_status ON announcements (status)
WHERE deleted_at IS NULL;
CREATE INDEX idx_announcements_audience ON announcements (audience);
CREATE INDEX idx_announcements_publish_at ON announcements (publish_at);
CREATE INDEX idx_announcements_is_pinned ON announcements (is_pinned)
WHERE is_pinned = TRUE;