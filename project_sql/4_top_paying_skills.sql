SELECT skills, ROUND(AVG(salary_year_avg),2) as Average
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY Average DESC
LIMIT 25

/*[
  {
    "skills": "svn",
    "average": "400000.00"
  },
  {
    "skills": "solidity",
    "average": "179000.00"
  },
  {
    "skills": "couchbase",
    "average": "160515.00"
  },
  {
    "skills": "datarobot",
    "average": "155485.50"
  },
  {
    "skills": "golang",
    "average": "155000.00"
  },
  {
    "skills": "mxnet",
    "average": "149000.00"
  },
  {
    "skills": "dplyr",
    "average": "147633.33"
  },
  {
    "skills": "vmware",
    "average": "147500.00"
  },
  {
    "skills": "terraform",
    "average": "146733.83"
  },
  {
    "skills": "twilio",
    "average": "138500.00"
  },
  {
    "skills": "gitlab",
    "average": "134126.00"
  },
  {
    "skills": "kafka",
    "average": "129999.16"
  },
  {
    "skills": "puppet",
    "average": "129820.00"
  },
  {
    "skills": "keras",
    "average": "127013.33"
  },
  {
    "skills": "pytorch",
    "average": "125226.20"
  },
  {
    "skills": "perl",
    "average": "124685.75"
  },
  {
    "skills": "ansible",
    "average": "124370.00"
  },
  {
    "skills": "hugging face",
    "average": "123950.00"
  },
  {
    "skills": "tensorflow",
    "average": "120646.83"
  },
  {
    "skills": "cassandra",
    "average": "118406.68"
  },
  {
    "skills": "notion",
    "average": "118091.67"
  },
  {
    "skills": "atlassian",
    "average": "117965.60"
  },
  {
    "skills": "bitbucket",
    "average": "116711.75"
  },
  {
    "skills": "airflow",
    "average": "116387.26"
  },
  {
    "skills": "scala",
    "average": "115479.53"
  }
]*/