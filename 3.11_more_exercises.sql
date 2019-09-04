-- #3.11_more_exercises.sql

-- #1 How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary?

SELECT emp_no, salary, to_date 
FROM salaries S
WHERE to_date=(SELECT MAX(to_date) FROM salaries WHERE emp_no = S.emp_no);
USE employees;
SELECT * FROM titles LIMIT 10;
SELECT * from salaries LIMIT 10;

SELECT titles.emp_no, titles.title, salaries.salary, salaries.emp_no as sal_emp_no FROM salaries
LEFT JOIN titles on salaries.emp_no = titles.emp_no WHERE title = 'Manager';


SELECT titles.emp_no, titles.title, S.salary, S.emp_no
FROM salaries S 
LEFT JOIN titles on S.emp_no = titles.emp_no
WHERE S.to_date=(SELECT Max(salaries.to_date) FROM salaries WHERE emp_no = S.emp_no) AND title = 'Manager';