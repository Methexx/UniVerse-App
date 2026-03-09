# UniVerse — Project Architecture & Technical Documentation

## Table of Contents
1. [Project Overview](#1-project-overview)
2. [Problem Statement](#2-problem-statement)
3. [Business Objectives](#3-business-objectives)
4. [System Architecture](#4-system-architecture)
5. [Tech Stack](#5-tech-stack)
6. [Flutter App Architecture (MVVM)](#6-flutter-app-architecture-mvvm)
7. [Folder Structure](#7-folder-structure)
8. [Core Features](#8-core-features)
9. [User Roles](#9-user-roles)
10. [API Communication](#10-api-communication)
11. [AI / RAG System](#11-ai--rag-system)
12. [Security](#12-security)
13. [Project Timeline](#13-project-timeline)
14. [Risk Register](#14-risk-register)

---

## 1. Project Overview

**UniVerse** is an integrated, AI-assisted university communication platform designed for Sri Lankan higher education institutions. It combines secure messaging, AI-powered academic Q&A, complaint management, real-time push notifications, and QR-based attendance tracking into a unified mobile and web experience.

| Property | Value |
|---|---|
| Project Type | Undergraduate Computing Final Year Project |
| Development Period | October 2025 – April 2026 (6 months) |
| Target Users | Students, Lecturers, Administrators |
| Target Context | Sri Lankan Universities |
| Methodology | Agile (bi-weekly sprints) + Prototype-driven |
| Version Control | GitHub |

---

## 2. Problem Statement

- Fewer than **40% of Sri Lankan universities** have centralized communication platforms
- Staff and students rely on informal channels (WhatsApp, personal email)
- Academic staff waste significant time answering repetitive queries
- No systematic complaint tracking or audit trails
- Fragmented systems cause accountability gaps and hinder quality assurance

---

## 3. Business Objectives

| # | Objective | Target |
|---|---|---|
| 1 | Improve student satisfaction with communication | +15% within 1 academic year |
| 2 | Reduce staff routine query time | -30% within 6 months |
| 3 | First-response time for queries | <24 hours in 85% of cases |
| 4 | Complaint resolution with audit trail | 90% within 10 working days |
| 5 | Reduce communication operational costs | -20% within 12 months |
| 6 | Support accreditation evidence requirements | Within first year of deployment |

---

## 4. System Architecture

### Three-Tier Client-Server Model

```
┌─────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                   │
│                                                         │
│   Flutter Mobile App          Next.js Web Dashboard     │
│   (Students)                  (Lecturers & Admins)      │
└──────────────────────┬──────────────────────────────────┘
                       │ REST API (HTTPS/TLS)
                       │ JWT Bearer Token
┌──────────────────────▼──────────────────────────────────┐
│                  APPLICATION LAYER                      │
│                                                         │
│              Node.js + Fastify Backend                  │
│                                                         │
│  ┌───────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐  │
│  │   Auth    │ │Messaging │ │Complaint │ │  Notif.  │  │
│  │  Service  │ │ Service  │ │ Service  │ │ Service  │  │
│  └───────────┘ └──────────┘ └──────────┘ └──────────┘  │
│  ┌───────────┐ ┌──────────┐                             │
│  │Attendance │ │  AI/RAG  │                             │
│  │  Service  │ │ Service  │                             │
│  └───────────┘ └──────────┘                             │
└──────────────────────┬──────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────┐
│                    DATA LAYER                           │
│                                                         │
│   Supabase (PostgreSQL + pgvector)                      │
│   - Users, Roles, Modules                               │
│   - Messages, Complaints, Attendance                    │
│   - Document embeddings (pgvector for RAG)              │
│   - AI conversation logs                                │
│                                                         │
│   External Services:                                    │
│   - Firebase Cloud Messaging (push notifications)       │
│   - OpenAI API / sentence-transformers (RAG/LLM)        │
└─────────────────────────────────────────────────────────┘
```

---

## 5. Tech Stack

### Flutter Mobile App
| Concern | Technology |
|---|---|
| Framework | Flutter (Dart) |
| Architecture | MVVM + Repository Pattern |
| State Management | Riverpod |
| HTTP Client | Dio |
| Token Storage | flutter_secure_storage |
| Push Notifications | firebase_messaging (FCM receiver only) |
| QR Scanning | mobile_scanner or qr_code_scanner |

### Web Dashboard
| Concern | Technology |
|---|---|
| Framework | Next.js (React) |
| Target Users | Lecturers, Administrators |
| Styling | TailwindCSS (recommended) |

### Backend
| Concern | Technology |
|---|---|
| Runtime | Node.js |
| Framework | **Fastify** |
| API Style | RESTful APIs |
| Authentication | JWT (JSON Web Tokens) |
| Password Hashing | bcrypt |
| Access Control | Role-Based (RBAC) |

### Database & Storage
| Concern | Technology |
|---|---|
| Primary Database | **Supabase** (PostgreSQL) |
| Vector Search (RAG) | pgvector extension via Supabase |
| Auth (backend) | Supabase Auth or custom JWT |
| File Storage | Supabase Storage (module PDFs) |

### External Services
| Service | Purpose |
|---|---|
| Firebase Cloud Messaging | Push notification delivery |
| OpenAI API / sentence-transformers | Text embedding for RAG |
| LLM API (OpenAI / other) | Generating AI Q&A responses |

---

## 6. Flutter App Architecture (MVVM)

### Pattern: MVVM + Repository

```
View (Flutter Widgets)
    │  observes state
    ▼
ViewModel (Riverpod Providers)
    │  calls
    ▼
Repository (feature-specific)
    │  calls
    ▼
API Client (Dio → Fastify REST API)
    +
FCM Service (Firebase push notification receiver)
```

### Key Principles
- **Views** contain zero business logic — only UI rendering and user input
- **ViewModels** (Riverpod providers) manage state and call repositories
- **Repositories** are the only layer that makes HTTP calls
- **Models** are plain Dart classes/freezed data classes
- **Services** wrap Firebase FCM and any other SDK integrations
- Flutter has **no direct database access** — everything goes through the Fastify REST API

---

## 7. Folder Structure

```
lib/
├── main.dart
├── app/
│   ├── app.dart                  # MaterialApp / routing setup
│   ├── router.dart               # GoRouter or auto_route config
│   └── theme.dart                # App-wide theme
│
├── models/                       # Pure Dart data classes
│   ├── user_model.dart
│   ├── message_model.dart
│   ├── complaint_model.dart
│   ├── announcement_model.dart
│   ├── attendance_model.dart
│   └── module_model.dart
│
├── repositories/                 # REST API call wrappers (per feature)
│   ├── auth_repository.dart
│   ├── message_repository.dart
│   ├── complaint_repository.dart
│   ├── announcement_repository.dart
│   ├── attendance_repository.dart
│   └── ai_repository.dart
│
├── viewmodels/                   # Riverpod providers (business logic + state)
│   ├── auth_viewmodel.dart
│   ├── message_viewmodel.dart
│   ├── complaint_viewmodel.dart
│   ├── announcement_viewmodel.dart
│   ├── attendance_viewmodel.dart
│   └── ai_viewmodel.dart
│
├── views/                        # Screens per feature
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   ├── home/
│   │   └── home_screen.dart
│   ├── messaging/
│   │   ├── inbox_screen.dart
│   │   └── conversation_screen.dart
│   ├── complaints/
│   │   ├── complaints_list_screen.dart
│   │   └── submit_complaint_screen.dart
│   ├── announcements/
│   │   └── announcements_screen.dart
│   ├── attendance/
│   │   └── qr_scan_screen.dart
│   ├── ai_qa/
│   │   └── ai_chat_screen.dart
│   └── widgets/                  # Shared reusable widgets
│       ├── custom_button.dart
│       ├── loading_indicator.dart
│       └── error_widget.dart
│
└── services/
    ├── api_client.dart           # Dio instance, base URL, JWT interceptor
    └── fcm_service.dart          # Firebase push notification receiver
```

---

## 8. Core Features

### 1. Secure University-Verified Authentication
- University email-based login
- JWT issued by Fastify backend
- Role-based access (Student / Lecturer / Admin)
- Token stored securely via `flutter_secure_storage`

### 2. AI-Powered Academic Q&A (RAG)
- Lecturers upload module PDFs via web dashboard
- Backend chunks and embeds PDFs using OpenAI text-embedding or sentence-transformers
- Embeddings stored in Supabase with pgvector
- Student query triggers vector similarity search → relevant chunks retrieved → LLM generates contextualized answer
- Target: ≥60% acceptable response accuracy (validated against lecturer test questions)

### 3. Two-Way Messaging
- Students send queries to lecturers/modules
- Lecturers respond via Next.js dashboard
- Full conversation history per module/lecturer

### 4. Complaint & Suggestion Management
- Students submit formal complaints or suggestions
- Full audit trail and status tracking
- 90% resolved within 10 working days target
- Admins manage and assign via web dashboard

### 5. Real-Time Push Notifications
- Firebase Cloud Messaging for delivery
- Triggered by backend (Fastify) on events: new message reply, complaint status update, announcement
- Flutter app receives and displays via `firebase_messaging`

### 6. QR Code Attendance Tracking
- Lecturers generate QR codes via web dashboard
- Students scan QR codes using the Flutter app
- Backend validates scan and logs attendance
- Admins view attendance analytics

### 7. Administrative Analytics Dashboard
- Web-only (Next.js)
- Communication pattern analytics
- Complaint resolution metrics
- Attendance reports
- Response time tracking

---

## 9. User Roles

| Role | Platform | Key Permissions |
|---|---|---|
| **Student** | Flutter Mobile App | Submit queries, view AI answers, submit complaints, scan QR, view announcements, receive notifications |
| **Lecturer** | Next.js Web Dashboard | Respond to messages, upload module PDFs, generate QR codes, publish announcements |
| **Administrator** | Next.js Web Dashboard | Manage complaints, view analytics, manage users, view attendance reports |

---

## 10. API Communication

### Flutter → Fastify Backend
- All communication via **HTTPS REST API**
- Base URL configured in `api_client.dart`
- JWT token attached to every request via Dio interceptor
- Dio handles: token refresh, error handling, timeouts

### API Endpoint Structure (example)
```
POST   /api/auth/login
POST   /api/auth/register
GET    /api/messages
POST   /api/messages
GET    /api/complaints
POST   /api/complaints
GET    /api/announcements
POST   /api/attendance/scan
POST   /api/ai/query
GET    /api/modules
```

---

## 11. AI / RAG System

```
Lecturer uploads PDF
        │
        ▼
Backend chunks document into segments
        │
        ▼
Each chunk embedded via OpenAI text-embedding-3-small
or sentence-transformers (open source alternative)
        │
        ▼
Embeddings stored in Supabase (pgvector)
        │
Student submits question
        │
        ▼
Question embedded → vector similarity search in pgvector
        │
        ▼
Top-K relevant chunks retrieved
        │
        ▼
LLM API called with: [system prompt + context chunks + student question]
        │
        ▼
Contextualized answer returned to student
```

**Accuracy target:** ≥60% on lecturer-validated test question sets

---

## 12. Security

| Concern | Implementation |
|---|---|
| Transport | HTTPS / TLS everywhere |
| Authentication | JWT (signed, expiring tokens) |
| Password storage | bcrypt hashing |
| Token storage (mobile) | flutter_secure_storage (Keychain / Keystore) |
| API access control | Role-based middleware in Fastify |
| Sensitive data | Never stored in plaintext or SharedPreferences |

---

## 13. Project Timeline

| Phase | Duration | Key Deliverables |
|---|---|---|
| Phase 0: Requirements & Design | Oct – Nov 2025 (8 weeks) | Requirements spec, system design, UI wireframes |
| Phase I: Core Development | Nov 2025 – mid-Jan 2026 | Auth, messaging, DB schema, base API |
| Phase II: Advanced Features | mid-Jan – mid-Mar 2026 | AI/RAG, FCM notifications, complaints, QR attendance |
| Testing | mid-Mar – early Apr 2026 (3 weeks) | Functional, performance (50-100 users), usability (10-20 users) |
| Documentation & Submission | Apr 2026 (3 weeks) | Final report, code cleanup, deployment package |

---

## 14. Risk Register

| Risk | Impact | Mitigation |
|---|---|---|
| Multi-tech integration complexity | High | Incremental development; core-first approach |
| Schedule delays | High | Phased milestones; Agile sprints; buffer in final phase |
| AI response accuracy <60% | Medium | RAG grounding; fallback for uncertain answers; lecturer-validated test set |
| Scope creep | Medium | Strict MVP; change control with supervisor approval |
| Limited test participants (10-20) | Medium | Synthetic data for validation; early ethical approval |
| Third-party API changes (OpenAI, Firebase) | Medium | Error handling; fallback mechanisms; monitor costs |
| Security vulnerabilities | High | HTTPS, bcrypt, JWT, RBAC, security testing |
| User adoption resistance | Medium | Intuitive UX; usability testing; onboarding documentation |

---

## Notes
- **Pilot scale:** 5-10 courses, 10-20 voluntary participants
- **Evaluation methods:** Functional testing, performance testing, usability assessment, AI accuracy metrics
- **No direct DB access from Flutter** — all data flows through Fastify REST API
- **Supabase replaces** standalone PostgreSQL + MongoDB (single managed platform)
- **Fastify replaces** Express.js (better performance, schema validation built-in)
