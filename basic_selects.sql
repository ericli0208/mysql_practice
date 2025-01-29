-- select everything
SELECT *
FROM employees;

SELECT *
FROM mentorships;

--  em_name & gender
SELECT em_name AS `Employee Name`, 
  gender AS Gender
FROM employees;

-- employees #1-3
SELECT *
FROM employees
WHERE id BETWEEN 1 AND 3;

-- female employees that either have 5 years in the company or have a salary > 5000
SELECT *
FROM employees
WHERE (years_in_company > 5 OR salary > 5000) AND gender = 'F';

-- employee info on mentors in SQF Limited project
SELECT em_name
FROM employees
WHERE id IN (
  SELECT mentor_id
  FROM mentorships
  WHERE project = 'SQF Limited');
  
