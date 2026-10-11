-- ============================================================
-- Module 10 - AI Study Planner
-- 04_foreign_keys.sql
-- ============================================================
-- ai_notes
ALTER TABLE ai_notes
ADD CONSTRAINT fk_ai_notes_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_ai_notes_subject FOREIGN KEY (subject_id) REFERENCES subjects(id),
    ADD CONSTRAINT fk_ai_notes_unit FOREIGN KEY (unit_id) REFERENCES units(id),
    ADD CONSTRAINT fk_ai_notes_topic FOREIGN KEY (topic_id) REFERENCES syllabus_topics(id),
    ADD CONSTRAINT fk_ai_notes_resource FOREIGN KEY (resource_id) REFERENCES resources(id),
    ADD CONSTRAINT fk_ai_notes_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_ai_notes_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- flashcard_decks
ALTER TABLE flashcard_decks
ADD CONSTRAINT fk_flashcard_decks_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_flashcard_decks_subject FOREIGN KEY (subject_id) REFERENCES subjects(id),
    ADD CONSTRAINT fk_flashcard_decks_unit FOREIGN KEY (unit_id) REFERENCES units(id),
    ADD CONSTRAINT fk_flashcard_decks_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_flashcard_decks_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- flashcards
ALTER TABLE flashcards
ADD CONSTRAINT fk_flashcards_deck FOREIGN KEY (deck_id) REFERENCES flashcard_decks(id),
    ADD CONSTRAINT fk_flashcards_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_flashcards_subject FOREIGN KEY (subject_id) REFERENCES subjects(id),
    ADD CONSTRAINT fk_flashcards_unit FOREIGN KEY (unit_id) REFERENCES units(id),
    ADD CONSTRAINT fk_flashcards_topic FOREIGN KEY (topic_id) REFERENCES syllabus_topics(id),
    ADD CONSTRAINT fk_flashcards_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_flashcards_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- Now we can add the missing FK from Module 9
ALTER TABLE flashcard_memory
ADD CONSTRAINT fk_flashcard_memory_flashcard FOREIGN KEY (flashcard_id) REFERENCES flashcards(id);
-- planner_schedules
ALTER TABLE planner_schedules
ADD CONSTRAINT fk_planner_schedules_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_planner_schedules_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_planner_schedules_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- planner_tasks
ALTER TABLE planner_tasks
ADD CONSTRAINT fk_planner_tasks_schedule FOREIGN KEY (schedule_id) REFERENCES planner_schedules(id),
    ADD CONSTRAINT fk_planner_tasks_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_planner_tasks_subject FOREIGN KEY (subject_id) REFERENCES subjects(id),
    ADD CONSTRAINT fk_planner_tasks_unit FOREIGN KEY (unit_id) REFERENCES units(id),
    ADD CONSTRAINT fk_planner_tasks_topic FOREIGN KEY (topic_id) REFERENCES syllabus_topics(id),
    ADD CONSTRAINT fk_planner_tasks_resource FOREIGN KEY (resource_id) REFERENCES resources(id),
    ADD CONSTRAINT fk_planner_tasks_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_planner_tasks_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);