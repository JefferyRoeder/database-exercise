use sakila;

-- 3.11_more_exercises --

-- Employee Database

/* #1How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary? Customer service and Production managers make less than their average dept salary */

SELECT * FROM salaries;

CREATE TEMPORARY TABLE bayes_810.salary_temp AS
SELECT S.emp_no, S.salary, DE.dept_no, D.dept_name
FROM salaries S
JOIN dept_emp AS DE ON DE.emp_no = S.emp_no
JOIN departments as D ON D.dept_no = DE.dept_no
WHERE S.to_date = '9999-01-01';


SELECT * from bayes_810.salary_temp;

SELECT D.dept_name, round(avg(ST.salary),0) as avg_salary
FROM departments D
JOIN bayes_810.salary_temp as ST ON ST.dept_no = D.dept_no
GROUP BY D.dept_name;


SELECT D.dept_name, S.salary as manager_salary, SQ.avg_salary, SQ.avg_salary - S.salary as diff_sal
FROM dept_manager DM
LEFT JOIN salaries AS S ON S.emp_no = DM.emp_no
JOIN departments as D ON D.dept_no = DM.dept_no
JOIN(
	SELECT DSUB.dept_name, round(avg(ST.salary),0) as avg_salary
	FROM departments DSUB
	JOIN bayes_810.salary_temp as ST ON ST.dept_no = DSUB.dept_no
	GROUP BY DSUB.dept_name) as SQ ON SQ.dept_name = D.dept_name

WHERE S.to_date = '9999-01-01' AND DM.to_date = '9999-01-01'
ORDER BY D.dept_name;

-- World Database

-- # 2.1 What languages are spoken in Santa Monica?

USE world;

SELECT * FROM city;
SELECT * FROm country;
SELECT * FROM countrylanguage;

SELECT CL.language, CL.percentage
FROM countrylanguage as CL

JOIN city C on C.countrycode = CL.countrycode
WHERE name = 'Santa Monica' AND CL.countrycode = 'USA'
ORDER BY CL.percentage;


-- #2.2 How many different countries are in each region?


SELECT region, count(code) as num_countries
FROM country
GROUP BY region
ORDER BY count(code);


-- #2.3 What is the population for each region?

SELECT region, sum(Population) as population
FROM country
GROUP BY region
ORDER BY sum(population) DESC;


-- #2.4 Population for each continent

SELECT continent, sum(Population) as population
FROM country
GROUP BY continent
ORDER BY sum(population) DESC;


-- #2.5 What is the average life expectancy globally?


SELECT avg(lifeexpectancy)
FROM country;

-- #2.6 What is the average life expectancy for each region, each continent? Sort the results from shortest to longest

SELECT continent, avg(lifeexpectancy) as life_expectancy
FROM country
GROUP BY continent
ORDER BY life_expectancy;


SELECT region, avg(lifeexpectancy) as life_expectancy
FROM country
GROUP BY region
ORDER BY life_expectancy;


-- BONUS #1




-- Sakila Database

-- #1 Display the first and last names in all lowercase of all the actors.


use sakila;

select lower(first_name), lower(last_name) from actor;


-- #2 You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you could use to obtain this information?


SELECT * from actor_info
WHERE first_name LIKE '%Joe';


-- #3 Find all actors whose last name contain the letters "gen":

SELECT * FROM actor_info
WHERE last_name LIKE '%gen%';


-- #4 Find all actors whose last names contain the letters "li". This time, order the rows by last name and first name, in that order.


SELECT * FROM actor_info
WHERE last_name LIKE '%li%'
ORDER BY last_name, first_name;


-- #5 Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China:

SELECT country_id, country FROM country
WHERE country IN ('Afghanistan','Bangladesh','China');

-- #6 List the last names of all the actors, as well as how many actors have that last name.


SELECT last_name, count(last_name)
FROM actor_info
GROUP BY last_name
ORDER BY count(last_name) DESC;

-- #7 List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors


SELECT last_name, count(last_name)
FROM actor_info
GROUP BY last_name
HAVING count(last_name) > 1
ORDER BY count(last_name) DESC;

-- #8 You cannot locate the schema of the address table. Which query would you use to re-create it? I would use customer_list table to rebuild it.

SELECT * from country;

SELECT * FROM customer_list
ORDER BY address;

-- #9Use JOIN to display the first and last names, as well as the address, of each staff member.

select S.first_name, S.last_name, SL.address
FROM staff S
JOIN staff_list as SL ON SL.id = S.staff_id;


-- #10 Use JOIN to display the total amount rung up by each staff member in August of 2005.


select staff_id, amount
FROM payment
WHERE payment_date BETWEEN '2005-08-01' AND '2005-08-31';

SELECT SL.name, sum(amount) as aug2005_sales 
FROM staff_list SL
JOIN(
	select staff_id, amount
	FROM payment
	WHERE payment_date BETWEEN '2005-08-01' AND '2005-08-31') 
	as SQ ON SQ.staff_id = SL.id
GROUP BY SL.name;


-- #11 List each film and the number of actors who are listed for that film.
select sakila;
select film.title, count(FA.film_id)
FROM film
JOIN film_actor as FA on FA.film_id = film.film_id
GROUP BY film.title;

-- #12 How many copies of the film Hunchback Impossible exist in the inventory system?
select * FROM inventory;

SELECT count(I.film_id) as `inventory_count`
FROM inventory I
JOIN film_list as FL ON FL.fid = I.film_id
WHERE FL.title LIKE "%Hunchback Impossible%";

-- #13 The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
select * from language;

SELECT F.title, SQ.language_id 
FROM film F
WHERE (F.title LIKE 'K%' or F.title LIKE 'Q%');
JOIN(
	SELECT language_id
	FROM language L
	WHERE language_id = 1 ) as SQ ON SQ.language_id = F.langugae_id;


-- #14 Use subqueries to display all actors who appear in the film Alone Trip.
select * FROM film
WHERE title = 'Alone Trip';


SELECT title, concat(A.first_name," ",A.last_name)
FROM film F
JOIN film_actor AS FA ON FA.film_id = F.film_id
JOIN actor AS A ON A.actor_id = FA.actor_id
WHERE title = 'Alone Trip';

/* checking results:
select * from film_actor
WHERE film_id = 17;
select * from actor
WHERE actor_id IN (3,12,13,82,100,160,187); */


-- #15 You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.
SELECT * FROM customer;
select last_name, first_name, email
FROM customer
JOIN(
	SELECT id
	FROM customer_list
	WHERE country = 'Canada')
	AS SQ ON SQ.id = customer.customer_id
;


-- #16 Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.


SELECT FC.category_id, F.title
FROM film_category FC
JOIN (
	SELECT category_id, `name`
	FROM category
	WHERE name = 'Family')
	as C ON C.category_id = FC.category_id
JOIN film as F ON F.film_id = FC.film_id
;


-- #17 Write a query to display how much business, in dollars, each store brought in.

select store, total_sales FROM sales_by_store;

-- #18 Write a query to display for each store its store ID, city, and country.

SELECT * FROM store;

SELECT * FROM city;


SELECT * FROM country;


