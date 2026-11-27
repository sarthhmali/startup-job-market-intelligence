# Startup Job Market & Skill Demand Intelligence

**Tools:** PostgreSQL, SQL, Power BI  
**Project type:** End-to-end analytics portfolio project  
**Dataset:** 1,200 simulated startup job postings + a normalized job-to-skill table

> **Important data note:** This repository uses a synthetic (simulated) dataset created for portfolio demonstration and reproducibility. Company names, job postings, dates, and salaries are not real market observations. Do not describe the results as a survey of actual employers. The analysis demonstrates a repeatable workflow that can be applied to a licensed/public real-world dataset.

## 1. Business problem

Early-career candidates often struggle to decide which technical skills to prioritize. Startup job descriptions contain signals about role demand, experience expectations, work arrangements, and compensation, but these signals are difficult to compare manually.

This project builds a small job-market intelligence model to answer:

1. Which job titles and technical skills appear most often?
2. What share of postings are entry-level?
3. Which skills are common in entry-level postings?
4. How do salary bands vary by role, experience level, and location?
5. Which cities and work modes have the highest posting volume?
6. Which combinations of skills frequently appear together?

## 2. Repository structure

```text
startup-job-market-intelligence/
├── data/
│   ├── job_postings.csv
│   ├── job_skills.csv
│   └── data_dictionary.csv
├── sql/
│   ├── 01_schema_and_load.sql
│   ├── 02_data_quality_checks.sql
│   ├── 03_business_analysis.sql
│   └── 04_powerbi_views.sql
├── powerbi/
│   └── dashboard_build_guide.md
├── docs/
│   └── insights_template.md
├── .gitignore
├── LICENSE
└── README.md
```

## 3. Data model

- `job_postings`: one row per posting; primary key is `job_id`.
- `job_skills`: one row per job-skill relationship; composite primary key `(job_id, skill)`; `job_id` references `job_postings`.

This is a one-to-many relationship from job postings to skills. Keeping skills in a separate table avoids storing comma-separated skill lists and makes skill-level analysis reliable.

## 4. How to run in PostgreSQL

### Option A — pgAdmin

1. Create a database named `startup_job_market`.
2. Open Query Tool for that database.
3. Run `sql/01_schema_and_load.sql` after updating the two CSV file paths to the absolute paths on your computer. PostgreSQL server-side `COPY` reads files from the database server machine. If that is inconvenient, use pgAdmin's Import/Export Data feature for each CSV after creating the tables.
4. Run `sql/02_data_quality_checks.sql`.
5. Run `sql/03_business_analysis.sql`.
6. Run `sql/04_powerbi_views.sql`.

### Option B — psql

Create the database, connect to it, then run the scripts in numerical order. Edit the `\copy` paths in `01_schema_and_load.sql` to match your local repository path. `\copy` is a psql client command and reads files from the computer running psql.

## 5. Power BI

Follow `powerbi/dashboard_build_guide.md` to connect Power BI Desktop to PostgreSQL, create the relationship, add measures, and build the dashboard.

Suggested dashboard pages:
- **Market Overview:** posting count, entry-level share, median salary, most common roles.
- **Skills Intelligence:** top skills overall and for entry-level roles.
- **Compensation & Geography:** salary by experience, role, and location; work-mode split.

## 6. Key analysis definitions

- **Entry-level:** Intern, Fresher, or Junior.
- **Posting count:** count of unique `job_id`, not count of rows after joining skills.
- **Skill demand:** count of distinct jobs that mention a skill.
- **Salary:** simulated annual salary in INR LPA. It is not verified compensation data.
- **Median salary:** median of the salary values in the filtered group; generally more robust than average for skewed salary distributions.

## 7. Portfolio talking points

Explain the project as an analytics workflow rather than claiming it predicts hiring:
- Designed a normalized relational schema for postings and skills.
- Used SQL joins, CTEs, conditional aggregation, window functions, and views.
- Defined entry-level demand and distinct-job skill frequency to avoid join fan-out errors.
- Built a Power BI dashboard for role, skill, salary, location, and work-mode exploration.
- Documented data limitations and reproducible setup steps.

## 8. How to make this a real-market project

For a stronger production portfolio version, replace the synthetic CSVs with job postings collected from a source whose terms explicitly permit reuse (for example, an open dataset with a clear license). Record the source URL, access date, license, collection period, and any cleaning steps. Keep the same schema and SQL. Do not scrape websites in ways that violate their terms, and do not imply that synthetic data is real.

## 9. Resume bullet (use only after you have built and understood the dashboard)

**Startup Job Market & Skill Demand Intelligence | PostgreSQL, SQL, Power BI**
- Built a normalized PostgreSQL analytics model covering 1,200 simulated startup job postings and job-skill relationships to examine role demand, entry-level hiring patterns, and compensation.
- Used CTEs, joins, window functions, and SQL views to rank in-demand skills, compare salary bands, and segment opportunities by experience, location, and work mode.
- Developed a Power BI dashboard with market, skills, and compensation views; documented data-quality checks and analytical definitions.

If you replace the synthetic dataset with a licensed real dataset, update the wording and cite the real source accurately.
