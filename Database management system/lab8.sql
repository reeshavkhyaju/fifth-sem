USE employees;

DROP TABLE IF EXISTS high_salary_emp; 
DROP TABLE IF EXISTS sales_emp; 
DROP TABLE IF EXISTS new_salaries; 
DROP TABLE IF EXISTS new_employee;

-- 1. Employees earning more than average salary
SELECT e.emp_no, e.first_name, e.last_name, s.salary FROM employees e JOIN salaries s ON e.emp_no=s.emp_no WHERE s.salary>(SELECT AVG(salary) FROM salaries);

-- 2. Employees working in Sales department
SELECT e.emp_no, e.first_name, e.last_name FROM employees e JOIN dept_emp de ON e.emp_no=de.emp_no JOIN departments d ON de.dept_no=d.dept_no WHERE d.dept_name='Sales';

-- 3. Employees who are department managers
SELECT e.emp_no, e.first_name, e.last_name FROM employees e JOIN dept_manager dm ON e.emp_no=dm.emp_no;

-- 4. Create empty table high_salary_emp
CREATE TABLE high_salary_emp LIKE employees;

-- 5. Insert employees earning more than 80000
INSERT INTO high_salary_emp SELECT * FROM employees WHERE emp_no IN (SELECT emp_no FROM salaries WHERE salary>80000);

-- 6. Create empty table sales_emp
CREATE TABLE sales_emp LIKE employees;

-- 7. Insert employees from Sales department
INSERT INTO sales_emp SELECT e.* FROM employees e JOIN dept_emp de ON e.emp_no=de.emp_no JOIN departments d ON de.dept_no=d.dept_no WHERE d.dept_name='Sales';

-- 8. Duplicate salaries table with data (LIMIT 10 to avoid crash)
CREATE TABLE new_salaries AS SELECT * FROM salaries LIMIT 10;

-- 9. Increase salary by 10% for Development department in new_salaries
SET SQL_SAFE_UPDATES = 0;

UPDATE new_salaries ns JOIN dept_emp de ON ns.emp_no = de.emp_no JOIN departments d ON de.dept_no = d.dept_no SET ns.salary = ns.salary * 1.10 WHERE d.dept_name = 'Development';

SET SQL_SAFE_UPDATES = 1;  -- re-enable safe updates

-- 10. Increase salary by 5000 for employees earning below average
SET SQL_SAFE_UPDATES = 0;

UPDATE new_salaries SET salary = salary + 5000 WHERE salary < (SELECT avg_sal FROM (SELECT AVG(salary) AS avg_sal FROM new_salaries) AS t);

SET SQL_SAFE_UPDATES = 1;  -- re-enable safe updates

-- 11. Delete salary records below average salary

SET SQL_SAFE_UPDATES = 0;

DELETE FROM new_salaries WHERE salary < (SELECT avg_sal FROM (SELECT AVG(salary) AS avg_sal FROM new_salaries) AS t);

SET SQL_SAFE_UPDATES = 1;

-- 12. Create duplicate table for employees
CREATE TABLE new_employee AS SELECT * FROM employees;

-- 13. Delete employees not assigned to any department
SET SQL_SAFE_UPDATES = 0;

DELETE ne FROM new_employee ne LEFT JOIN dept_emp de ON ne.emp_no = de.emp_no WHERE de.emp_no IS NULL;

SET SQL_SAFE_UPDATES = 1;

-- 14. Drop all newly created tables
DROP TABLE IF EXISTS high_salary_emp; 
DROP TABLE IF EXISTS sales_emp; 
DROP TABLE IF EXISTS new_salaries; 
DROP TABLE IF EXISTS new_employee;