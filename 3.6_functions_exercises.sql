use employees;

-- # 3.6_functions_exercises

-- #2 Update your queries for employees whose names start and end with 'E'. Use concat() to combine their first and last name together as a single column named full_name.


SELECT concat(first_name,' ',last_name) AS full_name FROM employees WHERE last_name LIKE 'E%E';

-- testing question 2 looking for full name starting and ending with E
SELECT *  AS full_name FROM employees WHERE concat(first_name,' ',last_name) LIKE 'e%e';

-- #3 Convert the names produced in your last query to all uppercase.


SELECT upper(concat(first_name,' ',last_name)) AS full_name FROM employees WHERE last_name LIKE 'E%E';

-- #4 For your query of employees born on Christmas and hired in the 90s, use datediff() to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE())


SELECT first_name,last_name,hire_date,datediff(curdate(),hire_date) FROM employees WHERE hire_date BETWEEN '1990-1-1' AND '1999-12-31' AND birth_date LIKE '%12-25' ORDER BY birth_date ASC, hire_date DESC;

-- #5 Find the smallest and largest salary from the salaries table.

SELECT * FROM salaries;
SELECT min(salary) as min_salary,max(salary) as max_salary FROM salaries;

-- #6 Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:

select * FROM employees;
SELECT lower(concat(substr(first_name,1,1),substr(last_name,1,4),'_',substr(birth_date,6,2),substr(birth_date,3,2))), first_name,last_name,birth_date FROM employees;



/*prior exercises-- #Exercise 3.5.2

USE employees;

-- #2
SELECT * FROM employees WHERE first_name IN('Irena','Vidya','Maya') ORDER BY first_name;

-- #3
SELECT * FROM employees WHERE first_name IN('Irena','Vidya','Maya') ORDER BY first_name, last_name;

-- #4
SELECT * FROM employees WHERE first_name IN('Irena','Vidya','Maya') ORDER BY last_name, first_name;

-- #5
SELECT * FROM employees WHERE last_name LIKE '%E%' ORDER BY emp_no;

-- #6
SELECT * FROM employees WHERE first_name IN('Irena','Vidya','Maya') ORDER BY last_name DESC, first_name DESC;

SELECT * FROM employees WHERE last_name LIKE '%E%' ORDER BY emp_no DESC;

-- #7

SELECT * FROM employees WHERE hire_date BETWEEN '1990-1-1' AND '1999-12-31' AND birth_date LIKE '%12-25' ORDER BY birth_date ASC, hire_date DESC;




/* Prior exercise unused code
USE employees;
-- part1
-- #2
SELECT * FROM employees WHERE first_name IN('Irena','Vidya','Maya');

-- #3
SELECT * FROM employees WHERE last_name LIKE 'E%';

-- #4 
SELECT * FROM employees WHERE hire_date BETWEEN '1990-1-1' AND '1999-12-31';

-- #5
SELECT * FROM employees WHERE birth_date LIKE '%12-25';

-- #6
SELECT * FROM employees WHERE last_name LIKE '%q%';



--part2
USE employees;

-- #1
SELECT * FROM employees WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';

-- #2 
SELECT * FROM employees WHERE (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya') AND gender = 'M';

-- #3
SELECT * FROM employees WHERE last_name LIKE '%E' OR last_name LIKE 'E%';

-- #4
SELECT * FROM employees WHERE last_name LIKE '%E' AND last_name LIKE 'E%';

-- #5
SELECT * FROM employees WHERE hire_date BETWEEN '1990-1-1' AND '1999-12-31' AND birth_date LIKE '%12-25';

-- #6
SELECT * FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';*/
