#Retrieve the list of all jobs posted on a particular website.
select j.jobID, j.Job_Title, j.Company_Name, j.Location, j.Salary 
from job_listing j
Join website w on j.JobID=w.JobID
where websitename = 'myworks';

#Find the total number of applicants for a specific job titile
select sum(numberofapplicants) as TotalApplicants
from applicants a
inner join job_listing j on a.jobid=j.jobid
where j.job_title='paralegal';

#Find the average salary offered for jobs posted in each location, but only for locations where the average salary is greater than $50,000.
select location, avg(salary) as mean_salary
from job_listing
group by location
having avg(salary)> 120000
limit 10;





#the total number of jobs posted by each company in descending order, but only for companies that have posted more than 5 jobs
select company_name, count(*) as total_jobs_posted
from job_listing
group by company_name
having count(*)>5
order by count(*) desc
limit 10;

select sum(numberofapplicants) as total_no_of_applicants, u.userID
from user u
inner join appliesforjob a on u.userID=a.userID
group by u.userID;

#Compare the number of job postings and the number of applicants for each job title across different locations
Select j.job_title, j.location, count(distinct j.Jobid) as No_of_Postings, sum(a.NumberofApplicants) as No_of_Applicants
from job_listing j
left join jobposts jp on j.jobID=jp.jobID
left join applicants a on j.jobID=a.jobID
group by j.job_title, j.location
limit 10;

#Analyze the distribution of job postings across different locations and identify the top 5 locations with the most job listings
select location, count(*) as no_of_postings
from job_listing
group by location
order by no_of_postings desc
limit 10;


#What is the average salary for each job title, and how does it vary by location? This question could help employers understand the typical salary ranges for different job titles in different locations, and could guide their compensation and benefits packages
SELECT j.Job_Title, j.Location, AVG(j.Salary) AS AvgSalary
FROM Job_Listing j
GROUP BY j.Job_Title, j.Location
ORDER BY j.Job_Title, j.Location;

#the job titles and salaries for all job postings that have a higher salary than the average salary for their respective job titles:
SELECT job_title, salary
FROM job_listing j
WHERE salary > (
    SELECT AVG(salary)
    FROM job_listing
    WHERE job_title = j.job_title
);

SELECT e.EmployerName, COUNT(DISTINCT j.JobID) AS NumPostings, SUM(a.NumberofApplicants) AS NumApplications
FROM Employer e
LEFT JOIN JobPosts jp ON e.EmployerID = jp.EmployerID
LEFT JOIN Job_Listing j ON jp.JobID = j.JobID
LEFT JOIN Applicants a ON j.JobID = a.JobID
GROUP BY e.EmployerName;

#Which job listings have the highest number of applicants 
SELECT j.JobID, j.Job_Title, COUNT(a.JobID) AS No_of_Applicants
FROM Job_Listing j
LEFT JOIN Applicants a ON j.JobID = a.JobID
GROUP BY j.JobID, j.Job_Title
ORDER BY No_of_Applicants DESC
LIMIT 10;

SELECT jl.job_title, e.employerlocation, AVG(jl.salary) AS avg_salary
FROM job_listing jl
JOIN jobposts jp ON jl.JobID = jp.JobID
JOIN employer e ON jp.EmployerID = e.EmployerID
GROUP BY jl.job_title, e.employerlocation
ORDER BY avg_salary DESC;

WITH temp_table AS 
(
	SELECT 
		location
        ,COUNT(*) as num_postings 
	FROM job_listing 
    GROUP BY location
)
SELECT 
	location
    ,COUNT(*) as num_postings
FROM job_listing
GROUP BY location
HAVING COUNT(*) = (SELECT MAX(num_postings) FROM temp_table)
;

Select j.job_title, j.location, 
Count(distinct j.Jobid) As No_of_Postings, 
Sum(a.NumberofApplicants) As No_of_Applicants
From job_listing j
Left join jobposts jp on j.jobID=jp.jobID
Left join applicants a on j.jobID=a.jobID
Group by j.job_title, j.location
Limit 10;

SELECT job_listing.JobID, Company_Name, Job_Title, Location, Salary, COUNT(*) AS NumApplicants
FROM Job_Listing
INNER JOIN Applicants ON Job_Listing.JobID = Applicants.JobID
GROUP BY Job_Listing.JobID
ORDER BY NumApplicants DESC
LIMIT 10;

SELECT Employer.EmployerID, EmployerName, COUNT(*) AS TotalJobListings
FROM JobPosts
INNER JOIN Employer ON JobPosts.EmployerID = Employer.EmployerID
GROUP BY Employer.EmployerID
limit 10;

Select company_name, count(*) as total_jobs_posted
From job_listing
Group by company_name
Having count(*)>5
Order by count(*) desc
Limit 10;






