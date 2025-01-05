SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time 
    EXTRACT(month FROM job_posted_date) as month   
FROM
    job_postings_fact limit 5;

-- ::date -> type casting, at time zone, extract -> month

-- From the highest job_posting_count in each month
SELECT 
    COUNT(job_id) as job_posted_count,
    EXTRACT(MONTH from job_posted_date) As month
FROM 
    job_postings_fact
WHERE
    job_title_short='Data Analyst'
GROUP BY month
ORDER BY job_posted_count DESC; 

--avg(yearly and hourly salary) after june1,2023 and
-- group by job_schedule_type
SELECT 
    Round(AVG(salary_hour_avg),2) AS Avg_hourly_salary, 
    Round(AVG(salary_year_avg),2) AS Avg_yearly_salary, 
    job_schedule_type,
    job_posted_date::DATE AS Job_date
FROM 
    job_postings_fact
WHERE 
    job_posted_date::DATE > '2023-06-01'
GROUP BY 
    job_schedule_type, 
    job_posted_date::DATE;

--- Create tables for months jan,feb,mar
CREATE TABLE January_jobs As
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) =1;

CREATE TABLE february_jobs As
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) =2;

CREATE TABLE March_jobs As
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) =3;

SELECT * FROM March_jobs;