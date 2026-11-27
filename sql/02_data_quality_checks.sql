-- 02_data_quality_checks.sql
-- Every query should return zero rows / expected counts where noted.

-- 1. Duplicate job IDs (should return no rows)
SELECT job_id, COUNT(*)
FROM job_postings
GROUP BY job_id
HAVING COUNT(*) > 1;

-- 2. Orphan skills (should return no rows because of the FK)
SELECT s.*
FROM job_skills s
LEFT JOIN job_postings j USING (job_id)
WHERE j.job_id IS NULL;

-- 3. Missing critical fields
SELECT *
FROM job_postings
WHERE company IS NULL OR job_title IS NULL OR posted_date IS NULL
   OR experience_level IS NULL OR location IS NULL;

-- 4. Check entry-level flag consistency (should return no rows)
SELECT job_id, experience_level, is_entry_level
FROM job_postings
WHERE is_entry_level <> (experience_level IN ('Intern','Fresher','Junior'));

-- 5. Domain/range checks
SELECT *
FROM job_postings
WHERE salary_lpa < 0 OR min_experience_years < 0
   OR work_mode NOT IN ('On-site','Hybrid','Remote');

-- 6. Row counts and coverage
SELECT
    (SELECT COUNT(*) FROM job_postings) AS posting_rows,
    (SELECT COUNT(DISTINCT job_id) FROM job_postings) AS distinct_jobs,
    (SELECT COUNT(*) FROM job_skills) AS job_skill_rows,
    (SELECT COUNT(DISTINCT skill) FROM job_skills) AS distinct_skills;

-- 7. Check duplicate normalized job-skill pairs (should return no rows)
SELECT job_id, LOWER(TRIM(skill)) AS normalized_skill, COUNT(*)
FROM job_skills
GROUP BY job_id, LOWER(TRIM(skill))
HAVING COUNT(*) > 1;
