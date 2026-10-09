-- ============================================================
-- Module 4 - OCR & AI Knowledge
-- 03_indexes.sql
-- ============================================================
-- ocr_documents
CREATE INDEX idx_ocr_documents_institution_id ON ocr_documents (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_ocr_documents_resource_id ON ocr_documents (resource_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_ocr_documents_status ON ocr_documents (status)
WHERE deleted_at IS NULL;
-- document_pages
CREATE INDEX idx_document_pages_ocr_document_id ON document_pages (ocr_document_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_document_pages_resource_id ON document_pages (resource_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_document_pages_page_number ON document_pages (ocr_document_id, page_number);
-- text_chunks
CREATE INDEX idx_text_chunks_institution_id ON text_chunks (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_text_chunks_ocr_document_id ON text_chunks (ocr_document_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_text_chunks_resource_id ON text_chunks (resource_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_text_chunks_subject_id ON text_chunks (subject_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_text_chunks_unit_id ON text_chunks (unit_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_text_chunks_topic_id ON text_chunks (topic_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_text_chunks_chunk_index ON text_chunks (resource_id, chunk_index);
-- embeddings
CREATE INDEX idx_embeddings_institution_id ON embeddings (institution_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_embeddings_chunk_id ON embeddings (chunk_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_embeddings_resource_id ON embeddings (resource_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_embeddings_model ON embeddings (model);
-- Vector similarity search index (pgvector)
-- CREATE INDEX idx_embeddings_vector ON embeddings USING hnsw (embedding vector_cosine_ops);
-- citation_contexts
CREATE INDEX idx_citation_contexts_chunk_id ON citation_contexts (chunk_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_citation_contexts_resource_id ON citation_contexts (resource_id)
WHERE deleted_at IS NULL;
CREATE INDEX idx_citation_contexts_chat_message ON citation_contexts (chat_message_id)
WHERE chat_message_id IS NOT NULL;