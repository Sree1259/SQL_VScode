SELECT
    job_title_short,
    company_id,
    job_location
FROM january_jobs

UNION

SELECT
    job_title_short,
    company_id,
    job_location
FROM february_jobs

UNION

SELECT
    job_title_short,
    company_id,
    job_location
FROM march_jobs;

SELECT * from skills_dim;

select  job_title_short,
        job_location,
        job_via,
        salary_year_avg,
        job_posted_date::date
from (
    SELECT * from january_jobs
union
    SELECT * from february_jobs
UNION
    SELECT * from march_jobs
) as quarter1
where quarter1.salary_year_avg>70000 
    and job_title_short='Data Analyst'
ORDER BY salary_year_avg DESC;