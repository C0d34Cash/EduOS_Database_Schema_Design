-- ============================================================
-- Module 7 - Learning Progress
-- 03_indexes.sql
-- ============================================================
-- learning_progress
CREATE INDEX idx_learning_progress_user_id ON learning_progress (user_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_learning_progress_subject_id ON learning_progress (subject_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_learning_progress_unit_id ON learning_progress (unit_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_learning_progress_topic_id ON learning_progress (topic_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_learning_progress_status ON learning_progress (status);
CREATE INDEX idx_learning_progress_institution ON learning_progress (institution_id)
WHERE deleted_at IS NULL;
-- completed_units
CREATE INDEX idx_completed_units_user_id ON completed_units (user_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_completed_units_subject_id ON completed_units (subject_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_completed_units_unit_id ON completed_units (unit_id)
WHERE deleted_at IS NULL;
-- watch_history
CREATE INDEX idx_watch_history_user_id ON watch_history (user_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_watch_history_resource_id ON watch_history (resource_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_watch_history_is_completed ON watch_history (is_completed)
WHERE is_completed = TRUE;
-- reading_history
CREATE INDEX idx_reading_history_user_id ON reading_history (user_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_reading_history_resource_id ON reading_history (resource_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_reading_history_is_completed ON reading_history (is_completed)
WHERE is_completed = TRUE;
-- study_sessions
CREATE INDEX idx_study_sessions_user_id ON study_sessions (user_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_study_sessions_subject_id ON study_sessions (subject_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_study_sessions_started_at ON study_sessions (started_at DESC);
CREATE INDEX idx_study_sessions_status ON study_sessions (status);
CREATE INDEX idx_study_sessions_session_type ON study_sessions (session_type);