-- problem Statements 
-- 1. Find employees whose salary is above the average salary.
use accure;
select * from employees97 where salary > ( select avg(salary) from employees97);
 
-- 2. Get employee details whose department has the maximum employees.
    select * from employees97 where deptid=
    (    
    select count(empid) from employees97
    group by deptid
    order by deptid asc
    limit 1);
 
-- 3. Find project names where more than 3 employees are assigned.

select ProjectName
from Projects97
where ProjectID in (
    select ProjectID
    from EmployeeProjects97
    group by ProjectID
    having COUNT(EmpID) > 0
);
