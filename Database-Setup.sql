
-------------------------- Table Creation and Insertion 
-- Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    city VARCHAR(50),
    registration_date DATE
);

INSERT INTO Customers VALUES
(1, 'Alice Johnson', 'alice.johnson@example.com', '555-1234', 'New York', '2020-01-15'),
(2, 'Bob Smith', 'bob.smith@example.com', '555-5678', 'Los Angeles', '2019-03-20'),
(3, 'Cathy Green', 'cathy.green@example.com', '555-8765', 'Chicago', '2021-06-10'),
(4, 'David Brown', 'david.brown@example.com', '555-4321', 'Houston', '2020-08-25'),
(5, 'Ella White', 'ella.white@example.com', '555-9999', 'Phoenix', '2021-12-05')
(6, 'Frank Blue', 'frank.blue@example.com', '555-2345', 'San Francisco', '2022-01-10'),
(7, 'Grace Yellow', 'grace.yellow@example.com', '555-6789', 'Seattle', '2018-11-05'),
(8, 'Henry Purple', 'henry.purple@example.com', '555-9876', 'Denver', '2019-09-15'),
(9, 'Ivy Orange', 'ivy.orange@example.com', '555-3456', 'Austin', '2020-02-28'),
(10, 'Jack Red', 'jack.red@example.com', '555-6543', 'Boston', '2021-03-14'),
(11, 'Kate Pink', 'kate.pink@example.com', '555-7412', 'San Diego', '2021-07-22'),
(12, 'Leo Gray', 'leo.gray@example.com', '555-8523', 'Atlanta', '2022-03-18'),
(13, 'Mia Cyan', 'mia.cyan@example.com', '555-9632', 'Miami', '2020-12-01'),
(14, 'Nina Silver', 'nina.silver@example.com', '555-3698', 'Dallas', '2019-04-21'),
(15, 'Oscar Gold', 'oscar.gold@example.com', '555-1475', 'Las Vegas', '2021-11-11'),
(16, 'Paul Teal', 'paul.teal@example.com', '555-1597', 'San Antonio', '2022-06-22'),
(17, 'Quinn Black', 'quinn.black@example.com', '555-7531', 'Orlando', '2020-05-08'),
(18, 'Rose Violet', 'rose.violet@example.com', '555-9514', 'Portland', '2021-08-17'),
(19, 'Steve Lime', 'steve.lime@example.com', '555-2584', 'Salt Lake City', '2019-07-03'),
(20, 'Tina Amber', 'tina.amber@example.com', '555-3572', 'Charlotte', '2022-09-09');

-- Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock_quantity INT
);

INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 999.99, 50),
(102, 'Phone', 'Electronics', 599.99, 200),
(103, 'Headphones', 'Accessories', 199.99, 300),
(104, 'Desk Chair', 'Furniture', 129.99, 150),
(105, 'Monitor', 'Electronics', 249.99, 80)
(106, 'Tablet', 'Electronics', 299.99, 120),
(107, 'Keyboard', 'Accessories', 49.99, 250),
(108, 'Office Desk', 'Furniture', 399.99, 60),
(109, 'Gaming Chair', 'Furniture', 199.99, 100),
(110, 'Smart Watch', 'Electronics', 149.99, 180),(111, 'Bluetooth Speaker', 'Accessories', 59.99, 150),
(112, 'External Hard Drive', 'Electronics', 89.99, 120),
(113, 'Smartphone Case', 'Accessories', 19.99, 500),
(114, 'Office Chair Mat', 'Furniture', 39.99, 80),
(115, 'Wireless Mouse', 'Accessories', 29.99, 300),
(116, 'Graphic Tablet', 'Electronics', 499.99, 60),
(117, 'LED Desk Lamp', 'Furniture', 49.99, 200),
(118, 'Mechanical Keyboard', 'Accessories', 79.99, 100),
(119, 'Curved Monitor', 'Electronics', 349.99, 50),
(120, 'Ergonomic Desk Chair', 'Furniture', 199.99, 40);
(111, 'Bluetooth Speaker', 'Accessories', 59.99, 150),
(112, 'External Hard Drive', 'Electronics', 89.99, 120),
(113, 'Smartphone Case', 'Accessories', 19.99, 500),
(114, 'Office Chair Mat', 'Furniture', 39.99, 80),
(115, 'Wireless Mouse', 'Accessories', 29.99, 300),
(116, 'Graphic Tablet', 'Electronics', 499.99, 60),
(117, 'LED Desk Lamp', 'Furniture', 49.99, 200),
(118, 'Mechanical Keyboard', 'Accessories', 79.99, 100),
(119, 'Curved Monitor', 'Electronics', 349.99, 50),
(120, 'Ergonomic Desk Chair', 'Furniture', 199.99, 40);

-- Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(20),
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
select * from orders ;

