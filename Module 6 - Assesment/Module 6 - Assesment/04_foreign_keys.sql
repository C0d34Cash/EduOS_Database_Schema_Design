-- ============================================================
-- Module 6 - Assessment
-- 04_foreign_keys.sql
-- ============================================================
-- question_bank
ALTER TABLE question_bank
ADD CONSTRAINT fk_question_bank_subject FOREIGN KEY (subject_id) REFERENCES subjects(id),
    ADD CONSTRAINT fk_question_bank_unit FOREIGN KEY (unit_id) REFERENCES units(id),
    ADD CONSTRAINT fk_question_bank_topic FOREIGN KEY (topic_id) REFERENCES syllabus_topics(id),
    ADD CONSTRAINT fk_question_bank_difficulty FOREIGN KEY (difficulty_id) REFERENCES question_difficulty(id),
    ADD CONSTRAINT fk_question_bank_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_question_bank_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- question_options
ALTER TABLE question_options
ADD CONSTRAINT fk_question_options_question FOREIGN KEY (question_id) REFERENCES question_bank(id),
    ADD CONSTRAINT fk_question_options_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_question_options_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- question_tags
ALTER TABLE question_tags
ADD CONSTRAINT fk_question_tags_question FOREIGN KEY (question_id) REFERENCES question_bank(id),
    ADD CONSTRAINT fk_question_tags_tag FOREIGN KEY (tag_id) REFERENCES tags(id),
    ADD CONSTRAINT fk_question_tags_created_by FOREIGN KEY (created_by) REFERENCES users(id);
-- pyqs
ALTER TABLE pyqs
ADD CONSTRAINT fk_pyqs_question FOREIGN KEY (question_id) REFERENCES question_bank(id),
    ADD CONSTRAINT fk_pyqs_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_pyqs_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- mock_tests
ALTER TABLE mock_tests
ADD CONSTRAINT fk_mock_tests_subject FOREIGN KEY (subject_id) REFERENCES subjects(id),
    ADD CONSTRAINT fk_mock_tests_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_mock_tests_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- mock_test_questions
ALTER TABLE mock_test_questions
ADD CONSTRAINT fk_mock_test_questions_test FOREIGN KEY (mock_test_id) REFERENCES mock_tests(id),
    ADD CONSTRAINT fk_mock_test_questions_question FOREIGN KEY (question_id) REFERENCES question_bank(id),
    ADD CONSTRAINT fk_mock_test_questions_created_by FOREIGN KEY (created_by) REFERENCES users(id);
-- quiz_attempts
ALTER TABLE quiz_attempts
ADD CONSTRAINT fk_quiz_attempts_mock_test FOREIGN KEY (mock_test_id) REFERENCES mock_tests(id),
    ADD CONSTRAINT fk_quiz_attempts_user FOREIGN KEY (user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_quiz_attempts_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_quiz_attempts_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- submission_answers
ALTER TABLE submission_answers
ADD CONSTRAINT fk_submission_answers_attempt FOREIGN KEY (attempt_id) REFERENCES quiz_attempts(id),
    ADD CONSTRAINT fk_submission_answers_question FOREIGN KEY (question_id) REFERENCES question_bank(id),
    ADD CONSTRAINT fk_submission_answers_evaluator FOREIGN KEY (evaluator_id) REFERENCES users(id),
    ADD CONSTRAINT fk_submission_answers_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_submission_answers_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);