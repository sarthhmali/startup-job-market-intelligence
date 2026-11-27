# Power BI dashboard build guide

## Connect
1. In Power BI Desktop, select **Get Data → PostgreSQL database**.
2. Enter your PostgreSQL server and database (`startup_job_market`).
3. Choose Import mode for a simple portfolio demo.
4. Select `job_postings`, `job_skills`, and the views created by `04_powerbi_views.sql`.
5. In Model view, create `job_postings[job_id]` (one) → `job_skills[job_id]` (many), single-direction filtering.

## Recommended measures (DAX)

```dax
Total Postings = DISTINCTCOUNT(job_postings[job_id])

Entry-Level Postings =
CALCULATE(
    [Total Postings],
    job_postings[is_entry_level] = TRUE()
)

Entry-Level Share =
DIVIDE([Entry-Level Postings], [Total Postings], 0)

Average Salary (LPA) =
AVERAGE(job_postings[salary_lpa])

Median Salary (LPA) =
MEDIAN(job_postings[salary_lpa])

Distinct Skills = DISTINCTCOUNT(job_skills[skill])
```

**Important:** When a visual uses fields from `job_skills`, use `DISTINCTCOUNT(job_postings[job_id])` for posting counts. A normal row count after joining skills will overcount jobs because each job can list multiple skills.

## Page 1 — Market overview
- KPI cards: Total Postings, Entry-Level Share, Median Salary (LPA).
- Bar chart: Posting Count by Job Title.
- Donut chart: Work Mode distribution.
- Line chart: Posting Count by month (`posted_date` hierarchy or a month column).
- Slicers: Location, Department, Experience Level, Employment Type.

## Page 2 — Skills intelligence
- Horizontal bar: Top 15 skills by distinct jobs mentioning skill.
- Clustered bar: Entry-Level Jobs vs All Jobs by skill.
- Matrix: Job Title × Skill with distinct posting count.
- Slicers: Job Title, Experience Level, Location.

## Page 3 — Compensation & geography
- Bar chart: Median Salary by Experience Level.
- Bar chart: Median Salary by Job Title.
- Map or bar chart: Posting Count by Location (bar chart is safer if map geocoding is unreliable).
- Stacked column: Work Mode by Location.
- Slicers: Job Title, Experience Level, Work Mode.

## Design rules
- Use a consistent 16:9 canvas.
- Keep a clear title and a small note: “Synthetic demonstration dataset — not actual job-market measurements.”
- Add tooltips for posting count and median salary.
- Avoid 3D charts and excessive colors.
- Include a small “Definitions & limitations” text panel.

## Publish screenshots
Save 2–3 clean dashboard screenshots under `powerbi/` only after you build the actual report. Do not commit a blank or fabricated `.pbix` file.
