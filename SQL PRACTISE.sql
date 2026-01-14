-- Customers table
CREATE TABLE Customers3 (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50)
);

INSERT INTO Customers3 VALUES
(1, 'Alice', 'New York'),
(2, 'Bob', 'Los Angeles'),
(3, 'Charlie', 'Chicago'),
(4, 'David', 'Houston'),
(5, 'Eve', 'Phoenix'),
(6, 'Frank', 'Philadelphia'),
(7, 'Grace', 'San Antonio'),
(8, 'Heidi', 'San Diego'),
(9, 'Ivan', 'Dallas'),
(10, 'Judy', 'San Jose');

-- Products table
CREATE TABLE Products3 (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

INSERT INTO Products3 VALUES
(1, 'Laptop', 'Electronics', 1000.00, 10),
(2, 'Phone', 'Electronics', 500.00, 0),
(3, 'Tablet', 'Electronics', 300.00, 5),
(4, 'Chair', 'Furniture', 150.00, 0),
(5, 'Desk', 'Furniture', 200.00, 3),
(6, 'Pen', 'Stationery', 2.00, 100),
(7, 'Notebook', 'Stationery', 5.00, 0),
(8, 'Monitor', 'Electronics', 250.00, 4),
(9, 'Lamp', 'Furniture', 35.00, 2),
(10, 'Backpack', 'Accessories', 45.00, 1);

-- OrderDetails table
CREATE TABLE OrderDetails3 (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers3(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products3(ProductID)
);

INSERT INTO OrderDetails3 VALUES
(1, 1, 1, 1, '2023-01-01'),
(2, 2, 3, 2, '2023-01-10'),
(3, 3, 6, 10, '2023-01-15'),
(4, 4, 5, 1, '2023-01-20'),
(5, 5, 8, 1, '2023-02-01'),
(6, 6, 10, 1, '2023-02-10'),
(7, 7, 1, 1, '2023-03-01'),
(8, 8, 6, 5, '2023-03-10'),
(9, 9, 3, 1, '2023-03-15'),
(10, 1, 2, 1, '2020-01-01'); 
insert into OrderDetails3 values (11, 2, 3, 1, '2022-01-01'); 


select distinct c.CustomerName 
from Customers3 c
join OrderDetails3 o 
on c.CustomerID=o.CustomerID;

select ProductName from Products3 where stock = 0;

select distinct c.CustomerName ,o.CustomerID
from Customers3 c
left join OrderDetails3 o 
on c.CustomerID=o.CustomerID
where o.CustomerID is null;


select * from products3 p1 where price =(select max(price) from products3 p2 where p1.Category=p2.Category);

select o.orderid, SUM(O.Quantity * P.Price) AS TotalOrderValue
from products3 p 
join orderdetails3 o
on p.ProductID=o.ProductID
group by o.orderid;

select city ,count(*) as custcount
from customers3
group by city 
order by custcount desc
limit 2;

update products3 set stock = 1 where ProductID=2 ;

select p.Category, sum(o.Quantity * p.price) as revenue
from products3 p
join orderdetails3 o
on p.ProductID=o.ProductID
group by p.Category;

savepoint p1;

delete from OrderDetails3 where OrderDate < (CURRENT_DATE - INTERVAL 5 year);

select * from OrderDetails3;

rollback ;

delimiter $$

create trigger trg_update_stock_after_order
after insert on OrderDetails3
for each row
begin
    update Products3
    set Stock = Stock - new.Quantity
    where ProductID = new.ProductID;
end; $$

delimiter ;

select * from Products3;

use accure;
CREATE TABLE windows21 (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    join_date DATE
);
INSERT INTO windows21 (emp_id, emp_name, department, salary, join_date) VALUES
(1, 'Amit', 'IT', 60000, '2020-01-10'),
(2, 'Neha', 'IT', 65000, '2021-03-15'),
(3, 'Ravi', 'IT', 60000, '2022-06-20'),
(4, 'John', 'HR', 50000, '2019-02-11'),
(5, 'Swati', 'HR', 70000, '2023-08-01'),
(6, 'Meera', 'Finance', 55000, '2021-11-12'),
(7, 'Raj', 'Finance', 60000, '2020-07-25'),
(8, 'Pooja', 'Finance', 55000, '2023-01-05'),
(9, 'Karan', 'IT', 72000, '2018-04-03'),
(10, 'Vikas', 'HR', 50000, '2020-09-14');

select * from windows21;

select emp_id, emp_name, department, salary,
row_number() over(order by emp_id) as row_numm
from windows21;

use accure;

select emp_id, emp_name, department, salary,
rank() over(partition by department order by salary) as row_numm
from windows21;

select emp_id, emp_name, department, salary,
dense_rank() over(partition by department order by salary) as row_numm
from windows21;

select emp_id, emp_name, department,salary,
lag(salary,1) over(order by emp_id) as prv_amount
from windows21;

select emp_id, emp_name, department,salary,
lead(salary,2) over(order by salary) as prv_amount
from windows21;

-- Stored procedure
delimiter $$

create procedure demo()
begin
   select * from windows21;
end $$

delimiter ;   

call demo();

delimiter $$

create procedure dept_name(in dept varchar(20))
begin
    select * from windows21
    where department= dept;
 end $$
 
 delimiter ;
 
 call dept_name('hr');
 
 delimiter $$
 create procedure total_salary(in dept1 varchar(20) , out dept_sal int)
 begin
   select sum(salary) into dept_sal
   from windows21
   where department = dept1;
   
  end $$
  delimiter ;
  
  call total_salary('hr',@dept_sal);
  select @dept_sal;
   
   drop procedure total_salary;
   
   delimiter $$
   create procedure emp_status(in emp_idd int)
   begin
	   declare emp_sal int;
	   select salary into emp_sal
	   from windows21
	   where emp_id= emp_idd;
   
	   if emp_sal > 55000 then 
		select 'high salary' as statuss;
	   else 
		select 'low salary' as statuss;
	end if;
   end $$
   delimiter ;
   
   call emp_status(4);
   
   select * from windows21;
   
   -- functions
   
   delimiter $$
   create function get_bonuss(sal int)
   returns int
   deterministic
   begin 
    declare bonus int;
    set bonus = sal * .10;    
    
    return bonus;
    end $$
delimiter ;

select emp_id, get_bonuss(salary) from windows21;

DELIMITER $$

CREATE FUNCTION salary_grade(sal INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    IF sal > 70000 THEN
        RETURN 'High';
    ELSEIF sal > 40000 THEN
        RETURN 'Medium';
    ELSE
        RETURN 'Low';
    END IF;
END $$

DELIMITER ;

SELECT emp_name, salary, salary_grade(salary) AS grade
FROM windows21;

-- trigger
use accure;
   create table emp_log(
   emp_id int,
   remark varchar(20),
   log_time datetime
   );
   
   alter table emp_log modify remark varchar(60);
   drop table emp_log;
   
DELIMITER $$

CREATE TRIGGER emp_insert_log
AFTER INSERT ON windows21
FOR EACH ROW
BEGIN
    INSERT INTO emp_log(emp_id, remark, log_time)
    VALUES (NEW.emp_id, concat(new.emp_name,' - New Employee Added'), NOW());
END $$

DELIMITER ;

drop trigger emp_insert_log;

INSERT INTO windows21 (emp_id, emp_name, department, salary, join_date) VALUES
(11, 'saurabhh', 'IT', 10000, '2020-01-10');

INSERT INTO windows21 (emp_id, emp_name, department, salary, join_date) VALUES
(12, 'akshay', 'mech.', 250000, '2020-01-10');

INSERT INTO windows21 (emp_id, emp_name, department, salary, join_date) VALUES
(13, 'silky', 'airport', 220000, '2020-01-10');

select * from windows21;

   
select * from emp_log;
use accure;
explain select * from emp_log;
select count(*) from emp_log;
explain analyze select * from windows21;
use accure;

-- CTE

select * from windows21;

with wind_cte as (
select emp_id,emp_name,salary
from windows21
where salary >=60000
)
select * from wind_cte;


WITH HighSalary AS (
    SELECT emp_id, emp_name ,salary FROM windows21 WHERE salary > 60000
),
LowSalary AS (
    SELECT emp_id, emp_name, salary FROM windows21 WHERE salary < 60000
)
SELECT * FROM HighSalary
UNION ALL
SELECT * FROM LowSalary;

-- recursive

with recursive my_cte as (
select 2 as n
union all
select n + 2 from my_cte
where n < 5
)
select * from my_cte;


CREATE TABLE emp202 (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    manager_id INT NULL
);

INSERT INTO emp202 VALUES
(1, 'CEO', NULL),
(2, 'Manager1', 1),
(3, 'Manager2', 1),
(4, 'TeamLead1', 2),
(5, 'TeamLead2', 2),
(6, 'Developer1', 4),
(7, 'Developer2', 4),
(8, 'Analyst1', 3),
(9, 'Analyst2', 3);

select * from emp202;

with recursive empcte as (
select emp_id, emp_name, manager_id
from emp202
where emp_id=2

union all

select e.emp_id, e.emp_name ,e.manager_id
from emp202 e
join empcte 
on e.manager_id=empcte.emp_id
)
select * from empcte;


use accure;

select * from windows21;
update windows21
set salary=66000
where emp_id=1;

commit;
update windows21
set salary=67000
where emp_id=3;

rollback;
start transaction;

update windows21
set salary=66000
where emp_id=2;

select * from windows21;

commit;

update windows21
set salary=58000
where emp_id=4;

rollback;
select * from windows21;


start transaction;

update windows21
set salary = 98000
where emp_id= 5;

rollback;
select * from windows21;

start transaction;

update windows21
set salary =12000
where emp_id= 6;

select * from windows21;
INSERT INTO windows21 (emp_id, emp_name, department, salary, join_date) VALUES
(14, 'ram', 'IT', 30000, '2020-01-10');
commit;

INSERT INTO windows21 (emp_id, emp_name, department, salary, join_date) VALUES
(15, 'shyam', 'IT', 20000, '2020-01-10');

rollback;

update windows21
set salary =67600
where emp_id= 11;
commit;

update windows21
set salary =67633
where emp_id= 13;

rollback;

use accure;
select * from employees97;

explain select * from employees97;

explain select * from employees97 where salary = 39000;
create index idx_sal on employees97(salary);


explain SELECT * FROM employees97 WHERE salary BETWEEN 40000 AND 60000;





