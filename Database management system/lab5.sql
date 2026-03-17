-- from: https://github.com/datacharmer/test_db 
-- C:\Program Files\MySQL\MySQL Server 8.0\bin\test_db-master>mysql -u root -p < employees.sql
show databases;
use employees;
-- select count(*) from employees;
-- select * from employees;
-- LIMIT 100;

-- for figure: database -> reverse engineer all next and select that database;

desc employees;
show tables;
desc current_dept_emp;
desc departments;
desc dept_emp;
desc dept_emp_latest_date;
desc dept_manager;
desc employees;
desc salaries;
desc titles;

-- select emp_no as ID,concat(first_name,' ',last_name) as full_name ,salary as current_salary,salary*1.10 as new_salary from employees natural join salaries LIMIT 100;

-- 1. Display employee number, employee name, current salary and salary increased by 10%
select emp_no as ID, concat(first_name,' ',last_name) as full_name, salary as current_salary, salary*1.10 as new_salary from employees natural join salaries LIMIT 100;

-- 2. List employee name and their annual salary
select concat(first_name,' ',last_name) as full_name, salary*12 as annual_salary from employees natural join salaries LIMIT 100;

-- 3. Employee having half-month salary greater than 30,000
select concat(first_name,' ',last_name) as full_name from employees natural join salaries where salary/2 > 30000;

-- 4. Male employees hired after 1995
select concat(first_name,' ',last_name) as full_name, hire_date from employees where gender='M' and hire_date > '1995-12-31';

-- 5. Employees who are female OR hired before 1990
select * from employees where gender='F' or hire_date < '1990-01-01';

-- 6. Employees who are not females
select * from employees where gender <> 'F';

-- 7. Employees whose salary is greater than 60,000
select emp_no, salary from salaries where salary > 60000;

-- 8. Employees hired on or before 1992-12-31
select * from employees where hire_date <= '1992-12-31';

-- 9. Employees working in departments d001 or d002
select emp_no from dept_emp where dept_no in ('d001','d002');

-- 10. Employees whose salary is between 50,000 and 80,000
select emp_no, salary from salaries where salary between 50000 and 80000;

-- 11. Find the employees currently working
select emp_no from dept_emp where to_date='9999-01-01';

-- 12. Find employees whose first name starts with 'A'
select * from employees where first_name like 'A%';

-- 13. Display employees whose last name ends with 'son'
select * from employees where last_name like '%son';

-- 14. Find employees whose first name contains 'an'
select * from employees where first_name like '%an%';

-- 15. Display employees whose first name has exactly 5 characters
select * from employees where length(first_name)=5;

-- 16. Display employees whose last name has at least 5 characters
select * from employees where length(last_name) >= 5;

-- 17. Display employees whose first name doesn't start with 'Ba'
select * from employees where first_name not like 'Ba%';

-- 18. Find total number of employees
select count(*) as total_employees from employees;

-- 19. Find average salary of employees
select avg(salary) as avg_salary from salaries;

-- 20. Display highest salary of employees
select max(salary) as highest_salary from salaries;

-- 21. Find the lowest salary of employees
select min(salary) as lowest_salary from salaries;

-- 22. Find the total amount of salary paid to employees who works in Research department
select sum(s.salary) as total_salary from salaries s join dept_emp d on s.emp_no=d.emp_no join departments dep on d.dept_no=dep.dept_no where dep.dept_name='Research';

-- List all departments with their department number and name
select dept_no, dept_name from departments;