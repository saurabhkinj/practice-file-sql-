-- Next project - 
-- 1. Count employees in each department. 

select d.deptname ,count(e.empid) as empll
from departments97 d 
join employees97 e 
on d.deptid=e.deptid
group by d.deptname;
 
-- 2. Show department with highest total salary.
select d.deptname ,max(e.salary)
from departments97 d
join employees97 e 
on e.deptid=d.deptid
group by d.deptname;
 
 
-- 3. Find average salary of employees who are older than 30.

select avg(salary) as count_only_older from employees97
where age > 30;
 
 
-- 4. List departments having more than 5 employees.

select d.deptname ,count(e.empid) as empll
from departments97 d 
join employees97 e 
on d.deptid=e.deptid
group by d.deptname
having empll > 1;

use accure;
select * from departments97;