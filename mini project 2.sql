use accure;
create table employ11(
id int primary key,
name varchar(20), 
age int, 
dept varchar(20), 
salary decimal(10,2)
);

insert into employ11(id, name, age, dept, salary) values
(1,'Rohit',29,'IT',20000);
insert into employ11(id, name, age, dept, salary) values
(2,'Akshay',28,'HR',25000),
(3,'Shree',22,'CNC',30000),
(4,'Shubham',28,'NTC',35000),
(5,'Ojas',32,'HR',50000),
(6,'Pritam',28,'Finance',25000),
(7,'Raju',31,'CS',25000),
(8,'Omkar',30,'IT',25000),
(9,'Deepak',32,'CNC',25000),
(10,'Nitin',34,'Finance',25000);

select * from employ11;

select * from employ11 where salary >30000;

select * from employ11 where name like 'A%';

select * from employ11 order by salary desc;

------------------------------------------------------
CREATE TABLE Employees97 (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100) NOT NULL,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments97(DeptID)
);

INSERT INTO Employees97 (EmpID, EmpName, DeptID) VALUES
(101, 'Amit Sharma', 3),
(102, 'Neha Patil', 2),
(103, 'Samir Khan', 4),
(104, 'Riya Deshmukh', 1);

INSERT INTO Employees97 (EmpID, EmpName, DeptID) VALUES
(105, 'Jiya rane', 3);
INSERT INTO Employees97 (EmpID, EmpName, DeptID, Salary, Age) VALUES
(106, 'Karan Joshi', 2, 45000, 32),
(107, 'Pooja Mane', 1, 38000, 34),
(108, 'Nikhil Pawar', 3, 52000, 29),
(109, 'Sanjay Kulkarni', 4, 60000, 41),
(110, 'Megha Bhosale', 2, 42000, 36),
(111, 'Rohit Shelar', 1, 31000, 27),
(112, 'Priya Jadhav', 3, 48000, 33),
(113, 'Vikas Desai', 4, 55000, 45),
(114, 'Sneha Kamat', 1, 39000, 31),
(115, 'Mahesh More', 2, 51000, 38);


alter table employees97 add column salary decimal(10,2);
update employees97
set salary =20000
where empid=105;

alter table employees97 add column Age int;

UPDATE Employees97 
SET Age = 28
WHERE EmpID = 101;

UPDATE Employees97 
SET Age = 25
WHERE EmpID = 102;

UPDATE Employees97 
SET Age = 30
WHERE EmpID = 103;

UPDATE Employees97 
SET Age = 24
WHERE EmpID = 104;

UPDATE Employees97 
SET Age = 27
WHERE EmpID = 105;


select * from employees97;

create table departments97 (
    deptid int primary key auto_increment,
    deptname varchar(100) not null
);

insert into Departments97 (DeptName) values
('HR'),
('Finance'),
('IT'),
('Operations');

create table projects97 (
    projectid int primary key auto_increment,
    projectname varchar(150) not null,
    deptid int,
    foreign key (deptid) references departments97(deptid)
);

insert into Projects97 (ProjectName, DeptID) values
('Website Upgrade', 3),
('Payroll Automation', 2),
('Recruitment System', 1),
('Logistics Optimization', 4);

create table employeeprojects97 (
    empprojectid int primary key auto_increment,
    empid int not null,
    projectid int not null,
    assigneddate date,
    foreign key (projectid) references projects97(projectid)
);

insert into EmployeeProjects97 (EmpID, ProjectID, AssignedDate) values
(101, 1, '2024-01-10'),
(102, 2, '2024-02-05'),
(101, 3, '2024-03-12'),
(103, 4, '2024-04-01');

-- Retrieve list of employees with their department names.

select e.EmpID, e.EmpName, e.DeptID, d.deptname
from employees97 e
join departments97 d
on d.deptid=e.deptid;

-- Get employees who are not assigned to any project.
   select  e.EmpID, e.EmpName, e.DeptID
   from employees97 e 
   left join EmployeeProjects97 e2
   on e.empid=e2.empid
 where e2.empid is null;
 
-- List all employees and their projects (including those without a project).

select  e.EmpID, e.EmpName, e.DeptID, p.projectname
   from employees97 e 
   left join EmployeeProjects97 e2
   on e.empid=e2.empid
   left join projects97 p 
   on e2.ProjectID = p.ProjectID;





