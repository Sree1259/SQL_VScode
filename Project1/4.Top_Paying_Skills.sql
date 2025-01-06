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

/*
Key Insights on Top-Paying Skills
Emerging Technologies Dominate: 
Skills like SVN ($400,000), Solidity ($179,000), and Couchbase ($160,515) lead, highlighting the demand for blockchain, AI platforms, and niche tools.
AI and DevOps are Vital: 
Tools like PyTorch, TensorFlow, Keras, and Terraform, Ansible, Puppet showcase the importance of deep learning frameworks and infrastructure automation.
Collaboration and Big Data Trends: 
High salaries for skills like Kafka ($129,999), Cassandra ($118,407), and Twilio ($138,500) reflect the value of distributed systems and team workflow tools in modern industries.
*/