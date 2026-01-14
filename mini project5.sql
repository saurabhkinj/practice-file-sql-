-- Based on index and query optimization - Next small project like 

-- 1. Create index on employee name; observe query performance difference.
-- 2. Optimize a join query with 1 lakh sample records.
-- 3. Compare performance with and without composite index.

create table depart94(
dept_id int primary key auto_increment,
dept_name varchar(20)
);
drop table depart94;
insert into depart94(dept_name) values ('HR'),
									   ('It'),
                                       ('Finance'),
                                       ('Marketing'),
                                       ('CNC'),
                                       ('CA'),
                                       ('HM'),
                                       ('BIO'),
                                       ('CHEM'),
                                       ('Manager');


select * from depart94;
desc depart94;

create table employ94 (
emp_id int primary key auto_increment,
emp_name varchar(20),
salary decimal(10.2),
dept_id int,
constraint fk_dept foreign key (dept_id) references depart94(dept_id)
);
drop table employ94;

insert into employ94(emp_name,salary,dept_id) 
select
concat('emp_',floor(rand()*100000)),
floor(rand() * 80000 )+ 10000,
floor(rand() * 10) + 1
from
(select 1 from information_schema.columns limit 100000) as A; 

select * from employ94; 
SELECT COUNT(*) FROM employ94;

explain select * from employ94 where emp_name = 'emp_59262';
create index idx_name on employ94(emp_name);


explain select e.emp_id, e.emp_name,e.salary,d.dept_name
from employ94 e 
join depart94 d 
on d.dept_id=e.dept_id
order by e.emp_id asc;

create index idx_dept_id on depart94(dept_id);

select * from employ94;











