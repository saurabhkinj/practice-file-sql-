create database accure;
use accure;
create table employee09(
empid int primary key auto_increment,
empname varchar(20),
salary decimal(10,2),
email varchar(100),
doj date
);

insert into employee09(empname,salary,email,doj)
values
('Saurabh',10000.00,'saurabhkinjlkar@gmail.com','2025-11-04');
select * from employee09;

insert into employee09(empname,salary,email,doj)
values
('shubham',20000.00,'shubhamb@gmail.com','2024-11-04'),
('rohit',30000.00,'rohits@gmail.com','2024-12-06'),
('akshay',70000.00,'akshayk@gmail.com','2023-01-09');

show databases;
select empname, salary from employee09;
select * from employee09 where salary > 20000;
select * from employee09 where salary between 10000 and 30000;
select * from employee09 where empname like 's%';
select * from employee09 order by salary desc;
select count(*) as total_employees from employee09;
select max(salary) as max_salary from employee09;
select avg(salary) as avg_salary from employee09;
select * from employee09 where year(doj) < 2024;


select * from employee09 where salary = 20000;

use accure;
select * from employee09;

-- filtering data
select * from employee09 where salary=20000;
select * from employee09 where salary>20000;
select * from employee09 where salary<20000;
select * from employee09 where salary!=20000;
select * from employee09 where salary between 10000 and 30000;
select * from employee09 where salary in (10000,20000);

-- sorting-- 

select * from employee09 order by salary desc;
select * from employee09 order by salary asc;

-- limit/top
select salary from employee09 order by salary asc limit 2;  -- top not support mysql

-- alise
select salary as best_sal from employee09; 

-- String functions (CONCAT, UPPER, LOWER, TRIM)

select concat(empname,salary) from employee09; 
select upper(empname) as name_in_uppercase from employee09;
select lower(empname) as name_in_lowercase from employee09;
select trim(' saurabh ') as final;
select ltrim('  saurabh  ') as final;
select rtrim('  saurabh  ') as final;

-- Date functions (NOW, DATEPART, DATEDIFF, EXTRACT)

select now(); 

use accure;
select datepart(year, doj) as current_yr from employee09; -- datepart not support mysql

select year(doj) as current_yr from employee09;  -- datepart not support mysql

select datediff(now() ,doj) as diffrence from employee09;
select extract(month from doj) as months from employee09;

-- Numeric functions (ROUND, ABS, CEIL, FLOOR)
select round(salary) from employee09; 
select round(40.3);
select round(40.8);
select abs(-30);
select abs(70);
select ceil(30.6);
select ceil(30.1);
select floor(30.8);
select floor(30.1);


CREATE TABLE Employees011 (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2)
);
INSERT INTO Employees011 (emp_id, emp_name, dept_id, salary)
VALUES
(1, 'Saurabh', 101, 60000),
(2, 'Priya', 102, 55000),
(3, 'Amit', 101, 48000),
(4, 'Neha', 103, 70000),
(5, 'Ravi', 104, 50000);