INSERT INTO Orders VALUES
-- (1001, 1, '2022-01-10', 'Completed', 1299.97),
-- (1002, 2, '2022-02-15', 'Pending', 749.98),
-- (1003, 3, '2022-03-05', 'Completed', 299.99),
-- (1004, 1, '2022-04-22', 'Cancelled', 199.99),
-- (1005, 4, '2022-05-01', 'Completed', 479.98)
-- (1006, 2, '2022-06-10', 'Completed', 599.98),
-- (1007, 5, '2022-06-15', 'Pending', 249.99),
-- (1008, 3, '2022-07-01', 'Completed', 449.97),
-- (1009, 6, '2022-07-20', 'Completed', 399.99),
-- (1010, 1, '2022-08-05', 'Completed', 649.97),
-- (1011, 7, '2022-08-15', 'Completed', 899.99),
-- (1012, 8, '2022-08-18', 'Pending', 749.99),
-- (1013, 9, '2022-08-20', 'Completed', 599.99),
-- (1014, 10, '2022-08-25', 'Cancelled', 299.99),
-- (1015, 11, '2022-09-01', 'Completed', 499.99),
-- (1016, 12, '2022-09-05', 'Completed', 1099.99),
-- (1017, 13, '2022-09-10', 'Pending', 349.99),
-- (1018, 14, '2022-09-15', 'Completed', 779.99),
-- (1019, 15, '2022-09-18', 'Completed', 649.99),
-- (1020, 16, '2022-09-20', 'Cancelled', 599.99)
-- (1021, 6, '2022-08-24', 'Completed', 399.99),
-- (1022, 1, '2022-09-09', 'Completed', 649.97),
-- (1023, 7, '2022-11-25', 'Completed', 899.99),
-- (1024, 8, '2022-11-29', 'Pending', 749.99),
-- (1025, 9, '2022-10-27', 'Completed', 599.99),
-- (1026, 10, '2022-10-29', 'Cancelled', 299.99),
-- (1027, 11, '2022-11-14', 'Completed', 499.99),
-- (1028, 12, '2022-12-13', 'Completed', 1099.99),
-- (1029, 13, '2022-10-16', 'Pending', 349.99),
-- (1030, 14, '2022-10-18', 'Completed', 779.99),
(1031, 6, '2022-09-26', 'Completed', 399.99),
(1032, 1, '2022-10-18', 'Completed', 649.97),
(1033, 7, '2022-12-29', 'Completed', 899.99),
(1034, 8, '2022-12-30', 'Pending', 749.99),
(1035, 9, '2022-11-02', 'Completed', 599.99),
(1036, 10, '2022-11-05', 'Cancelled', 299.99),
(1037, 11, '2022-11-28', 'Completed', 499.99),
(1038, 12, '2022-12-28', 'Completed', 1099.99),
(1039, 13, '2022-12-03', 'Pending', 349.99),
(1040, 14, '2022-10-27', 'Completed', 779.99);

-- OrderDetails Table
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO OrderDetails VALUES
(1, 1001, 101, 1),
(2, 1001, 103, 2),
(3, 1002, 102, 1),
(4, 1002, 104, 2),
(5, 1003, 105, 1),
(6, 1004, 103, 1),
(7, 1005, 104, 2),
(8, 1006, 106, 2),
(9, 1007, 107, 5),
(10, 1008, 108, 1),
(11, 1008, 110, 2),
(12, 1009, 109, 2),
(13, 1010, 105, 2),
(14, 1011, 111, 2),
(15, 1011, 112, 1),
(16, 1012, 113, 3),
(17, 1012, 114, 1),
(18, 1013, 115, 4),
(19, 1014, 116, 1),
(20, 1015, 117, 2),
(21, 1015, 118, 2),
(22, 1016, 119, 1),
(23, 1016, 120, 2),
(24, 1017, 111, 3),
(25, 1018, 112, 2),
(26, 1018, 113, 1),
(27, 1019, 114, 1),
(28, 1020, 115, 2);

-- Payments Table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    payment_amount DECIMAL(10, 2),
    payment_method VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Payments VALUES
(1, 1001, '2022-01-11', 1299.97, 'Credit Card'),
(2, 1002, '2022-02-16', 749.98, 'PayPal'),
(3, 1003, '2022-03-06', 299.99, 'Debit Card'),
(4, 1005, '2022-05-02', 479.98, 'Credit Card')
(5, 1006, '2022-06-11', 599.98, 'Credit Card'),
(6, 1007, '2022-06-16', 249.99, 'Debit Card'),
(7, 1008, '2022-07-02', 449.97, 'PayPal'),
(8, 1009, '2022-07-21', 399.99, 'Credit Card'),
(9, 1010, '2022-08-06', 649.97, 'Debit Card'),
(10, 1011, '2022-08-16', 899.99, 'Credit Card'),
(11, 1012, '2022-08-19', 749.99, 'PayPal'),
(12, 1013, '2022-08-21', 599.99, 'Debit Card'),
(13, 1014, '2022-08-26', 299.99, 'Credit Card'),
(14, 1015, '2022-09-02', 499.99, 'Credit Card'),
(15, 1016, '2022-09-06', 1099.99, 'Debit Card'),
(16, 1017, '2022-09-11', 349.99, 'PayPal'),
(17, 1018, '2022-09-16', 779.99, 'Credit Card'),
(18, 1019, '2022-09-19', 649.99, 'PayPal'),
(19, 1020, '2022-09-21', 599.99, 'Debit Card');
