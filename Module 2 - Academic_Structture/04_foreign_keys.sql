-- ============================================================
-- Module 2 - Academic Structure
-- 04_foreign_keys.sql
-- ============================================================
-- Note: institution_id foreign keys will be added after the institutions table is created.
-- departments
ALTER TABLE departments
ADD CONSTRAINT fk_departments_head_user FOREIGN KEY (head_user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_departments_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_departments_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- programs
ALTER TABLE programs
ADD CONSTRAINT fk_programs_department FOREIGN KEY (department_id) REFERENCES departments(id),
    ADD CONSTRAINT fk_programs_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_programs_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- academic_years
ALTER TABLE academic_years
ADD CONSTRAINT fk_academic_years_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_academic_years_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- semesters
ALTER TABLE semesters
ADD CONSTRAINT fk_semesters_academic_year FOREIGN KEY (academic_year_id) REFERENCES academic_years(id),
    ADD CONSTRAINT fk_semesters_program FOREIGN KEY (program_id) REFERENCES programs(id),
    ADD CONSTRAINT fk_semesters_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_semesters_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- subjects
ALTER TABLE subjects
ADD CONSTRAINT fk_subjects_department FOREIGN KEY (department_id) REFERENCES departments(id),
    ADD CONSTRAINT fk_subjects_program FOREIGN KEY (program_id) REFERENCES programs(id),
    ADD CONSTRAINT fk_subjects_semester FOREIGN KEY (semester_id) REFERENCES semesters(id),
    ADD CONSTRAINT fk_subjects_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_subjects_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- units
ALTER TABLE units
ADD CONSTRAINT fk_units_subject FOREIGN KEY (subject_id) REFERENCES subjects(id),
    ADD CONSTRAINT fk_units_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_units_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- syllabus_topics
ALTER TABLE syllabus_topics
ADD CONSTRAINT fk_syllabus_topics_unit FOREIGN KEY (unit_id) REFERENCES units(id),
    ADD CONSTRAINT fk_syllabus_topics_subject FOREIGN KEY (subject_id) REFERENCES subjects(id),
    ADD CONSTRAINT fk_syllabus_topics_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_syllabus_topics_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);