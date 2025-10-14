select AVG(salary_year_avg) as AverageYear, 
AVG(salary_hour_avg) as AverageHour,
job_schedule_type
from job_postings_fact
where job_posted_date>'2023-06-01'
GROUP BY job_schedule_type


SELECT COUNT(job_id) AS NO_OF_POSTING, 
EXTRACT(MONTH FROM(job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kolkata')) AS JOB_MONTH
FROM job_postings_fact
where EXTRACT(YEAR FROM(job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kolkata')) = 2023
GROUP BY JOB_MONTH
ORDER BY JOB_MONTH;


Select DISTINCT Company.name
From job_postings_fact AS Jobs LEFT JOIN company_dim AS Company ON Jobs.company_id = Company.company_id
where Jobs.job_health_insurance = TRUE AND EXTRACT(MONTH FROM job_posted_date) BETWEEN 4 AND 6
ORDER BY Company.name


CREATE TABLE February_Jobs AS
Select *
From job_postings_fact
where EXTRACT(MONTH FROM job_posted_date) = 2



Select * 
from March_Jobs


select salary_year_avg,
CASE 
    WHEN salary_year_avg < 100000 THEN 'LOW'
    WHEN salary_year_avg > 500000 THEN 'HIGH'
    ELSE 'STANDARD'
    END AS Salary_Category
    FROM job_postings_fact
    WHERE job_title_short = 'Data Analyst'
    ORDER BY salary_year_avg DESC

CREATE TABLE March_Jobs AS
Select *
From job_postings_fact
where EXTRACT(MONTH FROM job_posted_date) = 3



select 
company_id,name AS company_name
from company_dim
where company_id IN
(
select company_id
from job_postings_fact
where job_no_degree_mention = TRUE
order by company_id)



WITH jobs_count AS (
Select company_id, COUNT(*) AS jobscount
from job_postings_fact
GROUP BY company_id)

Select Company.name AS company_name, jobs_count.jobscount
from company_dim AS Company LEFT JOIN jobs_count ON Company.company_id = jobs_count.company_id
ORDER BY jobscount DESC


select *
from job_postings_fact
LIMIT 10



WITH skillsname AS (
select skill_id,COUNT(*) AS Skillscount
from skills_job_dim
GROUP BY skill_id
ORDER BY Skillscount DESC)
select skills_dim.skills AS Skill_Name, skillsname.Skillscount
from skills_dim LEFT JOIN skillsname ON skills_dim.skill_id = skillsname.skill_id
ORDER BY skillsname.Skillscount DESC
LIMIT 5




from job_postings_fact
GROUP by company_id



Select c.name AS company_name,
CASE
WHEN  j.company_id > 10 THEN 'SMALL'
WHEN  j.company_id BETWEEN 10 AND 50 THEN 'MEDIUM'
ELSE 'LARGE'
END AS Compnay_size
from company_dim c LEFT JOIN 
(
select company_id, COUNT(*) as jobsposting
from job_postings_fact
GROUP by company_id) j ON c.company_id=j.company_id;



select *
from skills_dim
LIMIT 5

SELECT *
FROM skills_job_dim
LIMIT 5


WITH remote_jobs AS (
select skills_name.skill_id,count(*) AS SKILL_COUNT
from job_postings_fact AS jobs INNER JOIN skills_job_dim AS skills_name ON jobs.job_id=skills_name.job_id
where jobs.job_work_from_home = TRUE AND job_title_short = 'Data Analyst'
GROUP BY skills_name.skill_id
)
select skills_dim.skill_id, skills_dim.skills, SKILL_COUNT
from remote_jobs INNER JOIN skills_dim ON remote_jobs.skill_id= skills_dim.skill_id
ORDER BY SKILL_COUNT DESC
LIMIT 5


select Q1JOBS.job_title_short,
Q1JOBS.job_location,
Q1JOBS.job_via,
Q1JOBS.salary_year_avg,
Q1JOBS.job_posted_date:: date from (
select * from january_jobs
UNION ALL
SELECT * FROM March_Jobs
UNION ALL 
SELECT * FROM February_Jobs
) AS Q1JOBS
where Q1JOBS.salary_year_avg > 70000 AND Q1JOBS.job_title_short = 'Data Analyst'
AND job_location Like '%Bengaluru%'