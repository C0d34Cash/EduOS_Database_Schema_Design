-- ============================================================
-- Module 8 - Gamification
-- 01_enums.sql
-- ============================================================
CREATE TYPE achievement_category_enum AS ENUM (
    'STUDY',
    'STREAK',
    'QUIZ',
    'PROGRESS',
    'SOCIAL',
    'SPECIAL',
    'MILESTONE'
);
CREATE TYPE achievement_rarity_enum AS ENUM (
    'COMMON',
    'UNCOMMON',
    'RARE',
    'EPIC',
    'LEGENDARY'
);
CREATE TYPE badge_type_enum AS ENUM (
    'BRONZE',
    'SILVER',
    'GOLD',
    'PLATINUM',
    'DIAMOND',
    'SPECIAL'
);
CREATE TYPE leaderboard_type_enum AS ENUM (
    'GLOBAL',
    'INSTITUTION',
    'DEPARTMENT',
    'SUBJECT',
    'WEEKLY',
    'MONTHLY',
    'ALL_TIME'
);
CREATE TYPE leaderboard_period_enum AS ENUM (
    'DAILY',
    'WEEKLY',
    'MONTHLY',
    'SEMESTER',
    'YEARLY',
    'ALL_TIME'
);