use accure;

-- Library managments system

-- Member table
create table Member (
    member_id int primary key auto_increment,
    member_name varchar(100) not null,
    email varchar(100) unique,
    phone varchar(15),
    address VARCHAR(255),
    join_date date not null,
    status varchar(20) default 'active',
    constraint chk_phone check (phone REGEXP '^[6-9][0-9]{9}$'),
    constraint chk_email check (email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

-- books table
create table books (
    book_id int primary key auto_increment,
    book_title varchar(150) not null,
    author varchar(100) not null,
    category varchar(50),
    price decimal(10,2) not null,
    is_available varchar(20) default 'yes'
);

-- borrow table
create table borrow (
    borrow_id int primary key auto_increment,
    member_id int not null,
    book_id int not null,
    borrow_date date not null,
    due_date date not null,
    return_date date default null,
    constraint fk_borrow_member foreign key (member_id) references member(member_id)
        on delete cascade
        on update cascade,
        
    constraint fk_borrow_book foreign key (book_id) references books(book_id)
        on delete cascade
        on update cascade
);

-- fine table
create table fine (
    fine_id int primary key auto_increment,
    borrow_id int not null,
    late_days int not null,
    fine_amount decimal(10,2) not null,
    paid_status varchar(20) default 'unpaid',
    constraint fk_fine_borrow foreign key (borrow_id) references borrow(borrow_id)
        on delete cascade
        on update cascade
);

-- logs of member (if some member delete then its history will be store in this log_member table)
create table log_member (
    log_id int primary key auto_increment,
    member_id int,
    member_name varchar(100),
    email varchar(100),
    phone varchar(15),
    address varchar(255),
    join_date date,
    status varchar(20),
    deleted_at datetime default current_timestamp
);

-- trigger for log

delimiter $$

create trigger trg_log_member_delete
after delete on member
for each row
begin
    insert into log_member (member_id, member_name, email, phone, address, join_date)
    values 
    (old.member_id, old.member_name, old.email, old.phone, old.address, old.join_date);
    
end $$
delimiter ;


-- inserting sample data

-- data of member

insert into member 
(member_name, email, phone, address, join_date, status)
values
('Amit Sharma',   'amit.sharma@gmail.com',    '9876543210', 'Delhi',     '2024-01-05', 'active'),
('Neha Verma',    'neha.verma@yahoo.com',     '9234567890', 'Mumbai',    '2024-01-12', 'active'),
('Rohit Patil',   'rohit.patil@gmail.com',    '9988776655', 'Pune',      '2024-02-01', 'active'),
('Pooja Mehta',   'pooja.mehta@gmail.com',    '9871203456', 'Ahmedabad', '2024-02-10', 'inactive'),
('Suresh Yadav',  'suresh.yadav@hotmail.com', '9345678901', 'Lucknow',   '2024-02-18', 'active'),
('Kavita Joshi',  'kavita.joshi@gmail.com',   '9765432109', 'Jaipur',    '2024-03-01', 'active'),
('Ankit Mishra',  'ankit.mishra@gmail.com',   '9955443322', 'Bhopal',    '2024-03-08', 'active'),
('Riya Kulkarni', 'riya.k@gmail.com',         '9887766554', 'Nagpur',    '2024-03-15', 'active'),
('Manoj Singh',   'manoj.singh@gmail.com',    '9873332211', 'Patna',     '2024-03-20', 'inactive'),
('Sneha Desai',   'sneha.desai@gmail.com',    '9878765432', 'Surat',     '2024-03-25', 'active');

insert into member 
(member_name, email, phone, address, join_date, status)
values
('saurabh',   'sasss.desai@gmail.com',    '9878765432', 'Surat',     '2024-03-25', 'active');
insert into member 
(member_name, email, phone, address, join_date, status)
values
('Tilak',   'tilak.desai@gmail.com',    '9878765432', 'Mumbai',     '2025-03-25', 'active');


-- data of books

insert into books 
(book_title, author, category, price, is_available)
values
('The Alchemist',              'Paulo Coelho',        'Fiction',        299.00, 'yes'),
('Atomic Habits',              'James Clear',         'Self-Help',      450.00, 'yes'),
('Rich Dad Poor Dad',          'Robert Kiyosaki',     'Finance',        399.00, 'yes'),
('Wings of Fire',              'A. P. J. Abdul Kalam','Biography',      350.00, 'yes'),
('Think and Grow Rich',        'Napoleon Hill',       'Motivation',     280.00, 'no'),
('Harry Potter and the Philosopher''s Stone',
                               'J. K. Rowling',       'Fantasy',        599.00, 'yes'),
('The Power of Your Subconscious Mind',
                               'Joseph Murphy',      'Mindset',        320.00, 'yes'),
('Ikigai',                     'Héctor García',      'Lifestyle',      379.00, 'yes'),
('The Psychology of Money',    'Morgan Housel',       'Finance',        499.00, 'no'),
('Do Epic Shit',               'Ankur Warikoo',       'Self-Help',      300.00, 'yes');

insert into books 
(book_title, author, category, price, is_available)
values
('The Sendism',              'Richred sd',        'Fiction',        599.00, 'yes');

insert into books 
(book_title, author, category, price, is_available)
values
('JAVA',              'JK',        'Coding',        699.00, 'yes');


-- data of borrow

insert into borrow
(member_id, book_id, borrow_date, due_date, return_date)
values
(1,  3, '2024-03-01', '2024-03-15', '2024-03-14'),
(2,  5, '2024-03-02', '2024-03-16', NULL),
(3,  1, '2024-03-04', '2024-03-18', '2024-03-20'),
(4,  7, '2024-03-05', '2024-03-19', NULL),
(5,  2, '2024-03-06', '2024-03-20', '2024-03-18'),
(6,  9, '2024-03-07', '2024-03-21', NULL),
(7,  4, '2024-03-08', '2024-03-22', '2024-03-22'),
(8, 10, '2024-03-09', '2024-03-23', NULL),
(9,  6, '2024-03-10', '2024-03-24', '2024-03-25'),
(10, 8, '2024-03-11', '2024-03-25', NULL);

insert into borrow
(member_id, book_id, borrow_date, due_date, return_date)
values
(9, 12, '2024-03-01', '2024-03-15', '2024-03-14');

insert into borrow
(member_id, book_id, borrow_date, due_date, return_date)
values
(9, 1, '2024-03-01', '2024-03-15', '2024-04-14');


-- for update(when some one update borrow table (eg.return_date updated) then its calculate fine (eg.10rs per day.))
delimiter $$

create trigger trg_calculate_fine
after update on borrow
for each row
begin
    declare late_days int default 0;
    declare fine_amt decimal(10,2) default 0.00;

    -- only calculate if book is returned now (return_date updated)
    -- and only if it's late
    if new.return_date is not null and old.return_date is null then
        
        set late_days = greatest(datediff(new.return_date, new.due_date), 0);

        if late_days > 0 then
            set fine_amt = late_days * 10;  -- 10 rs per day

            insert into fine (borrow_id, late_days, fine_amount, paid_status)
            values (new.borrow_id, late_days, fine_amt, 'unpaid');
        end if;
        
    end if;

end $$

delimiter ;

-- for insert(when some one insert all value in borrow table including return_date then it calculate fine (eg.10rs per day) )
delimiter $$

create trigger trg_fine_after_borrow_insert
after insert on borrow
for each row
begin
    declare late_days int;
    declare fine_amt decimal(10,2);

    -- only calculate fine if return_date is provided
    if new.return_date is not null then

        set late_days = datediff(new.return_date, new.due_date);

        -- if returned late
        if late_days > 0 then
            set fine_amt = late_days * 10;  -- ₹10 per day

            insert into fine (borrow_id, late_days, fine_amount)
            values (new.borrow_id, late_days, fine_amt);
        end if;

    end if;
end$$

delimiter ;



-- data  of fine
insert into fine
(borrow_id, late_days, fine_amount, paid_status)
values
(2,  3,  30.00, 'unpaid'),
(4,  5,  50.00, 'unpaid');



-- Requirments

-- 1.show books with member name 
select m.member_name, b.book_title, b.author, br.borrow_date, br.due_date, br.return_date
from borrow br
join member m 
on br.member_id = m.member_id
join books b 
on br.book_id = b.book_id;

-- index for borrow(member_id, book_id)
create index idx_borrow_member_book 
on borrow(member_id, book_id);


-- 2.find member who borrow more then one book

select m.member_id, m.member_name, count(br.borrow_id) as total_books_borrowed
from member m
join borrow br 
on m.member_id = br.member_id
group by m.member_id, m.member_name
having count(br.borrow_id) > 1;

-- index for borrow(borrow_id);
create index idx_borrow_borrowid 
on borrow(borrow_id);

-- 3.find books that have never been borrow 
select b.book_id, b.book_title, b.author,  b.category
from books b
where not exists (
    select 1 
    from borrow br 
    where br.book_id = b.book_id
);

-- index on borrow(book_id)
create index idx_borrow_book on borrow(book_id);

-- 4.find total fine paid by each member

select m.member_id, m.member_name, f.paid_status, sum(f.fine_amount) as total_fine
from member m
join borrow b  
on m.member_id = b.member_id
join fine f    
on b.borrow_id = f.borrow_id
group by m.member_id, m.member_name, f.paid_status;

-- index on fine(borrow_id)
create index idx_fine_borrow on fine(borrow_id);


-- 5.find most expensive book borrow...
select m.member_name, b.book_title, b.price, br.borrow_date
from member m
join borrow br 
on m.member_id = br.member_id
join books b   
on br.book_id = b.book_id
where b.price = (
    select max(b2.price)
    from books b2
    join borrow br2 
    on b2.book_id = br2.book_id
);

-- index on books(price)
create index idx_books_price on books(price);

-- 6.find member who have not return book yet...

select m.member_name, b.book_title, br.borrow_date, br.due_date
from member m
join borrow br 
on m.member_id = br.member_id
join books b 
on br.book_id = b.book_id
where br.return_date is null;

-- index on borrow(return_date)
create index idx_borrow_returndate on borrow(return_date);

-- 7.show the category wise avg book price...
select category, round(avg(price), 2) as avg_book_price
from books
group by category;

-- index on books(price,category)
create index idx_books_category on books(price,category);

-- 8.list member who join in last year
select * from member
where join_date between 
      makedate(year(curdate()) - 1, 1)
      and makedate(year(curdate()), 1) - interval 1 day;

-- 9.booked based on price(order by)....
select * from books order by price asc;

-- 10.calculated late return duration...(if it is return)
select m.member_name, b.book_title, br.due_date, br.return_date,
    greatest(datediff(br.return_date, br.due_date), 0) as late_days
from member m
join borrow br 
on m.member_id = br.member_id
join books b 
on br.book_id = b.book_id
where br.return_date is not null;


-- checking triggers
-- if any member delete from member table that info save in log_member table
   delete from member where member_id=12;
   
   select * from member;
   select * from log_member;
   
-- This trigger runs after a borrow record is updated and checks if a book has just been returned. 
-- If the return is late, it calculates ₹10 per late day and inserts the fine details into the fine table.

  select * from borrow;
  
 update borrow
 set return_date = '2025-04-15'
 where borrow_id = 2;
 
 select * from fine; 
 
-- This trigger runs after a new record is inserted into the borrow table and checks whether the book is already returned.
-- If the return date is late, it calculates ₹10 per day as a fine and inserts the details into the fine table.

 insert into borrow
(member_id, book_id, borrow_date, due_date, return_date)
values
(3, 4, '2024-03-01', '2024-03-17', '2024-05-22');
 
 select * from fine;
 
 
 

  












