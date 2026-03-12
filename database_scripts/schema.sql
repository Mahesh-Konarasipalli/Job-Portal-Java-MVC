-- For creating user table in datebase 
CREATE TABLE user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100),
    role VARCHAR(20) -- 'seeker' or 'employer'
);

-- This assigns ALL existing orphaned jobs to the employer with ID 1
UPDATE jobs SET user_id = 1 WHERE user_id IS NULL OR user_id = 0;

-- For creating jobs table in database
CREATE TABLE jobs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200),
    description TEXT,
    category VARCHAR(100),
    status VARCHAR(50), -- 'Active' or 'Inactive'
    location VARCHAR(100),
    pdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Automatically track when it was posted
);

-- For create applications table in database
CREATE TABLE applications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    job_id INT,
    apply_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--