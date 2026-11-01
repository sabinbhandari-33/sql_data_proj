SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    count(skills_job_dim.skill_id) AS demand_count,
    ROUND (avg(job_postings_fact.salary_year_avg),0)
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE
GROUP BY 
    skills_dim.skill_id
HAVING 
    count(skills_job_dim.skill_id) > 20
ORDER BY 
    
    demand_count DESC
LIMIT 25;