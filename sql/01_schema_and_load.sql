-- 01_schema_and_load.sql
-- PostgreSQL setup. Run while connected to database startup_job_market.

DROP TABLE IF EXISTS job_skills;
DROP TABLE IF EXISTS job_postings;

CREATE TABLE job_postings (
    job_id                 VARCHAR(20) PRIMARY KEY,
    company                VARCHAR(100) NOT NULL,
    job_title              VARCHAR(100) NOT NULL,
    department             VARCHAR(50) NOT NULL,
    location               VARCHAR(80) NOT NULL,
    work_mode              VARCHAR(20) NOT NULL CHECK (work_mode IN ('On-site','Hybrid','Remote')),
    employment_type        VARCHAR(20) NOT NULL CHECK (employment_type IN ('Full-time','Internship','Contract')),
    experience_level       VARCHAR(20) NOT NULL CHECK (experience_level IN ('Intern','Fresher','Junior','Mid-level','Senior')),
    min_experience_years   INTEGER NOT NULL CHECK (min_experience_years >= 0),
    salary_lpa             NUMERIC(6,2) CHECK (salary_lpa >= 0),
    currency               CHAR(3) NOT NULL DEFAULT 'INR',
    posted_date            DATE NOT NULL,
    is_entry_level         BOOLEAN NOT NULL,
    description            TEXT
);

CREATE TABLE job_skills (
    job_id VARCHAR(20) NOT NULL REFERENCES job_postings(job_id) ON DELETE CASCADE,
    skill  VARCHAR(80) NOT NULL,
    PRIMARY KEY (job_id, skill)
);

-- psql only: update paths to absolute paths on your computer.
-- Example Windows path: 'C:/Users/YourName/Downloads/startup-job-market-intelligence/data/job_postings.csv'
\copy job_postings FROM 'data/job_postings.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');
\copy job_skills FROM 'data/job_skills.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');

CREATE INDEX idx_jobs_posted_date ON job_postings(posted_date);
CREATE INDEX idx_jobs_location ON job_postings(location);
CREATE INDEX idx_jobs_experience ON job_postings(experience_level);
CREATE INDEX idx_skills_skill ON job_skills(skill);
