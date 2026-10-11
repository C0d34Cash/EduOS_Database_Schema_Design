-- ============================================================
-- Module 12 - Administration
-- 01_enums.sql
-- ============================================================
CREATE TYPE audit_action_enum AS ENUM (
    'CREATE',
    'READ',
    'UPDATE',
    'DELETE',
    'LOGIN',
    'LOGOUT',
    'EXPORT',
    'IMPORT',
    'APPROVE',
    'REJECT',
    'OTHER'
);
CREATE TYPE ocr_queue_status_enum AS ENUM (
    'QUEUED',
    'PROCESSING',
    'COMPLETED',
    'FAILED',
    'CANCELLED',
    'RETRYING'
);
CREATE TYPE feature_flag_status_enum AS ENUM (
    'ENABLED',
    'DISABLED',
    'BETA',
    'DEPRECATED'
);
CREATE TYPE config_data_type_enum AS ENUM (
    'STRING',
    'INTEGER',
    'BOOLEAN',
    'JSON',
    'FLOAT'
);