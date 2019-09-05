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
WHERE DE.to_date = '9999-01-01' and titles.to_date = '9999-01-01' and titles.title = 'Manager'
;






