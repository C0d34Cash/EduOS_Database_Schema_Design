-- ============================================================
-- Module 7 - Learning Progress
-- 04_foreign_keys.sql
-- ============================================================
-- learning_progress
ALTER TABLE learning_progress
ADD CONSTRAINT fk_learning_progress_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_learning_progress_subject FOREIGN KEY (subject_id) REFERENCES subjects(id),
    ADD CONSTRAINT fk_learning_progress_unit FOREIGN KEY (unit_id) REFERENCES units(id),
    ADD CONSTRAINT fk_learning_progress_topic FOREIGN KEY (topic_id) REFERENCES syllabus_topics(id),
    ADD CONSTRAINT fk_learning_progress_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_learning_progress_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- completed_units
ALTER TABLE completed_units
ADD CONSTRAINT fk_completed_units_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_completed_units_subject FOREIGN KEY (subject_id) REFERENCES subjects(id),
    ADD CONSTRAINT fk_completed_units_unit FOREIGN KEY (unit_id) REFERENCES units(id),
    ADD CONSTRAINT fk_completed_units_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_completed_units_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- watch_history
ALTER TABLE watch_history
ADD CONSTRAINT fk_watch_history_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_watch_history_resource FOREIGN KEY (resource_id) REFERENCES resources(id),
    ADD CONSTRAINT fk_watch_history_video FOREIGN KEY (video_id) REFERENCES videos(id),
    ADD CONSTRAINT fk_watch_history_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_watch_history_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- reading_history
ALTER TABLE reading_history
ADD CONSTRAINT fk_reading_history_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_reading_history_resource FOREIGN KEY (resource_id) REFERENCES resources(id),
    ADD CONSTRAINT fk_reading_history_pdf FOREIGN KEY (pdf_document_id) REFERENCES pdf_documents(id),
    ADD CONSTRAINT fk_reading_history_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_reading_history_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- study_sessions
ALTER TABLE study_sessions
ADD CONSTRAINT fk_study_sessions_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_study_sessions_subject FOREIGN KEY (subject_id) REFERENCES subjects(id),
    ADD CONSTRAINT fk_study_sessions_unit FOREIGN KEY (unit_id) REFERENCES units(id),
    ADD CONSTRAINT fk_study_sessions_topic FOREIGN KEY (topic_id) REFERENCES syllabus_topics(id),
    ADD CONSTRAINT fk_study_sessions_resource FOREIGN KEY (resource_id) REFERENCES resources(id),
    ADD CONSTRAINT fk_study_sessions_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_study_sessions_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);