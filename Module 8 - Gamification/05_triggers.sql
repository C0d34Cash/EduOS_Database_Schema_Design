-- ============================================================
-- Module 8 - Gamification
-- 05_triggers.sql
-- ============================================================
CREATE TRIGGER trg_user_progression_updated_at BEFORE
UPDATE ON user_progression FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_study_streaks_updated_at BEFORE
UPDATE ON study_streaks FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_achievements_updated_at BEFORE
UPDATE ON achievements FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_user_achievements_updated_at BEFORE
UPDATE ON user_achievements FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_badges_updated_at BEFORE
UPDATE ON badges FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_unit_stars_updated_at BEFORE
UPDATE ON unit_stars FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_leaderboards_updated_at BEFORE
UPDATE ON leaderboards FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trg_leaderboard_entries_updated_at BEFORE
UPDATE ON leaderboard_entries FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();