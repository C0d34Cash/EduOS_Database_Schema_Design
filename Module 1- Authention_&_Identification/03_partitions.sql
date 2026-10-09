-- ============================================================
-- 03_partitions.sql
-- EduOS Module 1 - login_history Monthly Partitions
-- ============================================================
-- Create partitions for recent + upcoming months
-- Extend this file or use pg_partman for automatic management
CREATE TABLE login_history_2025_10 PARTITION OF login_history FOR
VALUES
FROM ('2025-10-01') TO ('2025-11-01');
CREATE TABLE login_history_2025_11 PARTITION OF login_history FOR
VALUES
FROM ('2025-11-01') TO ('2025-12-01');
CREATE TABLE login_history_2025_12 PARTITION OF login_history FOR
VALUES
FROM ('2025-12-01') TO ('2026-01-01');
CREATE TABLE login_history_2026_01 PARTITION OF login_history FOR
VALUES
FROM ('2026-01-01') TO ('2026-02-01');
CREATE TABLE login_history_2026_02 PARTITION OF login_history FOR
VALUES
FROM ('2026-02-01') TO ('2026-03-01');
CREATE TABLE login_history_2026_03 PARTITION OF login_history FOR
VALUES
FROM ('2026-03-01') TO ('2026-04-01');
-- Add more partitions as needed