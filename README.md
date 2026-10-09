# EduOS Database Schema

Production-ready **PostgreSQL** database schema for **EduOS** — a multi-tenant, AI-powered Education Operating System built for engineering colleges and universities.

This repository contains the complete database design across **12 modular domains**, engineered for scalability, security, performance, and deep AI integration.

---

## Overview

EduOS Database is designed as a modern, modular, and future-proof foundation for an intelligent learning platform. It supports:

- Multi-tenancy (Institution-level isolation)
- Hierarchical Academic Structure
- AI Tutor & Study Planner
- Advanced Assessment Engine
- Learning Progress Tracking
- Gamification
- Analytics & Recommendations
- OCR + Knowledge Graph
- Robust Authentication & Authorization

---

## Architecture Highlights

- **UUIDv7** primary keys (time-ordered)
- **Multi-tenant** design (`institution_id` everywhere)
- **Soft Deletes** (`deleted_at`)
- **Optimistic Locking** (`version`)
- Complete **Audit Trail** (`created_at`, `updated_at`, `created_by`, `updated_by`)
- Heavy use of **ENUMs**, **JSONB**, and **GIN indexes**
- Range Partitioning for high-volume tables
- Clean modular separation (easy to maintain & scale)

---

## Modules

| #  | Module                        | Key Entities                                      | Status      |
|----|-------------------------------|---------------------------------------------------|-------------|
| 1  | Authentication & Identity     | Users, Roles, Permissions, Sessions, Profiles     | Completed   |
| 2  | Academic Structure            | Departments, Programs, Academic Years, Semesters, Subjects, Units, Syllabus Topics | Completed   |
| 3  | Learning Resources            | Resources, PDFs, Videos, Web Resources, Tags      | Upcoming    |
| 4  | OCR & AI Knowledge            | OCR Documents, Pages, Text Chunks, Embeddings    | Upcoming    |
| 5  | AI Tutor                      | Chat Sessions, Messages, Prompt Templates, Token Usage | Upcoming |
| 6  | Assessment                    | Question Bank, Mock Tests, Quiz Attempts          | Upcoming    |
| 7  | Learning Progress             | Progress, Watch History, Reading History, Study Sessions | Upcoming |
| 8  | Gamification                  | Streaks, Achievements, Badges, Leaderboards       | Upcoming    |
| 9  | Analytics                     | Subject Mastery, Weak Topics, Recommendations      | Upcoming    |
| 10 | AI Study Planner              | AI Notes, Flashcards, Planner Schedules & Tasks   | Upcoming    |
| 11 | Notifications                 | Templates, Notifications, Announcements           | Upcoming    |
| 12 | Administration                | Audit Logs, Feature Flags, System Metrics, Configurations | Upcoming |

---

## Folder Structure

```text
eduos-database-schema/
├── Module-1-Authentication-Identity/
│   ├── 01_enums.sql
│   ├── 02_tables.sql
│   ├── 03_partitions.sql
│   ├── 04_indexes.sql
│   ├── 05_foreign_keys.sql
│   └── 06_triggers.sql
│
├── Module-2-Academic-Structure/
│   ├── 01_enums.sql
│   ├── 02_tables.sql
│   ├── 03_indexes.sql
│   ├── 04_foreign_keys.sql
│   └── 05_triggers.sql
│
├── Module-3-Learning-Resources/
├── Module-4-OCR-AI-Knowledge/
├── ...
└── Module-12-Administration/
