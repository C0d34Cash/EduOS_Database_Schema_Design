-- ============================================================
-- Module 11 - Notifications
-- 01_enums.sql
-- ============================================================
CREATE TYPE notification_channel_enum AS ENUM (
    'IN_APP',
    'EMAIL',
    'PUSH',
    'SMS',
    'WHATSAPP'
);
CREATE TYPE notification_type_enum AS ENUM (
    'SYSTEM',
    'ACADEMIC',
    'REMINDER',
    'ACHIEVEMENT',
    'QUIZ',
    'AI_TUTOR',
    'ANNOUNCEMENT',
    'SECURITY',
    'CUSTOM'
);
CREATE TYPE notification_priority_enum AS ENUM (
    'LOW',
    'NORMAL',
    'HIGH',
    'URGENT'
);
CREATE TYPE notification_status_enum AS ENUM (
    'PENDING',
    'SENT',
    'DELIVERED',
    'READ',
    'FAILED',
    'CANCELLED'
);
CREATE TYPE announcement_status_enum AS ENUM (
    'DRAFT',
    'SCHEDULED',
    'PUBLISHED',
    'EXPIRED',
    'ARCHIVED'
);
CREATE TYPE announcement_audience_enum AS ENUM (
    'ALL',
    'STUDENTS',
    'FACULTY',
    'ADMINS',
    'DEPARTMENT',
    'PROGRAM',
    'CUSTOM'
);