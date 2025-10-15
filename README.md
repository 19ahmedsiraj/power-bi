# 📊 SQL Project: Data Analyst Job Market Insights

## 🧠 Introduction
The **Data Analyst Job Market Insights** project explores the demand, salary trends, and top skills required for Data Analyst roles using SQL.  
The goal of this project is to extract actionable insights from a structured dataset containing job postings, company information, and associated skills.  
Using **PostgreSQL** and **Visual Studio Code**, I wrote multiple SQL queries to uncover patterns about the Data Analytics job market — including the highest-paying roles, the most sought-after skills, and which tools influence salary levels.

---

## 📚 Background
With data analytics being one of the fastest-growing fields, companies across industries are hiring professionals who can turn data into insights.  
To understand this landscape, this project analyzes real-world job postings to answer key questions such as:
- What are the highest-paying Data Analyst jobs in Bengaluru and remote roles?
- Which skills are most in demand among Data Analyst positions?
- What skills lead to the highest average salaries?

The dataset used includes:
- Job details such as title, location, schedule, and salary.
- Company data.
- Skill sets linked to each job posting.

---

## ⚙️ Tools and Technologies Used
- **PostgreSQL** – For data querying, transformation, and analysis.
- **Visual Studio Code** – For writing and managing SQL queries.
- **GitHub** – For version control and project showcasing.
- **Dataset Tables:**
  - `job_postings_fact`
  - `company_dim`
  - `skills_dim`
  - `skills_job_dim`

---

## 🧩 SQL Queries and Analysis

### 🔹 Query 1: Top 10 High-Paying Data Analyst Jobs in Bengaluru
```sql
SELECT 
    jobs.job_id,
    job_title,
    company.name as company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM job_postings_fact as jobs 
LEFT JOIN company_dim as company 
    ON jobs.company_id = company.company_id
WHERE job_title_short = 'Data Analyst' 
  AND job_location LIKE '%Bengaluru%'
  AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```

## 🧾 Insight:

The highest-paying roles in Bengaluru are offered by companies like Bosch Group, Truecaller, and Razorpay.

Average salaries reach up to ₹16.5 LPA.

Most positions are Full-time, showing strong local job availability for Data Analysts.

### 🔹 Query 2: Skills for Top 10 Highest-Paying Remote Data Analyst Roles
```sql
WITH top_jobs AS (
    SELECT 
        jobs.job_id,
        job_title,
        company.name as company_name,
        salary_year_avg
    FROM job_postings_fact as jobs 
    LEFT JOIN company_dim as company 
        ON jobs.company_id = company.company_id
    WHERE job_title_short = 'Data Analyst' 
      AND job_location = 'Anywhere'
      AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT top_jobs.*, skills_dim.skills
FROM top_jobs 
INNER JOIN skills_job_dim ON top_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC;
```
## 🧾 Insight:

The top remote-paying role was Associate Director - Data Insights at AT&T, with an average salary of $255,829.

Key skills include SQL, Python, R, Azure, AWS, Databricks, PySpark, and Excel.

Cloud and data engineering skills are critical for higher salaries.

### 🔹 Query 3: Most In-Demand Skills for Data Analysts
```sql
SELECT skills, COUNT(skills_job_dim.job_id) as demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;
```
### 🧾 Insight:
Top 5 most requested skills:
| Skill    | Demand Count |
| -------- | ------------ |
| SQL      | 92,628       |
| Excel    | 67,031       |
| Python   | 57,326       |
| Tableau  | 46,554       |
| Power BI | 39,468       |

##### 💡 SQL and Excel remain the most fundamental tools for data analysis.

### 🔹 Query 4: Highest Paying Skills for Data Analysts
``` sql
SELECT skills, ROUND(AVG(salary_year_avg),2) as Average
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY Average DESC
LIMIT 25;
```
### 🧾 Insight:

* High-paying skills include SVN, Solidity, Couchbase, Datarobot, Golang, TensorFlow, and Airflow.

* Specialized technical and programming skills often command significantly higher salaries.

* This highlights the growing intersection between data analytics, machine learning, and software engineering.

### 🔹 Query 5: Top Paying Skills for Remote Data Analyst Roles
```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(salary_year_avg),2) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' 
  AND salary_year_avg IS NOT NULL
  AND job_work_from_home = TRUE
GROUP BY skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id)>10
ORDER BY average_salary DESC, demand_count DESC
LIMIT 25;
```
### 🧾 Insight:

* Highest-paying remote skills include Go, Snowflake, Azure, AWS, and Hadoop.

* Python, Tableau, and SAS continue to have strong demand.

* Combining data analysis with cloud and engineering knowledge leads to higher compensation.

### 📈 Key Findings

* Bengaluru is a strong hub for Data Analyst roles in India.

* SQL, Excel, Python, Tableau, and Power BI form the core analytics toolkit.

* Niche technologies like Airflow, Databricks, and Golang correlate with higher salaries.

* Cloud skills (AWS, Azure, Snowflake) are highly valued in remote roles.

### 💡 What I Learned

* How to write advanced SQL queries using joins, subqueries, CTEs, and aggregations.

* Analyzing real-world data to extract meaningful insights.

* Structuring SQL projects for professional documentation.

* How to combine technical querying with data storytelling for portfolio presentation.

### 🏁 Conclusion

This SQL-based project provided valuable insights into the Data Analyst job market — including pay trends, skill demand, and evolving technology preferences.

By leveraging PostgreSQL, I identified the most impactful skills that influence both demand and salary.
This analysis can guide both aspiring Data Analysts and organizations seeking to understand market expectations.
