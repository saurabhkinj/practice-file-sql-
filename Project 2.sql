
create table employee (
    emp_id int primary key,
    emp_name varchar(100),
    department varchar(50),
    salary int,
    doj date,
    manager_id int
);

insert into employee values
(1, 'ramesh',  'it',    75000, '2020-01-15', null),
(2, 'suresh',  'it',    55000, '2021-03-10', 1),
(3, 'mahesh',  'it',    45000, '2022-07-01', 1),

(4, 'rajesh',  'hr',    40000, '2019-05-20', null),
(5, 'kiran',   'hr',    52000, '2021-08-12', 4),
(6, 'kiran',   'hr',    52000, '2021-08-12', 4), 

(7, 'anita',   'finance',60000, '2020-11-30', null),
(8, 'pooja',   'finance',48000, '2022-02-14', 7),
(9, 'vikas',   'finance',70000, '2023-06-18', 7),

(10, 'sunil',  'sales', 30000, '2018-04-05', null),
(11, 'amit',   'sales', 45000, '2021-09-09', 10),
(12, 'neha',   'sales', 65000, '2022-12-01', 10),

(13, 'rohit',  'it',    85000, '2023-01-10', 1),
(14, 'deepa',  'hr',    38000, '2020-06-25', 4),
(15, 'arjun',  'finance',52000, '2021-04-17', 7);

insert into employee values(16, 'kiran',   'hr',    52000, '2021-08-12', 4);

select * from employee;


-- 1.display all employee
   select * from employee;
   
-- 2.find employee working in IT dept
    select * from employee
    where department='IT';
    
-- index on employee(department)
    create index idx_employee_department on employee(department);

    
-- 3.show employee with salary greter then 50k
   select * from employee
   where salary > 50000;
   
-- index on employee(salary)
   create index idx_employee_salary on employee(salary);
   
   
-- 4.count total employee
    select count(emp_id) as total_employee from employee;
    
-- 5.find avg salary per department
    select department ,avg(salary) as avg_salary from employee
    group by department;
    
-- 6.find highst sal in each department
   select department,max(salary) as highest_salary 
   from employee 
   group by department
   order by highest_salary desc;
   
-- 7.find employee who join after 2021
   select * from employee where doj >= '2022-01-01';
   
-- index on employee(doj)
   create index idx_employee_doj on employee(doj);
   
   
-- 8.find employee without manger
    select * from employee 
    where manager_id is null;
    
-- index on employee(manager_id)
    create index idx_employee_manager on employee(manager_id);

    
-- 9.find employee name along with there manger name
	select e2.emp_name as employee, e1.emp_name as manager_name, e2.manager_id
	from employee e2
	left join employee e1
	on e1.emp_id = e2.manager_id;

-- index on employee(emp_id)
   create index idx_employee_emp_id on employee(emp_id);
   
     
-- 10.find 2nd highest salary
    select max(salary)from employee where salary <(select max(salary) from employee);
    
-- 11.rank employee by salary within department
   select emp_id,emp_name, department, rank() over(partition by department order by salary asc) as rank_by_department from employee;   
  

-- 12.find department having more then 2 employee
	  select department,count(emp_id) as total_emp_by_dept
	  from employee
	  group by department
	  having count(emp_id) >2;
  
  
-- 13.find employee earning more then department avg
	   select emp_id,emp_name, department, salary from
	   (select emp_id,emp_name, department, salary, avg(salary) over(partition by department) as dept_avg_sal from employee) as t
	   where salary > dept_avg_sal; 
    
    
-- 14.find 1st employee who join in each dept
	  select emp_id,emp_name, department, salary,doj from
	  (select emp_id,emp_name, department, salary, doj, row_number() over(partition by department order by doj) as rn from employee) as s
	  where rn=1;
   
   
-- 15.delete duplicate emp 

-- its show only duplicate value

	/*select emp_id, emp_name, department from
	(select emp_id, emp_name, department, salary, doj,  row_number() over (partition by emp_name, department, salary, doj order by emp_id ) as rn
	from employee
	) n 
	where rn > 1;*/

	delete from employee
	where emp_id in (select emp_id from (select emp_id, row_number() over (partition by emp_name, department, salary, doj order by emp_id ) as rn
	from employee) t
	where rn > 1);

-- select * from employee;