CREATE TABLE Departments011 (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

INSERT INTO Departments011 (dept_id, dept_name, location)
VALUES
(101, 'IT', 'Pune'),
(102, 'HR', 'Mumbai'),
(103, 'Finance', 'Delhi'),
(105, 'Marketing', 'Chennai');

select e.emp_name, d.dept_name, max(e.salary)
from employees011 e
join departments011 d
on e.dept_id=d.dept_id
group by d.dept_name, e.emp_name
having d.dept_name = 'It';


select *
from employees011 e
left join departments011 d
on e.dept_id=d.dept_id;

select *
from employees011 e
right join departments011 d
on e.dept_id=d.dept_id;

select * 
from employees011 e
left outer join departments011 d
on e.dept_id=d.dept_id;

select * 
from employees011 e
right outer join departments011 d
on e.dept_id=d.dept_id;

select * 
from employees011 e
cross join departments011 d;


-- Show each employee’s name along with their department name.
-- List all employees, including those who are not assigned to any department.
-- Display all departments along with their employees, even if a department has no employees.
-- Show all possible combinations of employees and departments.
-- Find each department’s name and the highest salary among its employees.

create table department97 (
  dept_id int primary key,
  dept_name varchar(50)
);
insert into department97 (dept_id, dept_name) values
(10, 'HR'),
(20, 'IT'),
(30, 'Sales'),
(40, 'Marketing');

create table employee79 (
  emp_id int primary key,
  emp_name varchar(50),
  dept_id int,
  salary decimal(10,2),
  foreign key (dept_id) references department97(dept_id)
);

insert into employee79 (emp_id, emp_name, dept_id, salary) values
(1, 'Alice', 10, 50000),
(2, 'Bob', 20, 60000),
(3, 'Charlie', null, 45000),
(4, 'David', 30, 55000),
(5, 'Emma', 10, 52000);

-- Show each employee’s name along with their department name.
	select e.emp_name,d.dept_name
	from employee79 e
	inner join department97 d 
	on e.dept_id=d.dept_id;


-- List all employees, including those who are not assigned to any department.
use accure;
   select e.emp_name,d.dept_name
   from employee79 e
   left join department97 d
   on e.dept_id=d.dept_id;
   
-- Display all departments along with their employees, even if a department has no employees.
   select d.dept_name, e.emp_name
   from department97 d
   left join employee79 e
   on d.dept_id=e.dept_id;

-- Show all possible combinations of employees and departments.
   select e.emp_name,d.dept_name
   from employee79 e 
   cross join department97 d;
  
-- Find each department’s name and the highest salary among its employees.
   select d.dept_name ,e.emp_name ,max(e.salary)
   from department97 d 
   left join employee79 e 
   on d.dept_id=e.dept_id
   group by d.dept_name ,e.emp_name;
   
-- Show the employee name, department name, and salary for all employees working in the "HR" department.
   select e.emp_name, d.dept_name,e.salary
   from employee79 e 
   left join department97 d 
   on e.dept_id=d.dept_id   
   where d.dept_name='hr';

-- Display the names of employees who do not belong to any department.
    select e.emp_name
   from employee79 e 
   left join department97 d 
   on e.dept_id=d.dept_id  
   where d.dept_id is null;

-- List the departments that have more than one employee.
select count(d.dept_id) as total_emp,d.dept_name
from department97 d
left join employee79 e
on e.dept_id=d.dept_id
group by d.dept_name
having count(d.dept_id) > 1;

-- Show each department name along with the average salary of its employees.
    select d.dept_name, avg(e.salary)
    from department97 d 
    left join employee79 e 
    on d.dept_id=e.dept_id
    group by d.dept_name;

-- Display all employees whose salary is greater than the average salary of their department.
    select  e.emp_name, e.salary, d.dept_name
    from department97 d 
    left join employee79 e 
    on d.dept_id=e.dept_id    
    where e.salary > (select avg(salary) from employee79 where dept_id=e.dept_id);



-- Find the total salary of all employees.
   select sum(salary) from employee79;

-- Find the average salary of each department.
   select avg(e.salary) as avrage_sal,d.dept_name
   from employee79 e 
   join department97 d 
   on e.dept_id=d.dept_id
   group by d.dept_name;

-- Display the number of employees working in each department.
  select count(d.dept_id) ,d.dept_name
  from department97 d 
  left join employee79 e 
  on d.dept_id=e.dept_id
  group by d.dept_id;

-- Find the highest and lowest salary among all employees.
   select max(salary) as highest_sal,
   min(salary) as minimum_sal from employee79;

-- Display departments having total salary greater than 1,00,000.
select sum(e.salary), d.dept_name
from employee79 e 
join department97 d 
on e.dept_id=d.dept_id
group by d.dept_name
having sum(e.salary) > 60000;

use accure;

-- Find the average salary of all employees in the company.
   select avg(salary) from employee79;

-- Display the total salary paid to employees in each department.
   select sum(e.salary),d.dept_name
   from employee79 e 
   join department97 d 
   on e.dept_id=d.dept_id
   group by d.dept_name;

-- Find the number of employees who have a salary greater than 50,000.
   select count(emp_name) as emp_high_sal from employee79
   where salary > 50000;

-- Display the average salary of each department, and show only those departments having an average salary greater than 52,000.
 select avg(e.salary) as avg_sal,d.dept_name
 from employee79 e 
 join department97 d 
 on e.dept_id=d.dept_id
 group by d.dept_name
 having avg_sal > 52000;
 

-- Find the sum, average, minimum, and maximum salary of all employees in a single query.
 select sum(salary) as total_sal,
        avg(salary) as total_avg,
        min(salary) as minimum_sal,
        max(salary) as max_sal from employee79;
        
        
        use accure;
        
        select emp_name, salary,
        case
        when salary >= 55000 then 'high salary'
        when salary >= 50000 then 'medium salary'
        else 'low salary'
        end as category_sal
        from employee79;


  select student_name, marks,
	case
	   when marks >=90 then 'A'
	   when marks >=70 then 'B'
	   when marks >=50 then 'C'
   else 'fail'
   end as grade
   from students;
   
   CREATE TABLE EmployeesCase (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(30),
    Salary INT,
    Experience INT
);

INSERT INTO EmployeesCase (EmpID, EmpName, Department, Salary, Experience)
VALUES
(101, 'Raj', 'IT', 85000, 7),
(102, 'Neha', 'HR', 45000, 4),
(103, 'Amit', 'Finance', 25000, 2),
(104, 'Priya', 'IT', 60000, 5),
(105, 'Vikram', 'Sales', 30000, 1),
(106, 'Sneha', 'HR', 70000, 8),
(107, 'Rohan', 'Finance', 90000, 10);

select * from employeescase;

select empname , department, salary,
case
  when salary > 85000 then 'High salary'
  when salary > 50000 then 'medium salary'
  else 'low salary'
  end as sal_categary
  from employeescase;
  
  update employeescase
  set salary =
  case
    when department = 'HR' then salary + 5000
    when department = 'it' then salary + 7000
    when department = 'finance' then salary + 2000
    when department = 'sales' then salary + 1000
    else salary + 500
    end;
    
    select * from employeescase;


SELECT empname , department, salary ,Experience
FROM EmployeesCase
ORDER BY 
CASE
	WHEN Experience > 7 THEN 1
	WHEN experience > 3 THEN 2
	WHEN experience > 1 THEN 3
    ELSE 4
END,
Experience desc;


CREATE TABLE DDL (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Salary DECIMAL(10,2),
    Department VARCHAR(30)
);

INSERT INTO DDL (EmpID, EmpName, Salary, Department)
VALUES
(1, 'John Smith', 55000.00, 'HR'),
(2, 'Priya Sharma', 62000.00, 'Finance'),
(3, 'Amit Verma', 48000.00, 'IT'),
(4, 'Sneha Patil', 70000.00, 'Marketing'),
(5, 'David Lee', 53000.00, 'Operations');


alter table ddl add doj date;

select * from ddl2;
alter table ddl rename to ddl2;
alter table ddl2 drop column department;
truncate table ddl2;
drop table ddl2;
alter table ddl modify column department int;
alter table ddl modify column department varchar(20);
desc ddl;

insert into ddl (EmpID, EmpName, Salary, Department) values
(6,'saurabh',10000,'sql');
select * from ddl;

update ddl
set salary= 30000
where empid = 6;

delete from ddl where empid = 6;


use accure;
create table Constraints2
(
emp_id int primary key,
emp_name varchar(20) not null,
mobile_no int unique,
salary decimal(20,2) check (salary < 100000),
statuss varchar(20) default 'active',
dept_id int,
foreign key (dept_id) references depart(dept_id)
);


insert into Constraints2(emp_id,emp_name,mobile_no,salary,dept_id) 
values
(1,'saurabh',8983882,10000,101);
insert into Constraints2(emp_id,emp_name,mobile_no,salary,statuss,dept_id) 
values
(2,'sau',89838,10000,'disable',102);

select * from constraints2;

desc constraints2;

create table depart(
dept_id int primary key,
dept_name varchar(20)
);

insert into depart(dept_id,dept_name) values
(101,'IT'),
(102,'hr');

-- cluster
use accure;
CREATE TABLE Emp1 (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(20),
    salary INT,
    email VARCHAR(100)
);

INSERT INTO Emp1 (emp_id, name, department, salary, email) VALUES
(1, 'Amit', 'IT', 60000, 'amit@gmail.com'),
(2, 'Riya', 'HR', 45000, 'riya@gmail.com'),
(3, 'Sagar', 'IT', 75000, 'sagar@gmail.com'),
(4, 'Neha', 'Finance', 50000, 'neha@gmail.com'),
(5, 'Raj', 'IT', 65000, 'raj@gmail.com');

SELECT * FROM Emp1
WHERE salary > 60000;

CREATE INDEX idx_salary ON Emp1(salary);

SELECT * FROM Emp1
WHERE salary > 60000;
select * from em2;
SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/importcsvcode.csv'
INTO TABLE em2
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from em2;

CREATE TABLE importscvcc (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/importcsvcode.csv'
INTO TABLE importscvcc
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from importscvcc;


select * from jsonn1;

