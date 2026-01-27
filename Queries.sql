-- State which DB i am using
USE practice_db;
-- The following SQL qeuries will;
-- 1. Find all female employees earning more than the company average
-- 2. List departments with more than 3 employees
-- 3. Find employees who have been with the company longer than 10 years but have never promoted
-- 4. Calculate the salary difference between each employee and their department's average
-- 5. Find pairs of employees with the same education level and similar salaries (within 500)

-- Exercise One: Find all Female employees earning more than the company average.
SELECT 
employee_id, age, job_role, department, monthly_salary,
-- First get the average
(SELECT AVG(monthly_salary) from Employees) as monthly_avg
-- Get female employees paid more than the average
FROM Employees
WHERE gender = "Female" AND monthly_salary > (SELECT avg(monthly_salary) from Employees)
ORDER BY monthly_salary DESC;

-- Exercise Two: List departments with more than 3 employees
SELECT department, COUNT(*) as employee_count
FROM Employees
GROUP BY department
HAVING COUNT(*) > 3
ORDER BY employee_count;
	

	






