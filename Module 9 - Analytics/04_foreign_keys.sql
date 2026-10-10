-- ============================================================
-- Module 9 - Analytics
-- 04_foreign_keys.sql
-- ============================================================
-- subject_mastery
ALTER TABLE subject_mastery
ADD CONSTRAINT fk_subject_mastery_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_subject_mastery_subject FOREIGN KEY (subject_id) REFERENCES subjects(id),
    ADD CONSTRAINT fk_subject_mastery_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_subject_mastery_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- weak_topics
ALTER TABLE weak_topics
ADD CONSTRAINT fk_weak_topics_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_weak_topics_subject FOREIGN KEY (subject_id) REFERENCES subjects(id),
    ADD CONSTRAINT fk_weak_topics_unit FOREIGN KEY (unit_id) REFERENCES units(id),
    ADD CONSTRAINT fk_weak_topics_topic FOREIGN KEY (topic_id) REFERENCES syllabus_topics(id),
    ADD CONSTRAINT fk_weak_topics_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_weak_topics_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- study_metrics
ALTER TABLE study_metrics
ADD CONSTRAINT fk_study_metrics_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_study_metrics_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_study_metrics_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- flashcard_memory
ALTER TABLE flashcard_memory
ADD CONSTRAINT fk_flashcard_memory_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_flashcard_memory_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_flashcard_memory_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- flashcard_id FK will be added after Module 10
-- recommendations
ALTER TABLE recommendations
ADD CONSTRAINT fk_recommendations_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_recommendations_subject FOREIGN KEY (subject_id) REFERENCES subjects(id),
    ADD CONSTRAINT fk_recommendations_unit FOREIGN KEY (unit_id) REFERENCES units(id),
    ADD CONSTRAINT fk_recommendations_topic FOREIGN KEY (topic_id) REFERENCES syllabus_topics(id),
    ADD CONSTRAINT fk_recommendations_resource FOREIGN KEY (resource_id) REFERENCES resources(id),
    ADD CONSTRAINT fk_recommendations_question FOREIGN KEY (question_id) REFERENCES question_bank(id),
    ADD CONSTRAINT fk_recommendations_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_recommendations_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- performance_reports
ALTER TABLE performance_reports
ADD CONSTRAINT fk_performance_reports_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_performance_reports_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_performance_reports_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);