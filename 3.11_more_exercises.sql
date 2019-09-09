-- 3.11_more_exercises --


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
