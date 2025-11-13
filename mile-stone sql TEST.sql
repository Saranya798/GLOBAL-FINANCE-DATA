## 6.Differentiate between DDL and DML commands with examples. 
-- 1- DDL : (DATA DEFINITION LANGUAGE) : 
-- Defines database structure and common commands are (CREATE,ALTER,TRUNCATE,DROP) and YES (changes or permanent).ex : CREATE TABLE Employee(....)
-- 2 - DML : (DATA MANIPULATION LANGUAGE) :
-- It manipulates within data and common commands are (SELECT,UPDATE,DELETE,INSERT) and NO (can be rolled back ) ex : INSERT TABLE Employee (values)

## 7 Write a query to fetch the second highest salary from an employee table.
CREATE TABLE employee (id INT, name VARCHAR(50));
INSERT INTO employee VALUES (1, 'Amit');
SELECT MAX(salary)
FROM employee ;

## 8 Explain the difference between INNER JOIN and LEFT JOIN with an example. 
-- 1-INNER JOIN : (Only mathching the both rows). EX: Employees with assigned departments
-- 2-LEFT JOIN : (All rows from left table + matches). EX : All employees, even those without departments

## 9 What is a Trigger in MySQL? Give a use case.
 -- A trigger is a stored program that executes automatically in response to events(INSERT,UPDATE,DELETE)
CREATE TRIGGER log_update
AFTER UPDATE ON employee
FOR EACH ROW INSERT INTO audit_log(emp_id, old_salary, new_salary)
VALUES (OLD.id, OLD.salary, NEW.salary);

## 10 Why is  Normalization important? Explain with an example. 
-- Normalization it organizes data for  reduce redundancy and then improve integrity.because 
-- It breaks large tables into smaller or related ones.
-- EX : Employee ID, Name, Department 
 
 
 
       ##### PART(C)
       
 ## A company database has the following tables: 
-- employees(emp_id, emp_name, dept_id, salary, hire_date)
-- departments(dept_id, dept_name)
-- attendance(a_id, emp_id, a_date, status) -- Answer the following in sequence (each part builds on the previous one): 
### a) Write a  DDL command to create the departments table with dept_id as Primary Key and dept_name as NOT NULL.
DROP DATABASE departments;
CREATE DATABASE departments ;
USE departments ;
CREATE TABLE departments (
  dept_id INT PRIMARY KEY,
  dept_name VARCHAR(50) NOT NULL );

### b) Insert two sample records into the departments table (e.g., Sales, IT). 
INSERT INTO departments (dept_id, dept_name)
VALUES (1, 'Sales'), (2, 'IT'), (3,'HR'), (4,'Finance') ;
	
### c) Write a query to display the  employee name and department name using a JOIN between employees and departments. 
SELECT e.emp_name, d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;

### d) Write a query to ﬁnd the  highest salary using an aggregate funcon.
SELECT MAX(salary) AS highest_salary
FROM employees;

### e) Write a  subquery to fetch the employees who earn more than the  average salary.
SELECT emp_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
 
## f) Create a  view named emp_salary_view to display emp_name, dept_name, salary.  
 CREATE VIEW emp_salary_view AS
SELECT e.emp_name, d.dept_name, e.salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;

## g) Write a  stored procedure named GetDeptEmployees that accepts a dept_id and returns all employee names in that department. 
DELIMITER //

CREATE PROCEDURE GetDeptEmployees(IN input_dept_id INT)
BEGIN
  SELECT emp_name
  FROM employees
  WHERE dept_id = input_dept_id;
END //

DELIMITER ;
CALL GetDeptEmployees(2);

## h) Write a u ser-deﬁned funcon YearWorked(hire_date) that calculates the number of years an employee has worked in the company
CREATE FUNCTION YearWorked(hire_date DATE) 
RETURNS INT
DETERMINISTIC ;
BEGIN 
RETURN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) ;

SELECT emp_name, YearWorked(hire_date) AS years_worked FROM employees;

## i) Create a  trigger that automacally inserts a record into aendance table with status = 'Present' whenever a new employee is added.
 CREATE TRIGGER insert_attendance
AFTER INSERT ON employees
FOR EACH ROW ;
BEGIN;
INSERT INTO attendance (emp_id, a_date, status) 
VALUES (NEW.emp_id, CURDATE(), 'Present') ;


## j) Write a query using  string funcon to display employee names in uppercase. 
SELECT UPPER(emp_name) AS emp_name_upper
FROM employees;

