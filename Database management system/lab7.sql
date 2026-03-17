USE employees;

-- Question 1: Display employee first name, last name, and department name using INNER JOIN
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN dept_emp de ON e.emp_no=de.emp_no JOIN departments d ON de.dept_no=d.dept_no;

-- Question 2: List all employees along with their department names, including employees without departments
SELECT e.first_name, e.last_name, d.dept_name FROM employees e LEFT JOIN dept_emp de ON e.emp_no=de.emp_no LEFT JOIN departments d ON de.dept_no=d.dept_no;

-- Question 3: Find department-wise total salary using JOIN
SELECT d.dept_name, SUM(s.salary) AS total_salary FROM departments d JOIN dept_emp de ON d.dept_no=de.dept_no JOIN salaries s ON de.emp_no=s.emp_no GROUP BY d.dept_name;

-- Question 4: Display employees whose salary is greater than the overall average salary
SELECT e.first_name, e.last_name, s.salary FROM employees e JOIN salaries s ON e.emp_no=s.emp_no WHERE s.salary>(SELECT AVG(salary) FROM salaries);

-- Question 5: Find employees who have the same job title as employee ‘John’
SELECT e.first_name, e.last_name, t.title FROM employees e JOIN titles t ON e.emp_no=t.emp_no WHERE t.title IN (SELECT t2.title FROM employees e2 JOIN titles t2 ON e2.emp_no=t2.emp_no WHERE e2.first_name='John');

-- Question 6: Create a VIEW showing employee name, job title, and salary
DROP VIEW IF EXISTS emp_view;
CREATE VIEW emp_view AS SELECT e.first_name, e.last_name, t.title, s.salary FROM employees e JOIN titles t ON e.emp_no=t.emp_no JOIN salaries s ON e.emp_no=s.emp_no;

-- Question 7: Increase salary by 10% for employees working in the ‘Sales’ department using JOIN
UPDATE salaries SET salary = salary * 1.10 WHERE emp_no IN ( SELECT emp_no FROM dept_emp de JOIN departments d ON de.dept_no = d.dept_no WHERE d.dept_name = 'Sales') LIMIT 100;
-- UPDATE salaries s JOIN dept_emp de ON s.emp_no = de.emp_no JOIN departments d ON de.dept_no = d.dept_no SET s.salary = s.salary * 1.10 WHERE d.dept_name = 'Sales';

-- Question 8: Display employees who do not belong to any department
SELECT e.first_name, e.last_name FROM employees e LEFT JOIN dept_emp de ON e.emp_no=de.emp_no WHERE de.emp_no IS NULL;

-- Question 9: Use CASE to classify employees as High, Medium, or Low salary
SELECT e.first_name, e.last_name, s.salary, CASE WHEN s.salary>80000 THEN 'High' WHEN s.salary BETWEEN 50000 AND 80000 THEN 'Medium' ELSE 'Low' END AS salary_level FROM employees e JOIN salaries s ON e.emp_no=s.emp_no LIMIT 10;

-- Question 10: Find the department having the highest total salary
SELECT d.dept_name, SUM(s.salary) AS total_salary FROM departments d JOIN dept_emp de ON d.dept_no=de.dept_no JOIN salaries s ON de.emp_no=s.emp_no GROUP BY d.dept_name ORDER BY total_salary DESC LIMIT 1;

-- Question 11: Create a VIEW to show department-wise average salary
DROP VIEW IF EXISTS dept_avg;
CREATE VIEW dept_avg AS SELECT d.dept_name, AVG(s.salary) AS avg_salary FROM departments d JOIN dept_emp de ON d.dept_no=de.dept_no JOIN salaries s ON de.emp_no=s.emp_no GROUP BY d.dept_name;

-- Question 12: Find employees earning more than the overall average salary
SELECT e.first_name, e.last_name, s.salary FROM employees e JOIN salaries s ON e.emp_no=s.emp_no WHERE s.salary>(SELECT AVG(salary) FROM salaries);

-- Question 13: Find the second highest salary
SELECT MAX(salary) AS second_highest FROM salaries WHERE salary<(SELECT MAX(salary) FROM salaries);

-- Question 14: Create a VIEW for employees hired after 2018
DROP VIEW IF EXISTS hired_after_2018;
CREATE VIEW hired_after_2018 AS SELECT emp_no, first_name, last_name, hire_date FROM employees WHERE hire_date>'2018-01-01';

-- Question 15: Delete employees who have never been assigned to any department
SET SQL_SAFE_UPDATES = 0;
DELETE FROM employees WHERE emp_no NOT IN (SELECT emp_no FROM dept_emp);
SET SQL_SAFE_UPDATES = 1;

