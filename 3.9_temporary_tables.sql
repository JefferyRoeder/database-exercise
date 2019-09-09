-- 3.9_temporary_tables.sql

/* #1 Using the example from the lesson, re-create the employees_with_departments table.

a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns

b. Update the table so that full name column contains the correct data

b. Remove the first_name and last_name columns from the table.

d. What is another way you could have ended up with this same table? */
use bayes_810;
CREATE TEMPORARY TABLE employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;

SELECT * FROM employees_with_departments;

SELECT length(concat(first_name,' ',last_name)) FROM employees_with_departments ORDER BY length(concat(first_name,' ',last_name)) DESC LIMIT 1;


ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);

SELECT * FROM employees_with_departments;

UPDATE employees_with_departments
SET full_name = concat(first_name," ",last_name);

ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

-- #2 Create a temporary table based on the payment table from the sakila database.

-- Write the SQL necessary to transform the amount column such that it is stored as an integer -- representing the number of cents of the payment. For example, 1.99 should become 199.


use bayes_810;

SELECT * FROM payment;

CREATE TEMPORARY TABLE payment_temp AS
SELECT amount
FROM sakila.payment;

SELECT * FROM payment_temp;

-- #3 Find out how the average pay in each department compares to the overall average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department to work for? The worst?

use employees;



CREATE TEMPORARY TABLE bayes_810.avg_stdev_temp AS
SELECT avg(salary) as avg_salary, STDDEV(salary) as std_salary FROM salaries
WHERE to_date = '9999-01-01';

select * from bayes_810.avg_stdev_temp;


ALTER TABLE bayes_810.avg_stdev_temp 
ADD join_temp INT DEFAULT 1;


CREATE TEMPORARY TABLE bayes_810.salary_temp AS
SELECT * FROM salaries
WHERE to_date = '9999-01-01';


ALTER TABLE bayes_810.salary_temp ADD join_sal INT DEFAULT 1;


SELECT D.dept_name, avg(ST.salary), max(SQ.avg_salary), max(SQ.std_salary), (avg(ST.salary)-max(SQ.avg_salary))/max(SQ.std_salary) as z_score
FROM bayes_810.salary_temp ST
JOIN dept_emp AS DE ON DE.emp_no = ST.emp_no
JOIN departments AS D ON D.dept_no = DE.dept_no
JOIN
 	(SELECT avg_salary, std_salary, join_temp
 	FROM bayes_810.avg_stdev_temp
 	) AS SQ ON ST.join_sal = join_temp
 GROUP BY D.dept_name
 ORDER BY dept_name
 ;
 








