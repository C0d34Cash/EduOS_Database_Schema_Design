-- ============================================================
-- Module 10 - AI Study Planner
-- 03_indexes.sql
-- ============================================================
-- ai_notes
CREATE INDEX idx_ai_notes_user_id ON ai_notes (user_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_ai_notes_subject_id ON ai_notes (subject_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_ai_notes_status ON ai_notes (status)
WHERE deleted_at IS NULL;
CREATE INDEX idx_ai_notes_is_favorite ON ai_notes (is_favorite)
WHERE is_favorite = TRUE;
-- flashcard_decks
CREATE INDEX idx_flashcard_decks_user_id ON flashcard_decks (user_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_flashcard_decks_subject_id ON flashcard_decks (subject_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_flashcard_decks_visibility ON flashcard_decks (visibility);
-- flashcards
CREATE INDEX idx_flashcards_deck_id ON flashcards (deck_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_flashcards_user_id ON flashcards (user_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_flashcards_topic_id ON flashcards (topic_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_flashcards_status ON flashcards (status)
WHERE deleted_at IS NULL;
-- planner_schedules
CREATE INDEX idx_planner_schedules_user_id ON planner_schedules (user_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_planner_schedules_status ON planner_schedules (status)
WHERE deleted_at IS NULL;
CREATE INDEX idx_planner_schedules_dates ON planner_schedules (start_date, end_date);
-- planner_tasks
CREATE INDEX idx_planner_tasks_schedule_id ON planner_tasks (schedule_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_planner_tasks_user_id ON planner_tasks (user_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_planner_tasks_status ON planner_tasks (status)
WHERE deleted_at IS NULL;
CREATE INDEX idx_planner_tasks_due_date ON planner_tasks (due_date)
WHERE due_date IS NOT NULL;
CREATE INDEX idx_planner_tasks_priority ON planner_tasks (priority);