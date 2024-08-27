Create table departments(
dept_no varchar(5) primary key,
dept_name VARCHAR(30)
);


Create table dept_emp(
emp_no int, 
dept_no varchar(5),
PRIMARY KEY (emp_no, dept_no),
Foreign key(dept_no) references departments(dept_no)
);


CREATE TABLE dept_manager(
dept_no VARCHAR(5),
emp_no INT,
FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
FOREIGN KEY (dept_no, emp_no) REFERENCES dept_emp(dept_no, emp_no)
);


CREATE TABLE Employees(
emp_no int Primary key,
emp_title_id varchar(10),
birth_date date,
first_name varchar(30),
last_name varchar(30),
sex varchar(2),
hire_date date
);

Create table salaries(
emp_no int,
salary int,
foreign key (emp_no) references Employees(emp_no)
);

Create table titles(
title_id varchar(10),
title varchar(30)
);

-- Data Analysis
-- List the employee number, last name, first name, sex, and salary of each employee.
Select e.emp_no, e.first_name, e.last_name, e.sex, s.salary 
from Employees as e
join salaries as s on 
e.emp_no = s.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986.
select e.first_name, e.last_name, e.hire_date 
From Employees as e
where extract(year from e.hire_date) = 1986;

-- List the manager of each department along with their department number, department name, employee number, last name, and first name.
select dept_manager.dept_no, departments.dept_name, e.emp_no, e.first_name, e.last_name
from Employees as e 
join dept_manager on
e.emp_no = dept_manager.emp_no
join departments on 
dept_manager.dept_no = departments.dept_no;

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
select d.dept_no, e.first_name, e.last_name, e.emp_no, d.dept_name 
from Employees as e
join dept_manager on
e.emp_no = dept_manager.emp_no
join departments as d on 
dept_manager.dept_no = d.dept_no;

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
select e.first_name, e.last_name, e.sex from employees as e
where first_name = 'Hercules' 
AND last_name LIKE 'B%';

-- List each employee in the Sales department, including their employee number, last name, and first name.
select e.emp_no, e.first_name, e.last_name from employees as e
join dept_emp on 
dept_emp.emp_no = e.emp_no
join departments as d on
d.dept_no = dept_emp.dept_no
where d.dept_name = 'Sales';

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
select e.emp_no, e.first_name, e.last_name from employees as e
join dept_emp on 
dept_emp.emp_no = e.emp_no
join departments as d on
d.dept_no = dept_emp.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;

