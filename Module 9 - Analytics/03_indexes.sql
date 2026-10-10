-- ============================================================
-- Module 9 - Analytics
-- 03_indexes.sql
-- ============================================================
-- subject_mastery
CREATE INDEX idx_subject_mastery_user_id ON subject_mastery (user_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_subject_mastery_subject_id ON subject_mastery (subject_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_subject_mastery_level ON subject_mastery (mastery_level);
-- weak_topics
CREATE INDEX idx_weak_topics_user_id ON weak_topics (user_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_weak_topics_subject_id ON weak_topics (subject_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_weak_topics_topic_id ON weak_topics (topic_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_weak_topics_is_resolved ON weak_topics (is_resolved)
WHERE is_resolved = FALSE;
-- study_metrics
CREATE INDEX idx_study_metrics_user_id ON study_metrics (user_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_study_metrics_date ON study_metrics (metric_date DESC);
CREATE INDEX idx_study_metrics_user_date ON study_metrics (user_id, metric_date DESC);
-- flashcard_memory
CREATE INDEX idx_flashcard_memory_user_id ON flashcard_memory (user_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_flashcard_memory_next_review ON flashcard_memory (next_review_at)
WHERE next_review_at IS NOT NULL;
-- recommendations
CREATE INDEX idx_recommendations_user_id ON recommendations (user_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_recommendations_status ON recommendations (status)
WHERE deleted_at IS NULL;
CREATE INDEX idx_recommendations_priority ON recommendations (priority);
CREATE INDEX idx_recommendations_type ON recommendations (recommendation_type);
-- performance_reports
CREATE INDEX idx_performance_reports_user_id ON performance_reports (user_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_performance_reports_type ON performance_reports (report_type);
CREATE INDEX idx_performance_reports_status ON performance_reports (status);