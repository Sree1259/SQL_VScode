
---by using cte, its lengthy
/*
with skills_demand as(
SELECT skills_dim.skill_id,
    skills_dim.skills,
    count(skills_job_dim.job_id) as demand_count
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE job_title_short='Data Analyst' AND
    salary_year_avg is not null AND
    job_work_from_home=TRUE
GROUP BY skills_dim.skill_id

), Average_Salary as(
SELECT skills_dim.skill_id,
    Round(Avg(salary_year_avg),0) as Avg_Salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE job_title_short='Data Analyst' AND
    salary_year_avg is Not null AND
     job_work_from_home=TRUE
GROUP BY skills_dim.skill_id

)
SELECT skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    Avg_Salary
from skills_demand
INNER JOIN Average_Salary on skills_demand.skill_id=Average_Salary.skill_id
WHERE demand_count>10
ORDER by Avg_Salary desc,
demand_count desc;

*/
--- do using joins
SELECT sd.skill_id,
    sd.skills,
    count(sjd.job_id) as demand_count,
    round(Avg(j.salary_year_avg),0) as Avg_Salary
from skills_job_dim sjd
INNER JOIN job_postings_fact j  on sjd.job_id=j.job_id
INNER JOIN skills_dim sd on sjd.skill_id=sd.skill_id
WHERE j.job_title_short ='Data Analyst' And
    salary_year_avg is not null AND
    job_work_from_home =TRUE
GROUP BY sd.skill_id
HAVING count(sjd.job_id) > 10
ORDER by Avg_Salary desc,
demand_count desc;







