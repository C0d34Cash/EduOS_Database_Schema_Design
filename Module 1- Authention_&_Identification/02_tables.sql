-- ============================================================
-- 02_tables.sql
-- EduOS Module 1 - Core Tables
-- ============================================================
-- ========== 1. users ==========
CREATE TABLE users (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    department_id UUID NULL,
    email VARCHAR(255) NOT NULL,
    username VARCHAR(50) NOT NULL,
    password_hash VARCHAR(255) NULL,
    status user_status_enum NOT NULL DEFAULT 'PENDING_VERIFICATION',
    version INTEGER NOT NULL DEFAULT 1,
    failed_login_attempts SMALLINT NOT NULL DEFAULT 0,
    locked_until TIMESTAMPTZ NULL,
    mfa_enabled BOOLEAN NOT NULL DEFAULT FALSE,
    mfa_secret VARCHAR(255) NULL,
    email_verified_at TIMESTAMPTZ NULL,
    search_vector TSVECTOR GENERATED ALWAYS AS (
        setweight(
            to_tsvector('english', coalesce(username, '')),
            'A'
        ) || setweight(to_tsvector('english', coalesce(email, '')), 'B')
    ) STORED,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_users_email_institution UNIQUE (institution_id, email),
    CONSTRAINT uq_users_username_institution UNIQUE (institution_id, username)
);
COMMENT ON TABLE users IS 'Core identity and authentication root table';
-- ========== 2. roles ==========
CREATE TABLE roles (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    parent_role_id UUID NULL,
    code VARCHAR(50) NOT NULL,
    slug VARCHAR(100) NOT NULL,
    display_name VARCHAR(100) NOT NULL,
    description TEXT NULL,
    icon VARCHAR(50) NULL,
    color VARCHAR(20) NULL,
    priority SMALLINT NOT NULL DEFAULT 100,
    sort_order SMALLINT NOT NULL DEFAULT 0,
    scope role_scope_enum NOT NULL DEFAULT 'INSTITUTION',
    status role_status_enum NOT NULL DEFAULT 'ACTIVE',
    is_default BOOLEAN NOT NULL DEFAULT FALSE,
    is_system_role BOOLEAN NOT NULL DEFAULT FALSE,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    activated_at TIMESTAMPTZ NULL,
    deactivated_at TIMESTAMPTZ NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_roles_code_institution UNIQUE (institution_id, code),
    CONSTRAINT uq_roles_slug_institution UNIQUE (institution_id, slug)
);
COMMENT ON TABLE roles IS 'Enterprise hierarchical RBAC role definitions per tenant';
-- ========== 3. permissions ==========
CREATE TABLE permissions (
    id UUID PRIMARY KEY,
    module VARCHAR(50) NOT NULL,
    resource VARCHAR(50) NOT NULL,
    action VARCHAR(50) NOT NULL,
    code VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL,
    display_name VARCHAR(100) NOT NULL,
    description TEXT NULL,
    scope permission_scope_enum NOT NULL DEFAULT 'INSTITUTION',
    status permission_status_enum NOT NULL DEFAULT 'ACTIVE',
    is_system_permission BOOLEAN NOT NULL DEFAULT FALSE,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_permissions_code UNIQUE (code),
    CONSTRAINT uq_permissions_slug UNIQUE (slug)
);
COMMENT ON TABLE permissions IS 'Granular atomic capability rules across all EduOS modules';
-- ========== 4. role_permissions ==========
CREATE TABLE role_permissions (
    id UUID PRIMARY KEY,
    role_id UUID NOT NULL,
    permission_id UUID NOT NULL,
    institution_id UUID NOT NULL,
    grant_type role_permission_grant_enum NOT NULL DEFAULT 'ALLOW',
    conditions JSONB NOT NULL DEFAULT '{}',
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    version INTEGER NOT NULL DEFAULT 1,
    granted_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    revoked_at TIMESTAMPTZ NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_role_permissions UNIQUE (role_id, permission_id, institution_id)
);
COMMENT ON TABLE role_permissions IS 'Junction mapping roles to permissions with ALLOW/DENY + ABAC';
-- ========== 5. user_roles ==========
CREATE TABLE user_roles (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL,
    role_id UUID NOT NULL,
    institution_id UUID NOT NULL,
    department_id UUID NULL,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    assigned_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMPTZ NULL,
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_user_roles UNIQUE (user_id, role_id, institution_id, department_id)
);
COMMENT ON TABLE user_roles IS 'Junction mapping users to roles with department scopes and expiration';
-- ========== 6. auth_providers ==========
CREATE TABLE auth_providers (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL,
    institution_id UUID NOT NULL,
    provider_type auth_provider_type_enum NOT NULL DEFAULT 'PASSWORD',
    provider_user_id VARCHAR(255) NULL,
    provider_email VARCHAR(255) NULL,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    provider_metadata JSONB NOT NULL DEFAULT '{}',
    last_used_at TIMESTAMPTZ NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_auth_providers_user_provider UNIQUE (user_id, provider_type)
);
COMMENT ON TABLE auth_providers IS 'Multi-tenant SSO and credential authentication provider mappings';
-- ========== 7. user_sessions ==========
CREATE TABLE user_sessions (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL,
    institution_id UUID NOT NULL,
    auth_provider_id UUID NULL,
    refresh_token_hash VARCHAR(255) NOT NULL,
    status session_status_enum NOT NULL DEFAULT 'ACTIVE',
    session_type session_type_enum NOT NULL DEFAULT 'WEB',
    device_type VARCHAR(50) NULL,
    device_name VARCHAR(100) NULL,
    browser VARCHAR(100) NULL,
    operating_system VARCHAR(100) NULL,
    user_agent TEXT NULL,
    device_fingerprint VARCHAR(255) NULL,
    ip_address INET NOT NULL,
    country_code VARCHAR(2) NULL,
    city VARCHAR(100) NULL,
    risk_score SMALLINT NOT NULL DEFAULT 0,
    is_mfa_verified BOOLEAN NOT NULL DEFAULT FALSE,
    mfa_method mfa_method_enum NOT NULL DEFAULT 'NONE',
    failed_refresh_count SMALLINT NOT NULL DEFAULT 0,
    last_activity_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_refresh_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMPTZ NOT NULL,
    logout_at TIMESTAMPTZ NULL,
    revoked_at TIMESTAMPTZ NULL,
    revocation_reason session_revocation_reason_enum NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);
