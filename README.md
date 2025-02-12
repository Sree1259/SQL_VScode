# Introduction
I analyzed and explored job market data to uncover insights related to **top-paying data analyst roles**, **high-demand skills**, and their impact on salaries. Using SQL, I queried and processed the dataset to answer key questions about salary trends, skill requirements, and the most valuable competencies for career growth in data analytics.
## Analyzed on these Questions
### What are the top-paying data analyst jobs?
```sql
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
```

### What skills are required for these top-paying jobs?

```sql
WITH High_Paying_jobs AS(
    SELECT
        job_id,
        job_title,
        name,
        salary_year_avg
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
    limit 10
)

SELECT High_Paying_jobs.*, skills
FROM High_Paying_jobs h
INNER JOIN skills_job_dim
ON h.job_id=s.job_id
INNER JOIN skills_dim sd
ON s.skill_id=sd.skill_id
ORDER BY salary_year_avg DESC;
```
#### Insights
Core technical skills like SQL and Python are the most sought-after for high-paying data analyst roles.
Data visualization tools such as Tableau and Excel are critical for the role.
Specialized tools like Snowflake and Azure are also in demand.

### What skills are most in demand for data analysts?
```
/* Demand skills for Data Analyst
*/
SELECT skills,
        count(skills_job_dim.job_id) as demand_count
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE job_title_short='Data Analyst' 
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 10;
```

### Which skills are associated with higher salaries?
```
/* Top_paying Skills based on salary
average of salary for specified skill
*/
SELECT skills,
        Round(Avg(salary_year_avg),0) as Average_Salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE job_title_short='Data Analyst' AND
    salary_year_avg is Not null
GROUP BY skills
ORDER BY Average_Salary DESC
LIMIT 25;
```
#### Key Insights on Top-Paying Skills
Emerging Technologies Dominate: 
Skills like SVN ($400,000), Solidity ($179,000), and Couchbase ($160,515) lead, highlighting the demand for blockchain, AI platforms, and niche tools.
AI and DevOps are Vital: 
Tools like PyTorch, TensorFlow, Keras, and Terraform, Ansible, Puppet showcase the importance of deep learning frameworks and infrastructure automation.
Collaboration and Big Data Trends: 
High salaries for skills like Kafka ($129,999), Cassandra ($118,407), and Twilio ($138,500) reflect the value of distributed systems and team workflow tools in modern industries.

### What are the most optimal skills to learn?
```
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
```

## Learnings From the Project
- Optimizing SQL Queries: Implementing efficient query techniques to enhance performance and reduce execution time.
- Strategic Query Framing: Structuring queries effectively to extract meaningful insights from data.
- Proficiency in PostgreSQL: Utilizing PostgreSQL features for advanced data analysis and query execution. 

