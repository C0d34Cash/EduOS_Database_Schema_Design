-- ============================================================
-- 04_indexes.sql
-- EduOS Module 1 - Performance Indexes
-- ============================================================
-- users
CREATE INDEX idx_users_institution_id ON users (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_users_department_id ON users (department_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_users_email ON users (email)
WHERE deleted_at IS NULL;
CREATE INDEX idx_users_username ON users (username)
WHERE deleted_at IS NULL;
CREATE INDEX idx_users_status ON users (status)
WHERE deleted_at IS NULL;
CREATE INDEX idx_users_search_vector ON users USING GIN (search_vector);
CREATE INDEX idx_users_created_at ON users (created_at DESC);
-- roles
CREATE INDEX idx_roles_institution_id ON roles (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_roles_parent_role_id ON roles (parent_role_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_roles_status ON roles (status)
WHERE deleted_at IS NULL;
CREATE INDEX idx_roles_scope ON roles (scope);
CREATE INDEX idx_roles_metadata ON roles USING GIN (metadata);
-- permissions
CREATE INDEX idx_permissions_module ON permissions (module);
CREATE INDEX idx_permissions_resource ON permissions (resource);
CREATE INDEX idx_permissions_status ON permissions (status)
WHERE deleted_at IS NULL;
CREATE INDEX idx_permissions_metadata ON permissions USING GIN (metadata);
-- role_permissions
CREATE INDEX idx_role_permissions_role_id ON role_permissions (role_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_role_permissions_permission_id ON role_permissions (permission_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_role_permissions_institution_id ON role_permissions (institution_id);
CREATE INDEX idx_role_permissions_conditions ON role_permissions USING GIN (conditions);
-- user_roles
CREATE INDEX idx_user_roles_user_id ON user_roles (user_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_user_roles_role_id ON user_roles (role_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_user_roles_institution_id ON user_roles (institution_id);
CREATE INDEX idx_user_roles_department_id ON user_roles (department_id);
CREATE INDEX idx_user_roles_expires_at ON user_roles (expires_at)
WHERE expires_at IS NOT NULL;
-- auth_providers
CREATE INDEX idx_auth_providers_user_id ON auth_providers (user_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_auth_providers_institution_id ON auth_providers (institution_id);
CREATE INDEX idx_auth_providers_provider_user_id ON auth_providers (provider_user_id)
WHERE provider_user_id IS NOT NULL;
-- user_sessions
CREATE INDEX idx_user_sessions_user_id ON user_sessions (user_id);
CREATE INDEX idx_user_sessions_institution_id ON user_sessions (institution_id);
CREATE INDEX idx_user_sessions_status ON user_sessions (status);
CREATE INDEX idx_user_sessions_refresh_token_hash ON user_sessions (refresh_token_hash);
CREATE INDEX idx_user_sessions_expires_at ON user_sessions (expires_at);
CREATE INDEX idx_user_sessions_last_activity ON user_sessions (last_activity_at DESC);
CREATE INDEX idx_user_sessions_ip_address ON user_sessions (ip_address);
-- login_history
CREATE INDEX idx_login_history_user_id ON login_history (user_id);
CREATE INDEX idx_login_history_institution_id ON login_history (institution_id);
CREATE INDEX idx_login_history_status ON login_history (status);
CREATE INDEX idx_login_history_created_at ON login_history (created_at DESC);
CREATE INDEX idx_login_history_ip_address ON login_history (ip_address);
CREATE INDEX idx_login_history_email_attempted ON login_history (email_attempted);
CREATE INDEX idx_login_history_request_id ON login_history (request_id);
-- student_profiles
CREATE INDEX idx_student_profiles_institution_id ON student_profiles (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_student_profiles_department_id ON student_profiles (department_id);
CREATE INDEX idx_student_profiles_academic_year_id ON student_profiles (academic_year_id);
CREATE INDEX idx_student_profiles_status ON student_profiles (academic_status);
-- faculty_profiles
CREATE INDEX idx_faculty_profiles_institution_id ON faculty_profiles (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_faculty_profiles_department_id ON faculty_profiles (department_id);
CREATE INDEX idx_faculty_profiles_designation ON faculty_profiles (designation);
CREATE INDEX idx_faculty_profiles_is_hod ON faculty_profiles (is_department_head)
WHERE is_department_head = TRUE;
-- admin_profiles
CREATE INDEX idx_admin_profiles_institution_id ON admin_profiles (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_admin_profiles_admin_level ON admin_profiles (admin_level);
CREATE INDEX idx_admin_profiles_clearance ON admin_profiles (clearance_tier);