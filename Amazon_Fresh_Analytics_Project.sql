create database Amazon;

use Amazon;

-- text change to varchar 

alter table customers
modify column CustomerID varchar(50);

alter table order_details
modify column  OrderID varchar(40) ,
modify column ProductID varchar(40);

alter table orders
modify column OrderID varchar(40) ,
modify column CustomerID varchar(40);

alter table products
modify column ProductID varchar(40);

alter table reviews 
modify column ReviewID varchar(40),
modify column ProductID varchar(40),
modify column CustomerID varchar(40);

alter table suppliers 
modify column SupplierID varchar(40);


-- Task 2: Identify the primary keys and foreign keys for each table and describe their relationships.

-- primary keys

alter table customers
add constraint New_constraint primary key customers(CustomerID);

alter table orders 
add constraint New_constraint primary key orders(OrderID);

alter table products
add constraint New_constraint primary key products(ProductID);

alter table reviews
add constraint New_constraint primary key reviews(ReviewID);

alter table suppliers
add constraint New_constraint primary key suppliers(SupplierID);


-- foregin key 

alter table order_details
add constraint fk_order foreign key (OrderID) references orders(OrderID);

alter table order_details 
add constraint fk_products foreign key (ProductID) references products(ProductID);

alter table orders
add constraint fk_customers foreign key (CustomerID) references customers(CustomerID);

alter table reviews 
add constraint fk_product foreign key (ProductID) references products(ProductID);

alter table reviews 
add constraint fk_customer  foreign key (CustomerID) references customers(CustomerID);


-- insert values

Insert into suppliers(SupplierID)
select distinct SupplierID
from products
where SupplierID not in (select SupplierID from  suppliers);

ALTER TABLE suppliers
MODIFY SupplierID VARCHAR(50);

ALTER TABLE products
MODIFY SupplierID VARCHAR(50);

ALTER TABLE suppliers
ADD PRIMARY KEY (SupplierID);

alter table products
add constraint fk_suppliers foreign key (SupplierID) references suppliers(SupplierID);


-- Task 3: Write a query to:
--  Retrieve all customers from a specific city.

select * from customers;
select * from customers where City = "Meganfort";

-- Fetch all products under the "Fruits" category.

select * from products;
select ProductName , Category   from products where Category = "Fruits";



--  Data Definition Language (DDL) and Constraints

-- Task 4: Write DDL statements to recreate the Customers table with the following constraints:
-- CustomerID as the primary key.

ALTER TABLE Customers
ADD CONSTRAINT New_constraint PRIMARY KEY (CustomerID);

-- Ensure Age cannot be null and must be greater than 18.

alter table customers
modify column age int not null;

SELECT * FROM customers
WHERE Age <= 18;

SET SQL_SAFE_UPDATES = 0;

UPDATE customers
SET Age = 19
WHERE Age <= 18;

ALTER TABLE customers
ADD CONSTRAINT chk_age CHECK (Age > 18);

-- Add a unique constraint for Name.

ALTER TABLE customers MODIFY Name VARCHAR(100);

SELECT *
FROM customers
WHERE Name = 'Michael Garcia';

SET SQL_SAFE_UPDATES = 0;

UPDATE customers
SET Name = CONCAT(Name, '_', CustomerID)
WHERE Name IN (
    SELECT Name FROM (
        SELECT Name
        FROM customers
        GROUP BY Name
        HAVING COUNT(*) > 1
    ) AS temp
);

ALTER TABLE customers
ADD CONSTRAINT unique_name UNIQUE (Name);


-- Data Manipulation Language (DML)\
-- Task 5: Insert 3 new rows into the Products table using INSERT statements.

SELECT * FROM suppliers;
INSERT INTO suppliers (SupplierID)
VALUES 
('jhvcjq762-hjabjc-23rfcqa32-sedvaqwf5'),
('afbh12-324bjkwsj-32rfa34r-3rf24trf'),
('vkijbqw34-23rfcwww-q3rdf21-f1qert5');

insert into products
values
('1001','Laptops','Electronics','Sub-Electronics','4500','18','jhvcjq762-hjabjc-23rfcqa32-sedvaqwf5'),
('1002','Pens','Stationary','sub-stationary','15','50','afbh12-324bjkwsj-32rfa34r-3rf24trf'),
('1003','Keychain','Toys','Sub-toys','55','16','vkijbqw34-23rfcwww-q3rdf21-f1qert5');

select ProductID , ProductName from products where ProductID = '1001';


-- Task 6: Update the stock quantity of a product where ProductID matches a specific ID.

update products
set StockQuantity = '25' where ProductID = '1001';

select * from products where ProductID = '1001';


-- Task 7: Delete a supplier from the Suppliers table where their city matches a specific value.

select City from suppliers ;

delete from suppliers where City = "South Debra" ;

