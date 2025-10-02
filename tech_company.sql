CREATE DATABASE IF NOT EXISTS tech_company DEFAULT CHARACTER SET utf8;
USE tech_company;
DROP TABLE if exists employees;
DROP TABLE if exists departments;

CREATE TABLE departments (	
	department_number INTEGER,
	department_name VARCHAR(30),
	office_location VARCHAR(30),
	PRIMARY KEY (department_number)
); 

CREATE TABLE employees (	
	employee_number INTEGER,
	employee_name VARCHAR(30),
	job_title VARCHAR(30),
	manager_id INTEGER,
	hire_date DATE,
	salary DECIMAL(10,2),
	commission DECIMAL(10,2),
	department_number INTEGER,
	PRIMARY KEY (employee_number),
	FOREIGN KEY (department_number) REFERENCES departments(department_number)
);
 

INSERT INTO departments (department_number, department_name, office_location) VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO departments (department_number, department_name, office_location) VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO departments (department_number, department_name, office_location) VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO departments (department_number, department_name, office_location) VALUES (40, 'OPERATIONS', 'BOSTON');

INSERT INTO employees (employee_number, employee_name, job_title, manager_id, hire_date, salary, commission, department_number) VALUES (7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800, NULL, 20);
INSERT INTO employees (employee_number, employee_name, job_title, manager_id, hire_date, salary, commission, department_number) VALUES (7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30);
INSERT INTO employees (employee_number, employee_name, job_title, manager_id, hire_date, salary, commission, department_number) VALUES (7521, 'WARD', 'SALESMAN', 7698, '1981-02-22',  1250, 500, 30);
INSERT INTO employees (employee_number, employee_name, job_title, manager_id, hire_date, salary, commission, department_number) VALUES (7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975, NULL, 20);
INSERT INTO employees (employee_number, employee_name, job_title, manager_id, hire_date, salary, commission, department_number) VALUES (7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30);
INSERT INTO employees (employee_number, employee_name, job_title, manager_id, hire_date, salary, commission, department_number) VALUES (7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30);
INSERT INTO employees (employee_number, employee_name, job_title, manager_id, hire_date, salary, commission, department_number) VALUES (7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10);
INSERT INTO employees (employee_number, employee_name, job_title, manager_id, hire_date, salary, commission, department_number) VALUES (7788, 'SCOTT', 'ANALYST', 7566, '1987-04-19', 3000, NULL, 20);
INSERT INTO employees (employee_number, employee_name, job_title, manager_id, hire_date, salary, commission, department_number) VALUES (7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, NULL);
INSERT INTO employees (employee_number, employee_name, job_title, manager_id, hire_date, salary, commission, department_number) VALUES (7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30);
INSERT INTO employees (employee_number, employee_name, job_title, manager_id, hire_date, salary, commission, department_number) VALUES (7876, 'ADAMS', 'CLERK', 7788, '1987-05-23', 1100, NULL, 20);
INSERT INTO employees (employee_number, employee_name, job_title, manager_id, hire_date, salary, commission, department_number) VALUES (7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 30);
INSERT INTO employees (employee_number, employee_name, job_title, manager_id, hire_date, salary, commission, department_number) VALUES (7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, NULL, 20);
INSERT INTO employees (employee_number, employee_name, job_title, manager_id, hire_date, salary, commission, department_number) VALUES (7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10);

COMMIT;