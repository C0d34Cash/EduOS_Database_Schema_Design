-- ============================================================
-- Module 12 - Administration
-- 03_indexes.sql
-- ============================================================
-- audit_logs
CREATE INDEX idx_audit_logs_institution_id ON audit_logs (institution_id);
CREATE INDEX idx_audit_logs_user_id ON audit_logs (user_id);
CREATE INDEX idx_audit_logs_entity ON audit_logs (entity_type, entity_id);
CREATE INDEX idx_audit_logs_action ON audit_logs (action);
CREATE INDEX idx_audit_logs_created_at ON audit_logs (created_at DESC);
-- ocr_queue
CREATE INDEX idx_ocr_queue_status ON ocr_queue (status)
WHERE deleted_at IS NULL;
CREATE INDEX idx_ocr_queue_priority ON ocr_queue (priority, created_at)
WHERE status = 'QUEUED';
CREATE INDEX idx_ocr_queue_resource_id ON ocr_queue (resource_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_ocr_queue_institution_id ON ocr_queue (institution_id)
WHERE deleted_at IS NULL;
-- system_metrics
CREATE INDEX idx_system_metrics_name_time ON system_metrics (metric_name, recorded_at DESC);
CREATE INDEX idx_system_metrics_institution ON system_metrics (institution_id, recorded_at DESC);
-- feature_flags
CREATE INDEX idx_feature_flags_status ON feature_flags (status)
WHERE deleted_at IS NULL;
CREATE INDEX idx_feature_flags_institution ON feature_flags (institution_id)
WHERE deleted_at IS NULL;
-- configurations
CREATE INDEX idx_configurations_key ON configurations (key)
WHERE deleted_at IS NULL;
CREATE INDEX idx_configurations_institution ON configurations (institution_id)
WHERE deleted_at IS NULL;