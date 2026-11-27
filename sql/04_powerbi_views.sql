-- 04_powerbi_views.sql
-- Import these views into Power BI. They are pre-aggregated at safe grains.

CREATE OR REPLACE VIEW vw_market_overview AS
SELECT
    COUNT(*) AS total_postings,
    COUNT(*) FILTER (WHERE is_entry_level) AS entry_level_postings,
    ROUND(100.0 * COUNT(*) FILTER (WHERE is_entry_level) / NULLIF(COUNT(*),0), 2) AS entry_level_share_pct,
    ROUND(AVG(salary_lpa), 2) AS avg_salary_lpa,
    ROUND((PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary_lpa))::numeric, 2) AS median_salary_lpa
FROM job_postings;

CREATE OR REPLACE VIEW vw_role_demand AS
SELECT job_title, department, COUNT(*) AS posting_count,
       COUNT(*) FILTER (WHERE is_entry_level) AS entry_level_postings,
       ROUND(AVG(salary_lpa),2) AS avg_salary_lpa
FROM job_postings
GROUP BY job_title, department;

CREATE OR REPLACE VIEW vw_skill_demand AS
SELECT s.skill,
       COUNT(DISTINCT s.job_id) AS jobs_mentioning_skill,
       COUNT(DISTINCT s.job_id) FILTER (WHERE j.is_entry_level) AS entry_level_jobs
FROM job_skills s
JOIN job_postings j USING (job_id)
GROUP BY s.skill;

CREATE OR REPLACE VIEW vw_salary_by_experience AS
SELECT experience_level, COUNT(*) AS posting_count,
       ROUND(AVG(salary_lpa),2) AS avg_salary_lpa,
       ROUND((PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary_lpa))::numeric,2) AS median_salary_lpa
FROM job_postings
GROUP BY experience_level;

CREATE OR REPLACE VIEW vw_location_workmode AS
SELECT location, work_mode, COUNT(*) AS posting_count,
       COUNT(*) FILTER (WHERE is_entry_level) AS entry_level_postings,
       ROUND(AVG(salary_lpa),2) AS avg_salary_lpa
FROM job_postings
GROUP BY location, work_mode;
