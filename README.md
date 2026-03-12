## 🚀 JobPortal: Full-Stack Career Platform

A comprehensive, role-based job portal application built using the Java MVC (Model-View-Controller) architecture. This platform bridges the gap between hiring managers and job seekers with a seamless, dynamic interface.

## ✨ Key Features

For Employers (Hiring Managers)
Job Management (CRUD): Post new job openings, update existing listings, or delete outdated ones.

Applicant Tracking: A dedicated dashboard to view everyone who has applied to their specific jobs, including applicant contact details.

Status Control: Toggle job listings between 'Active' and 'Inactive'.

For Job Seekers (Candidates)
Advanced Job Search: Filter jobs by specific locations or categories (IT, Finance, Marketing, etc.).

One-Click Apply: Quickly apply for jobs and prevent duplicate applications with built-in logic.

Application History: Track all previously applied jobs in a personal dashboard.

Profile Management: View and update personal information and account credentials.

## 🏗️ System Architecture (MVC Pattern)

The project follows the **Model-View-Controller (MVC)** design pattern to ensure a clean separation of concerns, making the code maintainable and scalable.

```mermaid
graph TD
    User((User Browser)) -->|Request| JSP[View: JSP Pages]
    JSP -->|Form Data| Servlet[Controller: Java Servlets]
    Servlet -->|Object| DAO[Data Access Object: DAO]
    DAO -->|SQL Query| MySQL[(Database: MySQL)]
    MySQL -->|ResultSet| DAO
    DAO -->|Entity Object| Servlet
    Servlet -->|Attribute| JSP
    JSP -->|HTML| User