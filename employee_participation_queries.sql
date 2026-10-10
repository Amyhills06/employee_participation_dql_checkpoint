-- ============================================================
-- Employee Participation Information System
-- Data Query Language (DQL) Checkpoint
-- ============================================================

USE check_point;

-- 1. Employees assigned to more than one project (with project count)
SELECT e.name,
       COUNT(ep.proj_no) AS Total_Projects
FROM Employee e
JOIN Employee_Project ep ON e.Num_E = ep.emp_no
GROUP BY e.Num_E, e.name
HAVING COUNT(ep.proj_no) > 1;

-- 2. Projects managed by each department (label + manager name)
SELECT d.label AS Department_Label,
       d.managers_name AS Manager_Name,
       p.title AS Project_Title
FROM Department d
JOIN Project p ON d.Num_S = p.dept_no
ORDER BY d.label, p.title;

-- 3. Employees working on "Website Redesign" with their roles
SELECT e.name,
       ep.role
FROM Employee e
JOIN Employee_Project ep ON e.Num_E = ep.emp_no
JOIN Project p ON ep.proj_no = p.Num_P
WHERE p.title = 'Website Redesign';

-- 4. Department with the highest number of employees
SELECT d.label AS Department_Label,
       d.managers_name AS Manager_Name,
       COUNT(e.Num_E) AS Total_Employees
FROM Department d
JOIN Employee e ON d.Num_S = e.dept_no
GROUP BY d.Num_S, d.label, d.managers_name
HAVING COUNT(e.Num_E) = (
    SELECT MAX(emp_count)
    FROM (SELECT COUNT(*) AS emp_count
          FROM Employee
          GROUP BY dept_no) AS counts
);

-- 5. Employees earning more than 60,000 (with department name)
SELECT e.name,
       e.position,
       d.label AS Department_Name
FROM Employee e
JOIN Department d ON e.dept_no = d.Num_S
WHERE e.salary > 60000;

-- 6. Number of employees assigned to each project
SELECT p.title AS Project_Title,
       COUNT(ep.emp_no) AS Total_Employees
FROM Project p
LEFT JOIN Employee_Project ep ON p.Num_P = ep.proj_no
GROUP BY p.Num_P, p.title
ORDER BY p.title;

-- 7. Summary of employee roles across projects
SELECT e.name AS Employee_Name,
       p.title AS Project_Title,
       ep.role
FROM Employee e
JOIN Employee_Project ep ON e.Num_E = ep.emp_no
JOIN Project p ON ep.proj_no = p.Num_P
ORDER BY e.name, p.title;

-- 8. Total salary expenditure per department
SELECT d.label AS Department_Label,
       d.managers_name AS Manager_Name,
       SUM(e.salary) AS Total_Salary_Expenditure
FROM Department d
JOIN Employee e ON d.Num_S = e.dept_no
GROUP BY d.Num_S, d.label, d.managers_name;
