-- ============================================================
-- Module 2 - Academic Structure
-- 03_indexes.sql
-- ============================================================
-- departments
CREATE INDEX idx_departments_institution_id ON departments (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_departments_status ON departments (status)
WHERE deleted_at IS NULL;
CREATE INDEX idx_departments_head_user_id ON departments (head_user_id)
WHERE head_user_id IS NOT NULL;
CREATE INDEX idx_departments_sort_order ON departments (sort_order);
-- programs
CREATE INDEX idx_programs_institution_id ON programs (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_programs_department_id ON programs (department_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_programs_status ON programs (status)
WHERE deleted_at IS NULL;
CREATE INDEX idx_programs_degree_type ON programs (degree_type);
-- academic_years
CREATE INDEX idx_academic_years_institution_id ON academic_years (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_academic_years_is_current ON academic_years (is_current)
WHERE is_current = TRUE;
CREATE INDEX idx_academic_years_status ON academic_years (status)
WHERE deleted_at IS NULL;
-- semesters
CREATE INDEX idx_semesters_institution_id ON semesters (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_semesters_academic_year_id ON semesters (academic_year_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_semesters_program_id ON semesters (program_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_semesters_is_current ON semesters (is_current)
WHERE is_current = TRUE;
CREATE INDEX idx_semesters_status ON semesters (status)
WHERE deleted_at IS NULL;
-- subjects
CREATE INDEX idx_subjects_institution_id ON subjects (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_subjects_department_id ON subjects (department_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_subjects_program_id ON subjects (program_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_subjects_semester_id ON subjects (semester_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_subjects_status ON subjects (status)
WHERE deleted_at IS NULL;
CREATE INDEX idx_subjects_type ON subjects (subject_type);
-- units
CREATE INDEX idx_units_institution_id ON units (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_units_subject_id ON units (subject_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_units_status ON units (status)
WHERE deleted_at IS NULL;
CREATE INDEX idx_units_sort_order ON units (subject_id, sort_order);
-- syllabus_topics
CREATE INDEX idx_syllabus_topics_institution_id ON syllabus_topics (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_syllabus_topics_unit_id ON syllabus_topics (unit_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_syllabus_topics_subject_id ON syllabus_topics (subject_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_syllabus_topics_difficulty ON syllabus_topics (difficulty);
CREATE INDEX idx_syllabus_topics_status ON syllabus_topics (status)
WHERE deleted_at IS NULL;
CREATE INDEX idx_syllabus_topics_sort_order ON syllabus_topics (unit_id, sort_order);