-- #3.11_more_exercises.sql

-- #1 How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary?
use employees;

-- # selects most current salary per employee
SELECT emp_no, salary, to_date 
FROM salaries S
WHERE to_date=(SELECT MAX(to_date) FROM salaries WHERE emp_no = S.emp_no) and  ;



USE employees;
SELECT * FROM titles LIMIT 10;
SELECT * from salaries LIMIT 10;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;

SELECT titles.emp_no, titles.title, salaries.salary, salaries.emp_no as sal_emp_no FROM salaries
LEFT JOIN titles on salaries.emp_no = titles.emp_no WHERE title = 'Manager';


-- # selects most recent salary for all managers
SELECT titles.emp_no, titles.title, S.salary, S.emp_no, dept_manager.dept_no
FROM salaries S 
LEFT JOIN dept_manager on S.emp_no = dept_manager.emp_no
LEFT JOIN titles on S.emp_no = titles.emp_no
WHERE S.to_date=(SELECT Max(salaries.to_date) FROM salaries WHERE emp_no = S.emp_no) AND title = 'Manager';

-- # joins emp_no and dept_emp to grab avg salary by dept
SELECT dept_emp.dept_no, avg(S.salary)
FROM salaries S
LEFT JOIN dept_emp on S.emp_no = dept_emp.emp_no
GROUP BY dept_emp.dept_no
;

