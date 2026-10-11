-- ============================================================
-- Module 11 - Notifications
-- 02_tables.sql
-- ============================================================
-- ========== 1. notification_templates ==========
CREATE TABLE notification_templates (
    id UUID PRIMARY KEY,
    institution_id UUID NULL,
    -- NULL = system-wide
    code VARCHAR(100) NOT NULL,
    name VARCHAR(150) NOT NULL,
    description TEXT NULL,
    notification_type notification_type_enum NOT NULL DEFAULT 'SYSTEM',
    channel notification_channel_enum NOT NULL DEFAULT 'IN_APP',
    subject_template VARCHAR(255) NULL,
    -- for email
    body_template TEXT NOT NULL,
    variables JSONB NOT NULL DEFAULT '[]',
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL,
    CONSTRAINT uq_notification_templates_code UNIQUE (code)
);
COMMENT ON TABLE notification_templates IS 'Reusable templates for notifications';
-- ========== 2. notifications ==========
CREATE TABLE notifications (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    user_id UUID NOT NULL,
    -- recipient
    template_id UUID NULL,
    notification_type notification_type_enum NOT NULL DEFAULT 'SYSTEM',
    channel notification_channel_enum NOT NULL DEFAULT 'IN_APP',
    priority notification_priority_enum NOT NULL DEFAULT 'NORMAL',
    status notification_status_enum NOT NULL DEFAULT 'PENDING',
    title VARCHAR(255) NOT NULL,
    body TEXT NOT NULL,
    action_url TEXT NULL,
    image_url TEXT NULL,
    data JSONB NOT NULL DEFAULT '{}',
    -- extra payload
    read_at TIMESTAMPTZ NULL,
    sent_at TIMESTAMPTZ NULL,
    delivered_at TIMESTAMPTZ NULL,
    failed_reason TEXT NULL,
    expires_at TIMESTAMPTZ NULL,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL
);
COMMENT ON TABLE notifications IS 'Individual notifications sent to users';
-- ========== 3. announcements ==========
CREATE TABLE announcements (
    id UUID PRIMARY KEY,
    institution_id UUID NOT NULL,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    summary TEXT NULL,
    status announcement_status_enum NOT NULL DEFAULT 'DRAFT',
    audience announcement_audience_enum NOT NULL DEFAULT 'ALL',
    department_id UUID NULL,
    program_id UUID NULL,
    priority notification_priority_enum NOT NULL DEFAULT 'NORMAL',
    is_pinned BOOLEAN NOT NULL DEFAULT FALSE,
    publish_at TIMESTAMPTZ NULL,
    expire_at TIMESTAMPTZ NULL,
    published_at TIMESTAMPTZ NULL,
    author_id UUID NULL,
    -- users.id
    view_count INTEGER NOT NULL DEFAULT 0,
    metadata JSONB NOT NULL DEFAULT '{}',
    version INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID NULL,
    updated_by UUID NULL,
    deleted_at TIMESTAMPTZ NULL
);
COMMENT ON TABLE announcements IS 'Institution-wide or targeted announcements';