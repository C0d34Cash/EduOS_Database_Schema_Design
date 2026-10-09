-- ============================================================
-- Module 6 - Assessment
-- 03_indexes.sql
-- ============================================================
-- question_bank
CREATE INDEX idx_question_bank_institution_id ON question_bank (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_question_bank_subject_id ON question_bank (subject_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_question_bank_unit_id ON question_bank (unit_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_question_bank_topic_id ON question_bank (topic_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_question_bank_type ON question_bank (question_type);
CREATE INDEX idx_question_bank_difficulty ON question_bank (difficulty_level);
CREATE INDEX idx_question_bank_status ON question_bank (status)
WHERE deleted_at IS NULL;
CREATE INDEX idx_question_bank_is_pyq ON question_bank (is_pyq)
WHERE is_pyq = TRUE;
-- question_options
CREATE INDEX idx_question_options_question_id ON question_options (question_id)
WHERE deleted_at IS NULL;
-- question_tags
CREATE INDEX idx_question_tags_question_id ON question_tags (question_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_question_tags_tag_id ON question_tags (tag_id)
WHERE deleted_at IS NULL;
-- pyqs
CREATE INDEX idx_pyqs_question_id ON pyqs (question_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_pyqs_exam_year ON pyqs (exam_year DESC);
CREATE INDEX idx_pyqs_exam_name ON pyqs (exam_name);
-- mock_tests
CREATE INDEX idx_mock_tests_institution_id ON mock_tests (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_mock_tests_subject_id ON mock_tests (subject_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_mock_tests_status ON mock_tests (status)
WHERE deleted_at IS NULL;
-- mock_test_questions
CREATE INDEX idx_mock_test_questions_test_id ON mock_test_questions (mock_test_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_mock_test_questions_question_id ON mock_test_questions (question_id)
WHERE deleted_at IS NULL;
-- quiz_attempts
CREATE INDEX idx_quiz_attempts_institution_id ON quiz_attempts (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_quiz_attempts_mock_test_id ON quiz_attempts (mock_test_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_quiz_attempts_user_id ON quiz_attempts (user_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_quiz_attempts_status ON quiz_attempts (status);
-- submission_answers
CREATE INDEX idx_submission_answers_attempt_id ON submission_answers (attempt_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_submission_answers_question_id ON submission_answers (question_id)
WHERE deleted_at IS NULL;