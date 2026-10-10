-- ============================================================
-- Module 8 - Gamification
-- 04_foreign_keys.sql
-- ============================================================
-- user_progression
ALTER TABLE user_progression
ADD CONSTRAINT fk_user_progression_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_user_progression_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_user_progression_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- study_streaks
ALTER TABLE study_streaks
ADD CONSTRAINT fk_study_streaks_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_study_streaks_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_study_streaks_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- achievements
ALTER TABLE achievements
ADD CONSTRAINT fk_achievements_badge FOREIGN KEY (badge_id) REFERENCES badges(id),
    ADD CONSTRAINT fk_achievements_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_achievements_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- user_achievements
ALTER TABLE user_achievements
ADD CONSTRAINT fk_user_achievements_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_user_achievements_achievement FOREIGN KEY (achievement_id) REFERENCES achievements(id),
    ADD CONSTRAINT fk_user_achievements_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_user_achievements_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- badges
ALTER TABLE badges
ADD CONSTRAINT fk_badges_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_badges_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- unit_stars
ALTER TABLE unit_stars
ADD CONSTRAINT fk_unit_stars_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_unit_stars_subject FOREIGN KEY (subject_id) REFERENCES subjects(id),
    ADD CONSTRAINT fk_unit_stars_unit FOREIGN KEY (unit_id) REFERENCES units(id),
    ADD CONSTRAINT fk_unit_stars_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_unit_stars_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- leaderboards
ALTER TABLE leaderboards
ADD CONSTRAINT fk_leaderboards_department FOREIGN KEY (department_id) REFERENCES departments(id),
    ADD CONSTRAINT fk_leaderboards_subject FOREIGN KEY (subject_id) REFERENCES subjects(id),
    ADD CONSTRAINT fk_leaderboards_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_leaderboards_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- leaderboard_entries
ALTER TABLE leaderboard_entries
ADD CONSTRAINT fk_leaderboard_entries_leaderboard FOREIGN KEY (leaderboard_id) REFERENCES leaderboards(id),
    ADD CONSTRAINT fk_leaderboard_entries_user FOREIGN KEY (user_id) REFERENCES users(id);