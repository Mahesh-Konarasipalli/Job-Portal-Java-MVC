🚀 JobPortal: Full-Stack Career Platform
A comprehensive, role-based job portal application built using the Java MVC (Model-View-Controller) architecture. This platform bridges the gap between hiring managers and job seekers with a seamless, dynamic interface.

✨ Key Features
For Employers (Hiring Managers)
Job Management (CRUD): Post new job openings, update existing listings, or delete outdated ones.

Applicant Tracking: A dedicated dashboard to view everyone who has applied to their specific jobs, including applicant contact details.

Status Control: Toggle job listings between 'Active' and 'Inactive'.

For Job Seekers (Candidates)
Advanced Job Search: Filter jobs by specific locations or categories (IT, Finance, Marketing, etc.).

One-Click Apply: Quickly apply for jobs and prevent duplicate applications with built-in logic.

Application History: Track all previously applied jobs in a personal dashboard.

Profile Management: View and update personal information and account credentials.

🛠️ Tech Stack
Backend: Java (Servlets & JSP)

Database: MySQL

Build Tool: Maven

Frontend: Bootstrap 5, FontAwesome, HTML5, CSS3

Server: Apache Tomcat 10+

Architecture: MVC (Model-View-Controller)

📂 Database Schema
The project utilizes three primary relational tables:

user: Stores account details and roles (Employer/Seeker).

jobs: Stores job descriptions linked to the Employer's user_id.

applications: A bridge table linking user_id and job_id to track candidate interests.

