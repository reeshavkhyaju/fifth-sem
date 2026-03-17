show databases;
use employees;
-- select gender, count(*) as total_employees from employees group by gender;

-- 1. Count and display number of employees grouped by gender
select gender, count(*) as total_employees from employees group by gender;

-- 2. Show department name and count the number of employees in each department
select d.dept_name, count(de.emp_no) as total_employees from departments d join dept_emp de on d.dept_no=de.dept_no group by d.dept_name;

-- 3. Show department names with average salary per department
select d.dept_name, avg(s.salary) as avg_salary from departments d join dept_emp de on d.dept_no=de.dept_no join salaries s on de.emp_no=s.emp_no group by d.dept_name;

-- 4. List job title and maximum salary for each job title
select t.title, max(s.salary) as max_salary from titles t join salaries s on t.emp_no=s.emp_no group by t.title;

-- 5. List department name and number of employees having more than 20,000 employees
select d.dept_name, count(de.emp_no) as total_employees from departments d join dept_emp de on d.dept_no=de.dept_no group by d.dept_name having count(de.emp_no)>20000;

-- 6. List only those job titles and average salary having salary greater than 60,000/-
select t.title, avg(s.salary) as avg_salary from titles t join salaries s on t.emp_no=s.emp_no group by t.title having avg(s.salary)>60000;

-- 7. List department names and max salary of departments where maximum salary exceeds 1,00,000/-
select d.dept_name, max(s.salary) as max_salary from departments d join dept_emp de on d.dept_no=de.dept_no join salaries s on de.emp_no=s.emp_no group by d.dept_name having max(s.salary)>100000;

-- 8. List job title and minimum salary for each job title
select t.title, min(s.salary) as min_salary from titles t join salaries s on t.emp_no=s.emp_no group by t.title;

-- 9. Count number of employees hired each year
select year(hire_date) as hire_year, count(*) as total_employees from employees group by year(hire_date);

-- 10. Count the number of employees per job title
select title, count(emp_no) as total_employees from titles group by title;

-- 11. List emp no, first name, last name of employees earning more than the average salary
select emp_no, first_name, last_name from employees where emp_no in (select emp_no from salaries where salary>(select avg(salary) from salaries));

-- 12. List first name, last name of employees earning the maximum salary (without using join)
select first_name, last_name from employees where emp_no in (select emp_no from salaries where salary=(select max(salary) from salaries));

-- 13. Show department names having employees with salary above 90,000/-
select dept_name from departments where dept_no in (select dept_no from dept_emp where emp_no in (select emp_no from salaries where salary>90000));

-- 14. List first name, last name of the employees who are the department managers
select first_name, last_name from employees where emp_no in (select emp_no from dept_manager);

-- 15. List first name, last name of employees who never became managers
select first_name, last_name from employees where emp_no not in (select emp_no from dept_manager);