-- Task 8
-- SQL Constraints and Operators
-- Add a CHECK constraint to ensure that ratings in the Reviews table are between 1 and 5.

alter table reviews
add constraint CHK_rating check (Rating between 1 and 5) ;

select * from reviews where Rating between 1 and 5 ;

-- Add a DEFAULT constraint for the PrimeMember column in the Customers table (default value: "No").

ALTER TABLE customers
MODIFY PrimeMember VARCHAR(10) DEFAULT 'No';

-- Task 9
-- Clauses and Aggregations
-- WHERE clause to find orders placed after 2024-01-01.

select * from orders where OrderDate = 2024-01-01;

-- HAVING clause to list products with average ratings greater than 4.

select p.ProductID , p.ProductName , avg(rating) as avg_rating from reviews as r join products as p ON 
r.ProductID = p.ProductID group by p.ProductID , p.ProductName having avg_rating > 4;

-- GROUP BY and ORDER BY clauses to rank products by total sales.

select p.ProductID , p.ProductName , sum(PricePerUnit * Quantity) as Total_Sales from products as p
join order_details as o ON o.ProductID = p.ProductID group by p.ProductID , p.ProductName order by Total_Sales;


-- Task 10
-- Identifying High-Value Customers
-- Amazon Fresh wants to identify top customers based on their total spending. We will:
-- 1. Calculate each customer's total spending.

SELECT c.CustomerID, c.Name, SUM(od.Quantity * od.UnitPrice) AS Total_Spending
FROM customers c
JOIN orders o ON c.CustomerID = o.CustomerID
JOIN order_details od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.Name
ORDER BY Total_Spending desc;

-- 2. Rank customers based on their spending.

select c.customerID , c.Name , sum(Quantity*UnitPrice) as Total_Spending ,
rank() over ( order by sum(Quantity * UnitPrice) desc) as Customer_Ranking
from customers as c
join orders as o ON c.customerID = o.customerID
join order_details as od ON o.orderID = od.orderID 
group by c.customerID , c.Name;

-- Identify customers who have spent more than ₹5,000.

SELECT c.CustomerID, c.Name,SUM(od.Quantity * od.UnitPrice) AS Total_Spending
FROM customers c
JOIN orders o ON c.CustomerID = o.CustomerID
JOIN order_details od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.Name
HAVING Total_Spending > 5000 order by Total_Spending desc;

-- Complex Aggregations and Joins
-- Task 11: Use SQL to:
-- Join the Orders and OrderDetails tables to calculate total revenue per order.

select o.OrderID, sum(Quantity * UnitPrice) as Total_Revenue
from Orders as o
join Order_details as od ON o.OrderID = od.OrderID
group by o.OrderID
order by Total_Revenue desc;

-- Identify customers who placed the most orders in a specific time period.

select c.CustomerID , c.Name , count(o.orderID) as Total_Orders
from customers as c
join Orders as o ON c.CustomerID = o.CustomerID
where OrderDate between '2025-01-01' and '2025-01-01'
group by c.CustomerID , c.Name 
order by Total_Orders ;

-- Find the supplier with the most products in stock.

SELECT s.SupplierID, s.SupplierName, COUNT(p.ProductID) AS Total_Products
FROM suppliers s
JOIN products p ON s.SupplierID = p.SupplierID
GROUP BY s.SupplierID, s.SupplierName
ORDER BY Total_Products DESC;

-- Normalization
-- Task 12: Normalize the Products table to 3NF:
-- Separate product categories and subcategories into a new table.

CREATE TABLE categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100),
    SubCategoryName VARCHAR(100)
);

INSERT INTO categories (CategoryName, SubCategoryName)
SELECT DISTINCT Category, SubCategory
FROM products;

select * from categories ;

ALTER TABLE products
ADD CategoryID INT;

SET SQL_SAFE_UPDATES = 0;

UPDATE products p
JOIN categories c 
ON p.Category = c.CategoryName 
AND p.SubCategory = c.SubCategoryName
SET p.CategoryID = c.CategoryID;

select * from categories;

-- Create foreign keys to maintain relationships.

ALTER TABLE products
ADD CONSTRAINT fk_products_category
FOREIGN KEY (CategoryID)
REFERENCES categories(CategoryID);

-- Subqueries and Nested Queries

-- Task 13: Write a subquery to:
-- Identify the top 3 products based on sales revenue.

SELECT p.ProductID, p.ProductName,
       SUM(od.Quantity * od.UnitPrice) AS Total_Revenue
FROM products p
JOIN order_details od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY Total_Revenue DESC
LIMIT 3;

-- Find customers who haven’t placed any orders yet.

SELECT c.CustomerID, c.Name
FROM customers c
LEFT JOIN orders o ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL;

------------------------------------------------------------------------------------------------------
-- The Project End --









