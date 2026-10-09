-- ============================================================
-- Module 3 - Learning Resources
-- 03_indexes.sql
-- ============================================================
-- resources
CREATE INDEX idx_resources_institution_id ON resources (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_resources_resource_type ON resources (resource_type)
WHERE deleted_at IS NULL;
CREATE INDEX idx_resources_status ON resources (status)
WHERE deleted_at IS NULL;
CREATE INDEX idx_resources_subject_id ON resources (subject_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_resources_unit_id ON resources (unit_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_resources_topic_id ON resources (topic_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_resources_department_id ON resources (department_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_resources_uploaded_by ON resources (uploaded_by)
WHERE deleted_at IS NULL;
CREATE INDEX idx_resources_is_official ON resources (is_official)
WHERE is_official = TRUE;
CREATE INDEX idx_resources_published_at ON resources (published_at DESC)
WHERE published_at IS NOT NULL;
-- pdf_documents
CREATE INDEX idx_pdf_documents_resource_id ON pdf_documents (resource_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_pdf_documents_institution_id ON pdf_documents (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_pdf_documents_ocr_status ON pdf_documents (ocr_status);
-- videos
CREATE INDEX idx_videos_resource_id ON videos (resource_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_videos_institution_id ON videos (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_videos_provider ON videos (provider);
-- web_resources
CREATE INDEX idx_web_resources_resource_id ON web_resources (resource_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_web_resources_institution_id ON web_resources (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_web_resources_domain ON web_resources (domain);
-- official_syllabus
CREATE INDEX idx_official_syllabus_resource_id ON official_syllabus (resource_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_official_syllabus_institution_id ON official_syllabus (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_official_syllabus_program_id ON official_syllabus (program_id);
CREATE INDEX idx_official_syllabus_academic_year_id ON official_syllabus (academic_year_id);
-- tags
CREATE INDEX idx_tags_institution_id ON tags (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_tags_status ON tags (status)
WHERE deleted_at IS NULL;
CREATE INDEX idx_tags_usage_count ON tags (usage_count DESC);
-- resource_tags
CREATE INDEX idx_resource_tags_resource_id ON resource_tags (resource_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_resource_tags_tag_id ON resource_tags (tag_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_resource_tags_institution_id ON resource_tags (institution_id);