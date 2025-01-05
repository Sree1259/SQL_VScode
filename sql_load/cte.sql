---company names with no degreee mentioned
SELECT company_id,name as company_name
FROM company_dim
WHERE company_id in(
SELECT company_id
FROM job_postings_fact
WHERE job_no_degree_mention = true
order by company_id
);

select count(job_id) as count_jobs,company_id
FROM job_postings_fact
group by company_id;


----cte to count total jobs by each company from highest to lowest
with count_jobs as (
    SELECT count(*) as jobs_count, company_id
    FROM job_postings_fact
    GROUP BY company_id
    
)
SELECT 
    c.name as company_name, t.jobs_count,
    case
        when t.jobs_count >100 then 'Large'
        when t.jobs_count <=100 and t.jobs_count>=50 then 'Medium'
        else 'Small'
        End Company_size
from company_dim c LEFT JOIN count_jobs t
on c.company_id=t.company_id
order by jobs_count desc;
----subquery with join
SELECT 
    cd.name AS company_name,
    CASE
        WHEN sub.jobs_count > 100 THEN 'Large'
        WHEN sub.jobs_count BETWEEN 50 AND 100 THEN 'Medium'
        ELSE 'Small'
    END AS Company_Size
FROM company_dim cd
JOIN (
    SELECT 
        company_id, 
        COUNT(*) AS jobs_count
    FROM job_postings_fact
    GROUP BY company_id
) sub 
ON cd.company_id = sub.company_id;



--top 5 skills most fre in skills_table with names

with skills_count AS(
    SELECT count(*) as count_skills,skill_id
    from skills_job_dim
    GROUP BY skill_id
)
SELECT s.skill_id,s.skills,c.count_skills
from skills_dim s LEFT JOIN skills_count c
on s.skill_id=c.skill_id
order by count_skills DESC limit 5;
