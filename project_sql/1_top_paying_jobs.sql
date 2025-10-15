SELECT 
    jobs.job_id,
    job_title,
    company.name as company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM job_postings_fact as jobs LEFT JOIN company_dim as company on jobs.company_id = company.company_id
where job_title_short = 'Data Analyst' AND job_location LIKE '%Bengaluru%'
AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10