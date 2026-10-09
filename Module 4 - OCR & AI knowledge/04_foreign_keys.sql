-- ============================================================
-- Module 4 - OCR & AI Knowledge
-- 04_foreign_keys.sql
-- ============================================================
-- ocr_documents
ALTER TABLE ocr_documents
ADD CONSTRAINT fk_ocr_documents_resource FOREIGN KEY (resource_id) REFERENCES resources(id),
    ADD CONSTRAINT fk_ocr_documents_pdf FOREIGN KEY (pdf_document_id) REFERENCES pdf_documents(id),
    ADD CONSTRAINT fk_ocr_documents_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_ocr_documents_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- document_pages
ALTER TABLE document_pages
ADD CONSTRAINT fk_document_pages_ocr_document FOREIGN KEY (ocr_document_id) REFERENCES ocr_documents(id),
    ADD CONSTRAINT fk_document_pages_resource FOREIGN KEY (resource_id) REFERENCES resources(id),
    ADD CONSTRAINT fk_document_pages_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_document_pages_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- text_chunks
ALTER TABLE text_chunks
ADD CONSTRAINT fk_text_chunks_ocr_document FOREIGN KEY (ocr_document_id) REFERENCES ocr_documents(id),
    ADD CONSTRAINT fk_text_chunks_page FOREIGN KEY (document_page_id) REFERENCES document_pages(id),
    ADD CONSTRAINT fk_text_chunks_resource FOREIGN KEY (resource_id) REFERENCES resources(id),
    ADD CONSTRAINT fk_text_chunks_subject FOREIGN KEY (subject_id) REFERENCES subjects(id),
    ADD CONSTRAINT fk_text_chunks_unit FOREIGN KEY (unit_id) REFERENCES units(id),
    ADD CONSTRAINT fk_text_chunks_topic FOREIGN KEY (topic_id) REFERENCES syllabus_topics(id),
    ADD CONSTRAINT fk_text_chunks_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_text_chunks_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- embeddings
ALTER TABLE embeddings
ADD CONSTRAINT fk_embeddings_chunk FOREIGN KEY (chunk_id) REFERENCES text_chunks(id),
    ADD CONSTRAINT fk_embeddings_resource FOREIGN KEY (resource_id) REFERENCES resources(id),
    ADD CONSTRAINT fk_embeddings_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_embeddings_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);
-- citation_contexts
ALTER TABLE citation_contexts
ADD CONSTRAINT fk_citation_contexts_chunk FOREIGN KEY (chunk_id) REFERENCES text_chunks(id),
    ADD CONSTRAINT fk_citation_contexts_resource FOREIGN KEY (resource_id) REFERENCES resources(id),
    ADD CONSTRAINT fk_citation_contexts_created_by FOREIGN KEY (created_by) REFERENCES users(id),
    ADD CONSTRAINT fk_citation_contexts_updated_by FOREIGN KEY (updated_by) REFERENCES users(id);