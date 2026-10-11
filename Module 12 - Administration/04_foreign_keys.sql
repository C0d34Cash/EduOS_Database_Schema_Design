-- ============================================================
-- Module 12 - Administration
-- 04_foreign_keys.sql
-- ============================================================
-- audit_logs (no strict FKs needed for performance + immutability, but optional)
-- ALTER TABLE audit_logs
--     ADD CONSTRAINT fk_audit_logs_user FOREIGN KEY (user_id) REFERENCES users(id);
-- ocr_queue
ALTER TABLE ocr_queue
ADD CONSTRAINT fk_ocr_queue_resource FOREIGN KEY (resource_id) REFERENCES resources(id),
    ADD CONSTRAINT fk_ocr_queue_pdf_document FOREIGN KEY (pdf_document_id) REFERENCES pdf_documents(id),
    ADD CONSTRAINT fk_ocr_queue_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_ocr_queue_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- feature_flags
ALTER TABLE feature_flags
ADD CONSTRAINT fk_feature_flags_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_feature_flags_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- configurations
ALTER TABLE configurations
ADD CONSTRAINT fk_configurations_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_configurations_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);