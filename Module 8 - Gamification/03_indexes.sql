-- ============================================================
-- Module 8 - Gamification
-- 03_indexes.sql
-- ============================================================
-- user_progression
CREATE INDEX idx_user_progression_institution ON user_progression (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_user_progression_level ON user_progression (current_level DESC);
CREATE INDEX idx_user_progression_xp ON user_progression (total_xp DESC);
-- study_streaks
CREATE INDEX idx_study_streaks_user_id ON study_streaks (user_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_study_streaks_current ON study_streaks (current_streak DESC);
-- achievements
CREATE INDEX idx_achievements_category ON achievements (category)
WHERE deleted_at IS NULL;
CREATE INDEX idx_achievements_rarity ON achievements (rarity);
-- user_achievements
CREATE INDEX idx_user_achievements_user_id ON user_achievements (user_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_user_achievements_achievement_id ON user_achievements (achievement_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_user_achievements_unlocked_at ON user_achievements (unlocked_at DESC);
-- badges
CREATE INDEX idx_badges_type ON badges (badge_type)
WHERE deleted_at IS NULL;
-- unit_stars
CREATE INDEX idx_unit_stars_user_id ON unit_stars (user_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_unit_stars_unit_id ON unit_stars (unit_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_unit_stars_subject_id ON unit_stars (subject_id)
WHERE deleted_at IS NULL;
-- leaderboards
CREATE INDEX idx_leaderboards_institution ON leaderboards (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_leaderboards_type ON leaderboards (leaderboard_type);
CREATE INDEX idx_leaderboards_period ON leaderboards (period);
-- leaderboard_entries
CREATE INDEX idx_leaderboard_entries_leaderboard ON leaderboard_entries (leaderboard_id);
CREATE INDEX idx_leaderboard_entries_user ON leaderboard_entries (user_id);
CREATE INDEX idx_leaderboard_entries_rank ON leaderboard_entries (leaderboard_id, rank);