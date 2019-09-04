USE employees;

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