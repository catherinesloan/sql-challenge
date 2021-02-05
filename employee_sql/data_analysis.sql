DROP TABLE departments;
DROP TABLE titles;
DROP TABLE employees;
DROP TABLE dept_emp;
DROP TABLE dept_manager;
DROP TABLE salaries;

CREATE TABLE departments (
 	dept_no VARCHAR(4) PRIMARY KEY,
	dept_name VARCHAR(30) NOT NULL 
);

CREATE TABLE titles (
	title_id VARCHAR(5) PRIMARY KEY,
	title VARCHAR(30) NOT NULL
);

-- emp_title_id is FK to title_id in titles
CREATE TABLE employees (
	emp_no INT PRIMARY KEY,
	emp_title_id VARCHAR(5) NOT NULL, 
	birth_date DATE NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	sex VARCHAR(1) NOT NULL,
	hire_date DATE NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

-- both cols are FK's
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL, 
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- both cols FK's
CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL, 
	emp_no INT NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

-- emp_no is a FK
CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT * FROM departments;
SELECT * FROM titles;
SELECT * FROM employees;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM salaries;
SELECT * FROM departments LIMIT 1;


-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
-- Need data from employees and salaries
SELECT
	e.emp_no,
	e.last_name,
	e.first_name,
	e.sex,
	s.salary
FROM employees AS e
INNER JOIN salaries AS s
ON e.emp_no = s.emp_no;

-- 2. List first name, last name, and hire date for employees who were hired in 1986.
-- my date columns are in the format yy/mm/dd instead of mm/dd/yy
SELECT 
	first_name AS "First Name", 
	last_name AS "Last Name", 
	hire_date AS "Hire Date"
FROM employees
WHERE hire_date >= '1986-01-01' AND hire_date <= '1986-12-31'
ORDER BY hire_date;

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
-- dept_manager = dept_no, emp_no
-- departments = dept_no, dept_name 
-- employees = last_name, first_name, emp no

-- Need to do 2 joins so creating a view 
CREATE VIEW managers_1 AS
SELECT x.dept_no, y.dept_name, x.emp_no
FROM  dept_manager AS x
INNER JOIN departments AS y 
ON x.dept_no=y.dept_no;

SELECT * FROM managers_1;

-- 2nd join, changing column names to be more readable
SELECT 
	x.dept_no AS "Department Number", 
	x.dept_name AS "Department Name", 
	x.emp_no AS "Managers Employee Number", 
	y.last_name AS "Last Name", 
	y.first_name AS "First Name"
FROM managers_1 as x
INNER JOIN employees AS y
ON x.emp_no=y.emp_no;

/* here for my reference
using the IN func instead of join lists all the managers names and first names
need to do a join when want to add columns
SELECT
	last_name,
	first_name
FROM employees WHERE emp_no IN (
	SELECT emp_no 
	FROM dept_manager
	WHERE dept_no IN (
		SELECT dept_no 
		FROM departments
		WHERE dept_name IN (
			SELECT dept_name 
			FROM departments
		)
	)
);
*/

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
-- dept_emp = emp_no, dept_no
-- departments = dept_name, dept_no
-- employees = emp_no, names

-- trying multiple joins without creating view, could have done this on previous question
SELECT 
	x.emp_no AS "Employee Number",
	e.last_name AS "Last Name",
	e.first_name AS "First Name",
	y.dept_name AS "Department Name"
FROM  dept_emp AS x
INNER JOIN departments AS y ON (x.dept_no=y.dept_no)
INNER JOIN employees AS e ON (e.emp_no=x.emp_no);

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
-- Using % wildcard

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
-- employees = emp_no, names
-- departments = dept_name, dept_no where Sales = d007
-- dept_emp = emp_no, dept_no

CREATE VIEW sales_1 AS
SELECT 
	e.emp_no,
	e.first_name,
	e.last_name,
	x.dept_no
FROM employees AS e
INNER JOIN dept_emp AS x ON (e.emp_no=x.emp_no);

CREATE VIEW sales_2 AS
SELECT * 
FROM sales_1
WHERE dept_no = 'd007';

SELECT
	s.emp_no AS "Employee Number",
	s.first_name AS "First Name",
	s.last_name AS "Last Name",
	y.dept_name AS "Department Name"
FROM sales_2 AS s
INNER JOIN departments as y ON (s.dept_no=y.dept_no);

-- Can also do this in the one step

SELECT 
	e.emp_no AS "Employee Number",
	e.first_name AS "First Name",
	e.last_name AS "Last Name",
	x.dept_name AS "Department Name"
FROM employees as e
INNER JOIN dept_emp AS y ON (e.emp_no=y.emp_no)
INNER JOIN departments AS x ON (x.dept_no=y.dept_no)
WHERE dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
-- same as above but include OR funct for Development

SELECT 
	e.emp_no AS "Employee Number",
	e.first_name AS "First Name",
	e.last_name AS "Last Name",
	x.dept_name AS "Department Name"
FROM employees as e
INNER JOIN dept_emp AS y ON (e.emp_no=y.emp_no)
INNER JOIN departments AS x ON (x.dept_no=y.dept_no)
WHERE dept_name = 'Sales' OR dept_name = 'Development';

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
-- groupby of last names

SELECT 
	last_name AS "Last Name", 
	COUNT(last_name) AS "Frequency Count"
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC; 



