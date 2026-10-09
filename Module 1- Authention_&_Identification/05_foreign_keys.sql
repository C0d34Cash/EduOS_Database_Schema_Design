-- ============================================================
-- 05_foreign_keys.sql
-- EduOS Module 1 - Foreign Key Constraints
-- ============================================================
-- Note: FKs to institutions, departments, academic_years, semesters
-- should be added after Module 2 tables are created.
-- users
ALTER TABLE users
ADD CONSTRAINT fk_users_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_users_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- roles
ALTER TABLE roles
ADD CONSTRAINT fk_roles_parent FOREIGN KEY (parent_role_id) REFERENCES roles(id),
    ADD CONSTRAINT fk_roles_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_roles_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- permissions
ALTER TABLE permissions
ADD CONSTRAINT fk_permissions_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_permissions_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- role_permissions
ALTER TABLE role_permissions
ADD CONSTRAINT fk_role_permissions_role FOREIGN KEY (role_id) REFERENCES roles(id),
    ADD CONSTRAINT fk_role_permissions_permission FOREIGN KEY (permission_id) REFERENCES permissions(id),
    ADD CONSTRAINT fk_role_permissions_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_role_permissions_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- user_roles
ALTER TABLE user_roles
ADD CONSTRAINT fk_user_roles_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_user_roles_role FOREIGN KEY (role_id) REFERENCES roles(id),
    ADD CONSTRAINT fk_user_roles_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_user_roles_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- auth_providers
ALTER TABLE auth_providers
ADD CONSTRAINT fk_auth_providers_user FOREIGN KEY (user_id) REFERENCES users(id);
-- user_sessions
ALTER TABLE user_sessions
ADD CONSTRAINT fk_user_sessions_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_user_sessions_auth_provider FOREIGN KEY (auth_provider_id) REFERENCES auth_providers(id);
-- student_profiles
ALTER TABLE student_profiles
ADD CONSTRAINT fk_student_profiles_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_student_profiles_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_student_profiles_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- faculty_profiles
ALTER TABLE faculty_profiles
ADD CONSTRAINT fk_faculty_profiles_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_faculty_profiles_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_faculty_profiles_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- admin_profiles
ALTER TABLE admin_profiles
ADD CONSTRAINT fk_admin_profiles_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_admin_profiles_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_admin_profiles_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);