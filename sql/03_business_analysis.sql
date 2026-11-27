-- 03_business_analysis.sql
-- Run each section independently to explore the business questions.

-- Q1. Overall market snapshot
SELECT
    COUNT(*) AS total_postings,
    COUNT(*) FILTER (WHERE is_entry_level) AS entry_level_postings,
    ROUND(100.0 * COUNT(*) FILTER (WHERE is_entry_level) / NULLIF(COUNT(*),0), 1) AS entry_level_pct,
    ROUND(AVG(salary_lpa), 2) AS avg_salary_lpa,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary_lpa) AS median_salary_lpa
FROM job_postings;

-- Q2. Most frequently advertised job titles
SELECT job_title, COUNT(*) AS posting_count,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS share_pct
FROM job_postings
GROUP BY job_title
ORDER BY posting_count DESC;

-- Q3. Top technical skills overall (distinct jobs)
SELECT skill, COUNT(DISTINCT job_id) AS jobs_mentioning_skill
FROM job_skills
GROUP BY skill
ORDER BY jobs_mentioning_skill DESC, skill
LIMIT 20;

-- Q4. Skills most common in entry-level roles
SELECT s.skill, COUNT(DISTINCT j.job_id) AS entry_level_jobs
FROM job_postings j
JOIN job_skills s USING (job_id)
WHERE j.is_entry_level
GROUP BY s.skill
ORDER BY entry_level_jobs DESC, s.skill
LIMIT 20;

-- Q5. Entry-level share by role
SELECT job_title,
       COUNT(*) AS total_postings,
       COUNT(*) FILTER (WHERE is_entry_level) AS entry_level_postings,
       ROUND(100.0 * COUNT(*) FILTER (WHERE is_entry_level) / COUNT(*), 1) AS entry_level_share_pct
FROM job_postings
GROUP BY job_title
ORDER BY entry_level_share_pct DESC, total_postings DESC;

-- Q6. Salary by experience level
SELECT experience_level,
       COUNT(*) AS posting_count,
       ROUND(AVG(salary_lpa), 2) AS avg_salary_lpa,
       ROUND((PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary_lpa))::numeric, 2) AS median_salary_lpa,
       ROUND(MIN(salary_lpa), 2) AS min_salary_lpa,
       ROUND(MAX(salary_lpa), 2) AS max_salary_lpa
FROM job_postings
GROUP BY experience_level
ORDER BY CASE experience_level
    WHEN 'Intern' THEN 1 WHEN 'Fresher' THEN 2 WHEN 'Junior' THEN 3
    WHEN 'Mid-level' THEN 4 ELSE 5 END;

-- Q7. Salary by job title and experience level
SELECT job_title, experience_level, COUNT(*) AS posting_count,
       ROUND(AVG(salary_lpa), 2) AS avg_salary_lpa
FROM job_postings
GROUP BY job_title, experience_level
HAVING COUNT(*) >= 5
ORDER BY job_title, avg_salary_lpa DESC;

-- Q8. City-level opportunity and salary comparison
SELECT location, COUNT(*) AS posting_count,
       COUNT(*) FILTER (WHERE is_entry_level) AS entry_level_count,
       ROUND(AVG(salary_lpa), 2) AS avg_salary_lpa
FROM job_postings
GROUP BY location
ORDER BY posting_count DESC;

-- Q9. Work-mode distribution by experience level
SELECT experience_level, work_mode, COUNT(*) AS posting_count
FROM job_postings
GROUP BY experience_level, work_mode
ORDER BY experience_level, posting_count DESC;

-- Q10. Skills that co-occur most often (self-join)
WITH pairs AS (
    SELECT a.skill AS skill_a, b.skill AS skill_b, COUNT(DISTINCT a.job_id) AS shared_jobs
    FROM job_skills a
    JOIN job_skills b
      ON a.job_id = b.job_id
     AND a.skill < b.skill
    GROUP BY a.skill, b.skill
)
SELECT *
FROM pairs
ORDER BY shared_jobs DESC, skill_a, skill_b
LIMIT 25;

-- Q11. Monthly posting trend
SELECT DATE_TRUNC('month', posted_date)::date AS posting_month,
       COUNT(*) AS posting_count,
       COUNT(*) FILTER (WHERE is_entry_level) AS entry_level_count
FROM job_postings
GROUP BY 1
ORDER BY 1;

-- Q12. Role ranking within each city using a window function
WITH role_city AS (
    SELECT location, job_title, COUNT(*) AS posting_count
    FROM job_postings
    GROUP BY location, job_title
)
SELECT location, job_title, posting_count,
       DENSE_RANK() OVER (PARTITION BY location ORDER BY posting_count DESC) AS role_rank
FROM role_city
ORDER BY location, role_rank, job_title;

-- Q13. Entry-level salary distribution by role
SELECT job_title, COUNT(*) AS entry_level_jobs,
       ROUND(AVG(salary_lpa), 2) AS avg_salary_lpa,
       ROUND((PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary_lpa))::numeric, 2) AS median_salary_lpa
FROM job_postings
WHERE is_entry_level
GROUP BY job_title
ORDER BY entry_level_jobs DESC;
