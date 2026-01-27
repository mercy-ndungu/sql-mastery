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

-- Exercise 3: Find employees who have been with the company longer than 10 years but have never promoted
SELECT employee_id, years_at_company, num_promotions, job_role,last_promotion_years_ago
FROM Employees
WHERE years_at_company > 10 AND num_promotions = 0
Order BY years_at_company;

-- Exercise 4: Calculate the salary difference between each employee and their department's average
SELECT 
    employee_id,
    name,
    department,
    monthly_salary,
    job_role,
    -- Get department average
    (SELECT ROUND(AVG(monthly_salary), 2) 
     FROM Employees e2 
     WHERE e2.department = e1.department) as dept_avg_salary,
    -- Calculate difference
    monthly_salary - (SELECT AVG(monthly_salary) 
                      FROM Employees e2 
                      WHERE e2.department = e1.department) as salary_difference
FROM Employees e1
WHERE monthly_salary IS NOT NULL
ORDER BY department, salary_difference DESC;

-- Exercise 5: Find pairs of employees with the same education level and similar salaries
SELECT 
    e1.employee_id as emp1_id,
    e1.name as emp1_name,
    e1.monthly_salary as emp1_salary,
    e2.employee_id as emp2_id,
    e2.name as emp2_name,
    e2.monthly_salary as emp2_salary,
    e1.education,
    ROUND(ABS(e1.monthly_salary - e2.monthly_salary), 2) as salary_difference,
    ROUND(ABS(e1.monthly_salary - e2.monthly_salary) * 100.0 / 
          ((e1.monthly_salary + e2.monthly_salary) / 2), 2) as salary_difference_percent
FROM Employees e1
JOIN Employees e2 
    ON e1.education = e2.education
    AND e1.employee_id < e2.employee_id  
    AND ABS(e1.monthly_salary - e2.monthly_salary) <= 500  
ORDER BY e1.education, salary_difference;








