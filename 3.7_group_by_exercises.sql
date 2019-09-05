use employees;

-- #2 In your script, use DISTINCT to find the unique titles in the titles table. Your results should look like:

select DISTINCT title FROM titles;

-- #3 Find your query for employees whose last names start and end with 'E'. Update the query find just the unique last names that start and end with 'E' using GROUP BY. The results should be:

select last_name 
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY last_name;

-- #4 Update your previous query to now find unique combinations of first and last name where the last name starts and ends with 'E'. You should get 846 rows.

select last_name, first_name 
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY last_name, first_name;

-- #5 Find the unique last names with a 'q' but not 'qu'. Your results should be:

select last_name
FROM employees
WHERE last_name LIKE '%q%' and last_name NOT LIKE '%qu%'
group by last_name;

-- #6 Add a COUNT() to your results and use ORDER BY to make it easier to find employees whose unusual name is shared with others.
use employees;
select last_name, count(*)
FROM employees
WHERE last_name LIKE '%q%' and last_name NOT LIKE '%qu%'
group by last_name
ORDER BY count(*) DESC;

-- #7 Update your query for 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names. Your results should be:

SELECT count(*), gender 
FROM employees 
WHERE first_name IN('Irena','Vidya','Maya')
group by gender
ORDER BY count(*) DESC;

-- #8 Recall the query the generated usernames for the employees from the last lesson. Are there any duplicate usernames? There are 13251 duplicate usernames


SELECT lower(concat(substr(first_name,1,1),substr(last_name,1,4),'_',substr(birth_date,6,2),substr(birth_date,3,2))) as full_name, count(*) 
FROM employees
group by full_name
having count(*) > 1
ORDER BY count(*) DESC
;







