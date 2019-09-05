CREATE TABLE roles (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  role_id INT UNSIGNED DEFAULT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (role_id) REFERENCES roles (id)
);

INSERT INTO roles (name) VALUES ('admin');
INSERT INTO roles (name) VALUES ('author');
INSERT INTO roles (name) VALUES ('reviewer');
INSERT INTO roles (name) VALUES ('commenter');

INSERT INTO users (name, email, role_id) VALUES
('bob', 'bob@example.com', 1),
('joe', 'joe@example.com', 2),
('sally', 'sally@example.com', 3),
('adam', 'adam@example.com', 3),
('jane', 'jane@example.com', null),
('mike', 'mike@example.com', null);


select * FROM roles;

select * FROM users;

SELECT U.id, U.name, U.email, roles.name
FROM users as U
JOIN roles ON U.role_id = roles.id;

SELECT U.id, U.name, U.email, coalesce(roles.name, 'Freeloader')
FROM users as U
LEFT JOIN roles ON U.role_id = roles.id;

use bayes_810;

-- JOIN EXAMPLE DATABASE
-- # 1Use the join_example_db. Select all the records from both the users and roles tables.

SELECT U.id, U.name, U.email, roles.name
FROM users as U
JOIN roles ON U.role_id = roles.id;

SELECT U.id, U.name, U.email, roles.name
FROM users as U
LEFT JOIN roles ON U.role_id = roles.id;

SELECT U.id, U.name, U.email, roles.name
FROM users as U
RIGHT JOIN roles ON U.role_id = roles.id;


select * FROM roles;

select * FROM users;

SELECT R.name, count(users.role_id)
FROM roles R
JOIN users ON R.id = users.role_id
GROUP BY R.name;




-- EMPLOYEE DATABASE

use employees;

select * FROM departments;

select* FROM dept_manager;

select * FROM employees
ORDER BY emp_no;

select * FROM salaries
ORDER BY emp_no;

select * FROM dept_emp
ORDER BY emp_no;

select * from titles
ORDER BY emp_no;

select * FROM departments;

select * from 

-- #2 Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.


SELECT departments.dept_name, concat(employees.first_name," ",employees.last_name)
FROM dept_manager DM
JOIN departments on DM.dept_no = departments.dept_no
JOIN employees on DM.emp_no = employees.emp_no
WHERE DM.to_date = '9999-01-01'
ORDER BY departments.dept_name ;

-- #3 Find the name of all departments currently managed by women.

SELECT departments.dept_name, concat(employees.first_name," ",employees.last_name)
FROM dept_manager DM
JOIN departments on DM.dept_no = departments.dept_no
JOIN employees on DM.emp_no = employees.emp_no
WHERE DM.to_date = '9999-01-01' AND employees.gender = 'F'
ORDER BY departments.dept_name ;

-- #4 Find the current titles of employees currently working in the Customer Service department.


SELECT titles.title, count(*)
FROM dept_emp DE
LEFT JOIN titles on titles.emp_no = DE.emp_no
LEFT JOIN departments on DE.dept_no = departments.dept_no
WHERE DE.to_date = '9999-01-01' and titles.to_date = '9999-01-01' and departments.dept_name = 'Customer Service'
GROUP BY titles.title
ORDER BY titles.title;

-- #5 Find the current salary of all current managers.

SELECT departments.dept_name, concat(employees.first_name," ",last_name), salaries.salary
FROM dept_emp DE
LEFT JOIN titles on titles.emp_no = DE.emp_no
LEFT JOIN departments on DE.dept_no = departments.dept_no
LEFT JOIN employees on DE.emp_no = employees.emp_no
LEFT JOIN salaries on DE.emp_no = salaries.emp_no
WHERE DE.to_date = '9999-01-01' and titles.to_date = '9999-01-01' and titles.title = 'Manager' and salaries.to_date = '9999-01-01'
ORDER BY departments.dept_name
;


-- #6 Find the number of employees in each department.


SELECT D.dept_no, D.dept_name, count(*)
FROM departments D
JOIN dept_emp on D.dept_no = dept_emp.dept_no
WHERE dept_emp.to_date = '9999-01-01'
GROUP BY D.dept_no;

-- #7 Which department has the highest average salary?

SELECT departments.dept_name, avg(S.salary)
FROM salaries S
JOIN dept_emp ON dept_emp.emp_no = S.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_emp.to_date = '9999-01-01' and S.to_date = '9999-01-01' AND departments.dept_name = "Sales"
GROUP BY departments.dept_name
;

use employees;
-- #8 Who is the highest paid employee in the Marketing department?

SELECT employees.first_name, employees.last_name
FROM salaries S
JOIN dept_emp ON dept_emp.emp_no = S.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
JOIN employees ON employees.emp_no = S.emp_no

WHERE dept_emp.to_date = '9999-01-01' and S.to_date = '9999-01-01' AND departments.dept_name = "Marketing"

ORDER BY S.salary DESC
LIMIT 1
;

-- #9 Which current department manager has the highest salary?

SELECT employees.first_name, employees.last_name, S.salary, departments.dept_name
FROM salaries S
JOIN dept_emp ON dept_emp.emp_no = S.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
JOIN employees ON employees.emp_no = S.emp_no
JOIN titles on S.emp_no = titles.emp_no

WHERE dept_emp.to_date = '9999-01-01' and S.to_date = '9999-01-01' AND titles.to_date = '9999-01-01' AND titles.title = 'Manager'
ORDER BY S.salary DESC
LIMIT 1;

-- #10 Bonus Find the names of all current employees, their department name, and their current manager's name.

SELECT concat(E.first_name," ",E.last_name),D.dept_name, SQ.last_name, SQ.first_name
FROM dept_emp DE
JOIN departments D ON D.dept_no = DE.dept_no
JOIN employees E ON E.emp_no = DE.emp_no
JOIN 
	(SELECT dept_manager.dept_no, employees.first_name, employees.last_name FROM dept_manager
	JOIN employees on dept_manager.emp_no = employees.emp_no 
	WHERE dept_manager.to_date = '9999-01-01') AS SQ ON SQ.dept_no = D.dept_no
WHERE DE.to_date = '9999-01-01'
ORDER BY D.dept_name, E.first_name
;


-- #11 Bonus Find the highest paid employee in each department.

use employees;
SELECT employees.first_name, employees.last_name, departments.dept_name, SQ.max_salary
FROM salaries S
JOIN dept_emp AS DE ON DE.emp_no = S.emp_no
JOIN departments ON DE.dept_no = departments.dept_no
JOIN employees ON employees.emp_no = S.emp_no
JOIN titles on S.emp_no = titles.emp_no
JOIN
	(SELECT max(SS.salary) as max_salary, DS.dept_name, DES.dept_no as max_dept_no
	FROM salaries SS
	JOIN dept_emp AS DES on DES.emp_no = SS.emp_no
	JOIN departments AS DS on DS.dept_no = DES.dept_no
	WHERE DES.to_date = '9999-01-01' and SS.to_date = '9999-01-01'
	GROUP BY DS.dept_name
	) as SQ on SQ.max_dept_no = DE.dept_no
WHERE DE.to_date = '9999-01-01' AND S.to_date = '9999-01-01' AND titles.to_date = '9999-01-01' AND S.salary = SQ.max_salary 

ORDER BY departments.dept_name;
	
	
	