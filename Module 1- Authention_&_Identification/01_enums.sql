-- ============================================================
-- 01_enums.sql
-- EduOS Module 1 - Custom ENUM Types
-- ============================================================

CREATE TYPE user_status_enum AS ENUM (
    'PENDING_VERIFICATION',
    'ACTIVE',
    'SUSPENDED',
    'DEACTIVATED',
    'BANNED'
);

CREATE TYPE role_scope_enum AS ENUM (
    'GLOBAL',
    'INSTITUTION',
    'DEPARTMENT'
);

CREATE TYPE role_status_enum AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'DEPRECATED'
);

CREATE TYPE permission_scope_enum AS ENUM (
    'GLOBAL',
    'INSTITUTION',
    'DEPARTMENT'
);

CREATE TYPE permission_status_enum AS ENUM (
    'ACTIVE',
    'DEPRECATED',
    'DISABLED'
);

CREATE TYPE role_permission_grant_enum AS ENUM (
    'ALLOW',
    'DENY'
);

CREATE TYPE auth_provider_type_enum AS ENUM (
    'PASSWORD',
    'GOOGLE_OAUTH',
    'MICROSOFT_OAUTH',
    'SAML',
    'APPLE',
    'GITHUB',
    'CUSTOM'
);

CREATE TYPE session_status_enum AS ENUM (
    'ACTIVE',
    'LOGGED_OUT',
    'REVOKED',
    'EXPIRED'
);

CREATE TYPE session_type_enum AS ENUM (
    'WEB',
    'MOBILE',
    'API',
    'DESKTOP'
);

CREATE TYPE mfa_method_enum AS ENUM (
    'NONE',
    'TOTP',
    'SMS',
    'EMAIL',
    'HARDWARE_KEY',
    'BACKUP_CODE'
);

CREATE TYPE session_revocation_reason_enum AS ENUM (
    'USER_LOGOUT',
    'ADMIN_FORCE',
    'SECURITY_RISK',
    'TOKEN_COMPROMISE',
    'PASSWORD_CHANGE',
    'MFA_RESET',
    'INACTIVITY'
);

CREATE TYPE login_status_enum AS ENUM (
    'SUCCESS',
    'FAILED',
    'BLOCKED',
    'MFA_REQUIRED',
    'MFA_FAILED'
);

CREATE TYPE login_failure_code_enum AS ENUM (
    'NONE',
    'INVALID_CREDENTIALS',
    'ACCOUNT_LOCKED',
    'ACCOUNT_SUSPENDED',
    'EMAIL_NOT_VERIFIED',
    'MFA_FAILED',
    'IP_BLOCKED',
    'RATE_LIMITED',
    'UNKNOWN'
);

CREATE TYPE login_source_enum AS ENUM (
    'WEB',
    'ANDROID',
    'IOS',
    'API',
    'DESKTOP'
);

CREATE TYPE academic_status_enum AS ENUM (
    'ACTIVE',
    'ON_LEAVE',
    'GRADUATED',
    'DROPPED',
    'SUSPENDED'
);

CREATE TYPE enrollment_type_enum AS ENUM (
    'REGULAR',
    'LATERAL_ENTRY',
    'TRANSFER',
    'RE_ADMISSION'
);

CREATE TYPE faculty_designation_enum AS ENUM (
    'PROFESSOR',
    'ASSOCIATE_PROFESSOR',
    'ASSISTANT_PROFESSOR',
    'LECTURER',
    'VISITING_FACULTY',
    'ADJUNCT'
);

CREATE TYPE employment_status_enum AS ENUM (
    'ACTIVE',
    'ON_LEAVE',
    'RESIGNED',
    'RETIRED',
    'TERMINATED'
);

CREATE TYPE faculty_type_enum AS ENUM (
    'FULL_TIME',
    'PART_TIME',
    'VISITING',
    'CONTRACT'
);

CREATE TYPE admin_level_enum AS ENUM (
    'SUPER_ADMIN',
    'INSTITUTION_ADMIN',
    'DEPARTMENT_ADMIN',
    'REGISTRAR',
    'IT_ADMIN'
);

CREATE TYPE clearance_tier_enum AS ENUM (
    'TIER_1_STANDARD',
    'TIER_2_ELEVATED',
    'TIER_3_HIGH',
    'TIER_4_CRITICAL'
);