-- #3.11_more_exercises.sql

-- #1 How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary?

SELECT emp_no, salary, to_date 
FROM salaries S
WHERE to_date=(SELECT MAX(to_date) FROM salaries WHERE emp_no = S.emp_no);

SELECT * FROM titles;

SELECT * FROM salaries
LEFT JOIN titles on salaries.emp_no = titles.emp_no;