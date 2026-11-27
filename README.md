# Startup Job Market & Skill Demand Intelligence

An end-to-end data analytics project that explores startup hiring trends, technical skill demand, entry-level opportunities, and salary patterns using PostgreSQL, SQL, and Power BI.

## Project Overview

The technology job market is constantly evolving. Understanding which technical skills companies look for, what experience they expect, and where opportunities are concentrated can help job seekers make better career decisions.

This project analyzes a dataset of **1,200 simulated startup job postings** to uncover patterns in job demand, technical skills, experience requirements, salary distributions, and work arrangements.

The goal is to transform raw job-posting data into meaningful insights through SQL analysis and interactive Power BI dashboards.

## Business Objectives

- Identify the most frequently advertised job roles across startups.
- Discover the most in-demand technical skills.
- Analyze entry-level and fresher hiring opportunities.
- Understand experience requirements across different job roles.
- Compare salary distributions across roles and experience levels.
- Explore job opportunities across different Indian cities.
- Analyze remote, hybrid, and on-site work arrangements.
- Identify technical skills that frequently appear together.

## Technology Stack

| Technology | Purpose |
|---|---|
| PostgreSQL | Relational database management |
| SQL | Data cleaning, exploration, and analysis |
| Power BI | Interactive dashboards and visualization |
| CSV | Dataset storage and data exchange |

## Dataset

The project contains two primary datasets:

**1. Job Postings (`job_postings.csv`)**

Contains 1,200 simulated job records with information such as:

- Job ID and company
- Job title and department
- Location and work mode
- Employment type
- Experience level and minimum experience
- Salary in INR (LPA)
- Posting date
- Entry-level classification

**2. Job Skills (`job_skills.csv`)**

Contains job-to-skill relationships, connecting individual job postings with the technical and professional skills associated with them.

The datasets are structured relationally to support accurate SQL joins and skill-level analysis.

## SQL Analysis

PostgreSQL is used to perform business-oriented analysis through:

- Data quality checks and validation
- Joins and aggregations
- Common Table Expressions (CTEs)
- Window functions and ranking
- Conditional aggregation
- Salary analysis using average and median
- Skill frequency and demand analysis
- Location-wise and experience-wise comparisons
- SQL views for Power BI reporting

## Power BI Dashboard

The analysis is organized into three dashboard sections:

### 1. Market Overview
- Total job postings
- Entry-level hiring percentage
- Most frequently advertised job roles
- Job distribution across locations
- Work-mode distribution

### 2. Skills Intelligence
- Most frequently mentioned technical skills
- Entry-level skill demand
- Skill distribution across job roles
- Frequently co-occurring skills

### 3. Compensation & Geography
- Average and median salary by experience level
- Salary comparison across job roles
- Location-wise job distribution
- Work-mode analysis across locations

## Key Business Questions

This project focuses on answering practical questions:

1. Which technical skills appear most frequently in startup job descriptions?
2. How many opportunities are available for entry-level candidates?
3. Which job roles have a higher proportion of fresher opportunities?
4. How does salary change with experience?
5. Which locations have the highest number of job postings?
6. What skills are commonly requested together?
7. Which work arrangement is most common across different experience levels?

## Project Structure

```text
startup-job-market-intelligence/
│
├── data/
│   ├── job_postings.csv
│   ├── job_skills.csv
│   └── data_dictionary.csv
│
├── sql/
│   ├── 01_schema_and_load.sql
│   ├── 02_data_quality_checks.sql
│   ├── 03_business_analysis.sql
│   └── 04_powerbi_views.sql
│
├── powerbi/
│   └── dashboard_build_guide.md
│
├── docs/
│   └── insights_template.md
│
├── LICENSE
└── README.md
```

## Project Outcome

The project demonstrates how raw job-posting data can be transformed into structured information for business analysis.

It combines database design, SQL querying, analytical thinking, and data visualization to explore hiring patterns and technical skill requirements.

It also demonstrates the use of relational data modeling and analytical reporting to support data-driven career and workforce insights.

## Dataset Disclaimer

This project currently uses a **synthetic (simulated) dataset** generated for educational and portfolio purposes.

Company names, job postings, salaries, and dates do not represent actual market observations. The results should not be interpreted as verified Indian startup hiring trends or salary benchmarks.

---

**Author:** Sarth Bhausaheb Mali  
**Technologies:** PostgreSQL | SQL | Power BI  
**Project Category:** Data Analytics