COMMENT ON TABLE user_sessions IS 'Active refresh token sessions, devices, MFA states and risk scores';
-- ========== 8. login_history (Parent Partitioned Table) ==========
CREATE TABLE login_history (
    id UUID NOT NULL,
    request_id UUID NOT NULL,
    user_id UUID NULL,
    institution_id UUID NULL,
    auth_provider_id UUID NULL,
    session_id UUID NULL,
    status login_status_enum NOT NULL,
    failure_code login_failure_code_enum NOT NULL DEFAULT 'NONE',
    failure_reason TEXT NULL,
    login_source login_source_enum NOT NULL DEFAULT 'WEB',
    email_attempted VARCHAR(255) NOT NULL,
    mfa_required BOOLEAN NOT NULL DEFAULT FALSE,
    mfa_completed BOOLEAN NOT NULL DEFAULT FALSE,
    ip_address INET NOT NULL,
    network_asn INTEGER NULL,
    network_provider VARCHAR(150) NULL,
    is_vpn BOOLEAN NOT NULL DEFAULT FALSE,
    is_tor BOOLEAN NOT NULL DEFAULT FALSE,
    is_proxy BOOLEAN NOT NULL DEFAULT FALSE,
    trusted_device BOOLEAN NOT NULL DEFAULT FALSE,
    device_type VARCHAR(50) NULL,
    device_name VARCHAR(100) NULL,
    browser VARCHAR(100) NULL,
    operating_system VARCHAR(100) NULL,
    user_agent TEXT NULL,
    device_fingerprint VARCHAR(255) NULL,
    country_code VARCHAR(2) NULL,
    city VARCHAR(100) NULL,
    location_point POINT NULL,
    risk_score SMALLINT NOT NULL DEFAULT 0,
    authentication_time_ms SMALLINT NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (created_at);
COMMENT ON TABLE login_history IS 'Immutable partitioned event store for authentication attempts (SIEM + ML)';
-- ========== 9. student_profiles ==========
CREATE TABLE student_profiles (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL,
    institution_id UUID NOT NULL,
    department_id UUID NOT NULL,
    academic_year_id UUID NOT NULL,
    current_semester_id UUID NOT NULL,
    roll_number VARCHAR(50) NOT NULL,
    registration_number VARCHAR(50) NOT NULL,
    batch_start_year SMALLINT NOT NULL,
    batch_end_year SMALLINT NOT NULL,
    section VARCHAR(10) NULL,
    academic_status academic_status_enum NOT NULL DEFAULT 'ACTIVE',
    enrollment_type enrollment_type_enum NOT NULL DEFAULT 'REGULAR',
    cgpa NUMERIC(3, 2) NOT NULL DEFAULT 0.00,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_student_profiles_user UNIQUE (user_id),
    CONSTRAINT uq_student_profiles_roll UNIQUE (institution_id, roll_number),
    CONSTRAINT uq_student_profiles_reg UNIQUE (institution_id, registration_number),
    CONSTRAINT chk_cgpa CHECK (
        cgpa >= 0.00
        AND cgpa <= 10.00
    )
);
COMMENT ON TABLE student_profiles IS '1:1 academic domain profile extension for students';
-- ========== 10. faculty_profiles ==========
CREATE TABLE faculty_profiles (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL,
    institution_id UUID NOT NULL,
    department_id UUID NOT NULL,
    employee_id VARCHAR(50) NOT NULL,
    designation faculty_designation_enum NOT NULL DEFAULT 'ASSISTANT_PROFESSOR',
    employment_status employment_status_enum NOT NULL DEFAULT 'ACTIVE',
    faculty_type faculty_type_enum NOT NULL DEFAULT 'FULL_TIME',
    qualification VARCHAR(255) NULL,
    specialization TEXT NULL,
    office_location VARCHAR(100) NULL,
    office_hours JSONB NOT NULL DEFAULT '{}',
    biography TEXT NULL,
    joined_at DATE NOT NULL,
    is_department_head BOOLEAN NOT NULL DEFAULT FALSE,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_faculty_profiles_user UNIQUE (user_id),
    CONSTRAINT uq_faculty_profiles_employee UNIQUE (institution_id, employee_id)
);
COMMENT ON TABLE faculty_profiles IS '1:1 professional academic profile extension for faculty';
-- ========== 11. admin_profiles ==========
CREATE TABLE admin_profiles (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL,
    institution_id UUID NULL,
    department_id UUID NULL,
    admin_level admin_level_enum NOT NULL DEFAULT 'DEPARTMENT_ADMIN',
    clearance_tier clearance_tier_enum NOT NULL DEFAULT 'TIER_1_STANDARD',
    designation VARCHAR(100) NOT NULL,
    office_location VARCHAR(100) NULL,
    emergency_contact VARCHAR(20) NULL,
    requires_mfa_override BOOLEAN NOT NULL DEFAULT TRUE,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_admin_profiles_user UNIQUE (user_id)
);
COMMENT ON TABLE admin_profiles IS '1:1 administrative profile extension for registrars, IT leads, super-admins';