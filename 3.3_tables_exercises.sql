-- #3
use employees;

-- #4
show tables;

-- #5 shows diff data types for employees table. int, date, varchar, and enum
describe employees;

-- #6 current_dept_emp, dept_emp, dept_emp_latest_date, dept_manager, salaries, titles all contain numeric columns
describe current_dept_emp;
describe departments;
describe dept_emp;
describe dept_emp_latest_date;
describe employees;
describe dept_manager;
describe titles;

-- #7 all tables contain strings.

-- #8 all tables except departments contain date.

-- #9 employees table not directly related to deparments. Indirectly it is related to departments table through dept_emp table which joins emp_no to tie dept_no to dept_name.


-- #10
show create table dept_manager;