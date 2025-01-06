/*
Top_paying jobs for data analyst
-top 10 highest paying jobs that are available remotely
-Focuses on job posting with specified salaries(not null) 
-which company is offering
*/

SELECT
    job_id,
    job_title,
    name,
    job_location,
    salary_year_avg,
    job_posted_date
FROM 
    job_postings_fact j 
LEFT JOIN 
    company_dim c
ON
    j.company_id=c.company_id
WHERE
    job_title_short='Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS Not null
ORDER BY salary_year_avg DESC
limit 10;