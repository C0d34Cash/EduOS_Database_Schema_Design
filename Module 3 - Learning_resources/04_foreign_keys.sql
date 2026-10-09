-- ============================================================
-- Module 3 - Learning Resources
-- 04_foreign_keys.sql
-- ============================================================
-- resources
ALTER TABLE resources
ADD CONSTRAINT fk_resources_subject FOREIGN KEY (subject_id) REFERENCES subjects(id),
    ADD CONSTRAINT fk_resources_unit FOREIGN KEY (unit_id) REFERENCES units(id),
    ADD CONSTRAINT fk_resources_topic FOREIGN KEY (topic_id) REFERENCES syllabus_topics(id),
    ADD CONSTRAINT fk_resources_department FOREIGN KEY (department_id) REFERENCES departments(id),
    ADD CONSTRAINT fk_resources_uploaded_by FOREIGN KEY (uploaded_by) REFERENCES users(id),
    ADD CONSTRAINT fk_resources_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_resources_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- pdf_documents
ALTER TABLE pdf_documents
ADD CONSTRAINT fk_pdf_documents_resource FOREIGN KEY (resource_id) REFERENCES resources(id),
    ADD CONSTRAINT fk_pdf_documents_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_pdf_documents_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- videos
ALTER TABLE videos
ADD CONSTRAINT fk_videos_resource FOREIGN KEY (resource_id) REFERENCES resources(id),
    ADD CONSTRAINT fk_videos_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_videos_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- web_resources
ALTER TABLE web_resources
ADD CONSTRAINT fk_web_resources_resource FOREIGN KEY (resource_id) REFERENCES resources(id),
    ADD CONSTRAINT fk_web_resources_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_web_resources_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- official_syllabus
ALTER TABLE official_syllabus
ADD CONSTRAINT fk_official_syllabus_resource FOREIGN KEY (resource_id) REFERENCES resources(id),
    ADD CONSTRAINT fk_official_syllabus_program FOREIGN KEY (program_id) REFERENCES programs(id),
    ADD CONSTRAINT fk_official_syllabus_academic_year FOREIGN KEY (academic_year_id) REFERENCES academic_years(id),
    ADD CONSTRAINT fk_official_syllabus_semester FOREIGN KEY (semester_id) REFERENCES semesters(id),
    ADD CONSTRAINT fk_official_syllabus_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_official_syllabus_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- tags
ALTER TABLE tags
ADD CONSTRAINT fk_tags_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_tags_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- resource_tags
ALTER TABLE resource_tags
ADD CONSTRAINT fk_resource_tags_resource FOREIGN KEY (resource_id) REFERENCES resources(id),
    ADD CONSTRAINT fk_resource_tags_tag FOREIGN KEY (tag_id) REFERENCES tags(id),
    ADD CONSTRAINT fk_resource_tags_created_by FOREIGN KEY (created_by) REFERENCES users(id);