-- ============================================================
-- Module 11 - Notifications
-- 04_foreign_keys.sql
-- ============================================================
-- notification_templates
ALTER TABLE notification_templates
ADD CONSTRAINT fk_notification_templates_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_notification_templates_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- notifications
ALTER TABLE notifications
ADD CONSTRAINT fk_notifications_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_notifications_template FOREIGN KEY (template_id) REFERENCES notification_templates(id),
    ADD CONSTRAINT fk_notifications_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_notifications_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- announcements
ALTER TABLE announcements
ADD CONSTRAINT fk_announcements_department FOREIGN KEY (department_id) REFERENCES departments(id),
    ADD CONSTRAINT fk_announcements_program FOREIGN KEY (program_id) REFERENCES programs(id),
    ADD CONSTRAINT fk_announcements_author FOREIGN KEY (author_id) REFERENCES users(id),
    ADD CONSTRAINT fk_announcements_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_announcements_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);