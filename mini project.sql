-- Products Table
CREATE TABLE products5 (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO products5 (product_id, name, price) VALUES
(1, 'Laptop', 799.99),
(2, 'Smartphone', 599.49),
(3, 'Tablet', 399.00),
(4, 'Monitor', 149.99),
(5, 'Keyboard', 29.99),
(6, 'Mouse', 19.99),
(7, 'Printer', 89.99),
(8, 'Headphones', 49.99),
(9, 'Webcam', 39.99),
(10, 'External Hard Drive', 79.99);


-- Customers Table
CREATE TABLE customers5 (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO customers5 (customer_id, name, email) VALUES
(1, 'Alice Smith', 'alice@example.com'),
(2, 'Bob Johnson', 'bob@example.com'),
(3, 'Charlie Brown', 'charlie@example.com'),
(4, 'Diana Prince', 'diana@example.com'),
(5, 'Ethan Hunt', 'ethan@example.com'),
(6, 'Fiona Glenanne', 'fiona@example.com'),
(7, 'George Clooney', 'george@example.com'),
(8, 'Hannah Baker', 'hannah@example.com'),
(9, 'Ian Somerhalder', 'ian@example.com'),
(10, 'Judy Garland', 'judy@example.com');


-- Orders Table
CREATE TABLE orders5 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers5(customer_id)
);

INSERT INTO orders5 (order_id, customer_id, order_date) VALUES
(101, 1, '2025-05-01'),
(102, 2, '2025-05-02'),
(103, 3, '2025-05-03'),
(104, 4, '2025-05-04'),
(105, 5, '2025-05-05'),
(106, 6, '2025-05-06'),
(107, 7, '2025-05-07'),
(108, 8, '2025-05-08'),
(109, 9, '2025-05-09'),
(110, 10, '2025-05-10');


-- Order Items Table
CREATE TABLE order_items5 (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders5(order_id),
    FOREIGN KEY (product_id) REFERENCES products5(product_id)
);

INSERT INTO order_items5 (order_id, product_id, quantity) VALUES
(101, 1, 1),
(101, 5, 2),
(102, 2, 1),
(103, 3, 1),
(104, 4, 2),
(105, 6, 3),
(106, 7, 1),
(107, 8, 2),
(108, 9, 1),
(109, 10, 1);

select p.name ,sum(oi.quantity * p.price) as revenue
from products5 p
join order_items5 oi
where p.product_id=oi.product_id
group by p.name;


select p.name ,sum(oi.quantity * p.price) as revenue
from products5 p
join order_items5 oi
where p.product_id=oi.product_id
group by p.name
order by revenue desc
limit 5;

select c.name 
from customers5 c
left join orders5 o 
on c.customer_id=o.customer_id
where o.order_id is null;




