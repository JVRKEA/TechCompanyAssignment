-- Single Table Assignments
-- 1: Find the employee number for employees named MARTIN.
SELECT employee_number
FROM employees
WHERE employee_name = 'MARTIN';
-- 2: Find the employee(s) with a salary greater than 1500.
SELECT *
FROM employees
WHERE salary > 1500;
-- 3: List the names of salesmen that earn more than 1300.
SELECT employee_name
FROM employees
WHERE job_title = 'SALESMAN' AND salary > 1300;
-- 4: List the names of employees that are not salesmen.
SELECT employee_name
FROM employees
WHERE job_title <> 'SALESMAN';
-- 5: List the names of all clerks together with their salary with a deduction of 10%.
SELECT employee_name, salary * 0.9 AS salary_after_deduction
FROM employees
WHERE job_title = 'CLERK';
-- 6: Find the name of employees hired before May 1981.
SELECT employee_name
FROM employees
WHERE hire_date < '1981-05-01';
-- 7: List employees sorted by salary in descending order (i.e. highest salary first).
SELECT *
FROM employees
ORDER BY salary DESC;
-- 8: List departments sorted by location.
SELECT *
FROM departments
ORDER BY office_location;
-- 9: Find name of the department located in New York.
SELECT department_name
FROM departments
WHERE office_location = 'NEW YORK';
-- 10: You have proven your worth at the company. Your colleague comes to you trying to remember what's-his-name. It starts with a J and ends with S. Can you help her?
SELECT employee_name
FROM employees
WHERE employee_name LIKE 'J%S';
-- 11: Maybe that wasn't helpful. "Oh yeah, I remember now!" they say and tell you that he is a manager.
SELECT employee_name
FROM employees
WHERE employee_name LIKE 'J%S' AND job_title = 'MANAGER';
-- 12: How many employees are there in each department?
SELECT department_number, COUNT(*) AS employee_count
FROM employees
GROUP BY department_number;

-- Aggregate functions
-- 1: List the number of employees.
SELECT COUNT(*) AS number_of_employees
FROM employees;
-- 2: List the sum of all salaries (excluding commission).
SELECT SUM(salary) AS total_salaries
FROM employees;
-- 3: List the average salary for employees in department 20.
SELECT AVG(salary) AS average_salary
FROM employees
WHERE department_number = 20;
-- 4: List the unique job titles in the company.
SELECT DISTINCT job_title
FROM employees;
-- 5: List the number of employees in each department.
SELECT department_number, COUNT(*) AS employee_count
FROM employees
GROUP BY department_number;
-- 6: List in decreasing order the maximum salary in each department together with the department number.
SELECT department_number, MAX(salary) AS max_salary
FROM employees
GROUP BY department_number
ORDER BY max_salary DESC;
-- 7: List total sum of salary and commission for all employees.
SELECT SUM(salary + IFNULL(commission, 0)) AS total_salary_and_commission
FROM employees;

-- Join Assignments
-- 1: Create an INNER JOIN between employees and departments to get the department name for each employee. Show all columns.
SELECT employees.*, departments.department_name
FROM employees
INNER JOIN departments
ON employees.department_number = departments.department_number;
-- 2: Continue from the last task. Show two columns. The employee_name and their corresponding department_name. Oh, and can you sort them alphabetically (A-Z)?
SELECT employees.employee_name, departments.department_name
FROM employees
INNER JOIN departments
ON employees.department_number = departments.department_number
ORDER BY employees.employee_name ASC;
-- 3: Now is the time to make a LEFT JOIN. Let's look at employee_name and department_name only. There is one more person this time who didn't show in the previous query. Who is it and why?
SELECT employees.employee_name, departments.department_name
FROM employees
LEFT JOIN departments
ON employees.department_number = departments.department_number
ORDER BY employees.employee_name ASC;
-- det er king fordi han ikke er tilsluttet en afdeling. Og han blev ikke vist før fordi det kun var medarbejderer i en afdeling.

-- 4: Consider this query: One department is missing. Which one and why? (Look in the database).
SELECT departments.department_name, COUNT(employees.employee_number)
FROM employees
         JOIN departments
              ON departments.department_number = employees.department_number
GROUP BY department_name;
-- Det er afdelingen "Operations" der mangler og det gør den fordi den ikke har nogle medarbejdere tilknyttet den afdeling.

-- 5: To get the missing department change the previous query to use a RIGHT JOIN.
SELECT departments.department_name, COUNT(employees.employee_number) AS employee_count
FROM employees
RIGHT JOIN departments
ON departments.department_number = employees.department_number
GROUP BY departments.department_name;
-- 6: SCOTT sends you this query and asks you to run it. In order to assess whether it is information that SCOTT is privy to, you must first understand it. Describe in technical terms what this query does:
SELECT *
FROM employees employee
         JOIN employees manager
              ON employee.manager_id = manager.employee_number
ORDER BY employee.employee_name;

-- den giver alle columns for medarbejderne som har en manager, og så joiner den hver medarbejder med deres manager's informationer og sorterer efter medarbejdernes navn.

-- 7: Get two columns: employees and their managers.
SELECT employee.employee_name AS employee, manager.employee_name AS manager
FROM employees employee
JOIN employees manager
ON employee.manager_id = manager.employee_number;
-- 8: Use the HAVING keyword (feel free to look it up) to show the departments with more than 3 employees. The as number_of_employees is so that you can reference the value later on in the query:
SELECT employees.department_number, COUNT(employees.department_number) AS number_of_employees
FROM employees
GROUP BY department_number
HAVING number_of_employees > 3;
-- 9: Subquery time! Select the name and salary of employees whose salary is above average: WHERE salary > (SELECT AVG(salary) FROM employees)
SELECT employee_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Join Table (Many-to-many)
-- 1: Create a new table called leaders and insert rows into it.
CREATE TABLE leaders (
leader_id INTEGER PRIMARY KEY,
leader_name VARCHAR(30)
);
INSERT INTO leaders (leader_id, leader_name) VALUES (1, 'Julius');
INSERT INTO leaders (leader_id, leader_name) VALUES (2, 'Luka');
-- 2: Create a new table called employees_leaders that should link the employees and leaders tables.
CREATE TABLE employees_leaders (
employee_number INTEGER,
leader_id INTEGER,
PRIMARY KEY (employee_number, leader_id),
FOREIGN KEY (employee_number) REFERENCES employees(employee_number),
FOREIGN KEY (leader_id) REFERENCES leaders(leader_id)
);
-- 3: Create rows in employees_leaders that link employees to their respective leaders.
INSERT INTO employees_leaders (employee_number, leader_id) VALUES (7369, 1);
INSERT INTO employees_leaders (employee_number, leader_id) VALUES (7876, 1);
INSERT INTO employees_leaders (employee_number, leader_id) VALUES (7499, 2);
INSERT INTO employees_leaders (employee_number, leader_id) VALUES (7499, 1);
-- 4: Create a many-to-many query between employees and leaders. It requires two JOIN statements. First you select from employees, then you join with employees_leaders, and finally you join again with leaders.
SELECT employees.employee_name, leaders.leader_name
FROM employees
JOIN employees_leaders ON employees.employee_number = employees_leaders.employee_number
JOIN leaders ON employees_leaders.leader_id = leaders.leader_id
ORDER BY employees.employee_name, leaders.leader_name;
