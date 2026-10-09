-- ============================================================
-- 06_triggers.sql
-- EduOS Module 1 - updated_at Triggers
-- ============================================================
CREATE OR REPLACE FUNCTION update_updated_at_column() RETURNS TRIGGER AS $$ BEGIN NEW.updated_at = CURRENT_TIMESTAMP;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
-- users
CREATE TRIGGER trg_users_updated_at BEFORE
UPDATE ON users FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
-- roles
CREATE TRIGGER trg_roles_updated_at BEFORE
UPDATE ON roles FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
-- permissions
CREATE TRIGGER trg_permissions_updated_at BEFORE
UPDATE ON permissions FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
-- role_permissions
CREATE TRIGGER trg_role_permissions_updated_at BEFORE
UPDATE ON role_permissions FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
-- user_roles
CREATE TRIGGER trg_user_roles_updated_at BEFORE
UPDATE ON user_roles FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
-- auth_providers
CREATE TRIGGER trg_auth_providers_updated_at BEFORE
UPDATE ON auth_providers FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
-- user_sessions
CREATE TRIGGER trg_user_sessions_updated_at BEFORE
UPDATE ON user_sessions FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
-- student_profiles
CREATE TRIGGER trg_student_profiles_updated_at BEFORE
UPDATE ON student_profiles FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
-- faculty_profiles
CREATE TRIGGER trg_faculty_profiles_updated_at BEFORE
UPDATE ON faculty_profiles FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
-- admin_profiles
CREATE TRIGGER trg_admin_profiles_updated_at BEFORE
UPDATE ON admin_profiles FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();