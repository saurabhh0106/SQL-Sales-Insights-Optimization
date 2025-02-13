-- 1. Create Database
CREATE DATABASE EcommerceDB;
USE EcommerceDB;

-- 2. Create Tables
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    signup_date DATE
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- 3. Insert Sample Data
INSERT INTO Customers (name, email, signup_date) VALUES
('Alice Johnson', 'alice@example.com', '2024-01-15'),
('Bob Smith', 'bob@example.com', '2024-02-10'),
('Charlie Brown', 'charlie@example.com', '2024-02-25');

INSERT INTO Products (name, category, price) VALUES
('Laptop', 'Electronics', 800.00),
('Phone', 'Electronics', 500.00),
('Headphones', 'Accessories', 50.00);

INSERT INTO Orders (customer_id, order_date, total_amount) VALUES
(1, '2024-03-01', 850.00),
(2, '2024-03-05', 500.00),
(3, '2024-03-10', 50.00);

INSERT INTO OrderDetails (order_id, product_id, quantity, subtotal) VALUES
(1, 1, 1, 800.00),
(1, 3, 1, 50.00),
(2, 2, 1, 500.00),
(3, 3, 1, 50.00);

-- 4. SQL Queries for Insights
-- a. Top 5 Customers by Total Spend
SELECT c.name, SUM(o.total_amount) AS total_spent 
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 5;

-- b. Best Selling Products
SELECT p.name, SUM(od.quantity) AS total_sold 
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.name
ORDER BY total_sold DESC;

-- c. Monthly Sales Trend
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(total_amount) AS total_sales
FROM Orders
GROUP BY month
ORDER BY month;

-- 5. Automating Reports with Views
CREATE VIEW SalesSummary AS
SELECT c.name AS customer_name, p.name AS product_name, od.quantity, o.order_date, o.total_amount
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id;

