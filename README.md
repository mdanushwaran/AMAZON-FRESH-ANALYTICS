
**AMAZON FRESH ANALYTICS
Microsoft Excel | MySQL**

**Table of Contents :-**
	Project Overview & Problem Statement 
	Project Objectives 
	Main Concepts Used 
	Database Structure & Relationships 
	Data Cleaning & Preparation (Excel) 
	Database Management & SQL Implementation (MySQL) 
	SQL Analysis & Business Queries 
	Results & Key Findings 
	Conclusion

**1) Project Overview & Problem Statement :-
1.1 Introduction**
The Amazon Fresh Analytics Project is a retail and grocery analytics project developed using Microsoft Excel and MySQL. The project focuses on organizing, cleaning, storing, and analyzing customer orders, products, suppliers, reviews, and inventory data to generate meaningful business insights.
The project simulates a real-world Amazon Fresh grocery management system where thousands of transactions occur daily. Businesses require structured databases and analytical reports to monitor:
•	Product sales 
•	Customer behaviour 
•	Supplier management 
•	Inventory tracking 
•	Order processing 
•	Revenue generation 
Raw retail datasets are usually unstructured and contain duplicate values, missing records, inconsistent formats, and invalid entries. This project demonstrates how Excel and MySQL can be used together to transform raw datasets into a fully structured retail analytics system.
**1.2 Problem Statement**
Amazon Fresh stores large amounts of customer and sales data daily. Without proper data management and analysis, businesses face several operational problems such as:
•	Difficulty identifying top customers 
•	Poor inventory monitoring 
•	Duplicate and inconsistent records 
•	Inefficient sales tracking 
•	Inaccurate reporting 
•	Lack of customer insights 
**The dataset also contains:**
•	Null values 
•	Duplicate customer names 
•	Invalid age values 
•	Inconsistent data types 
•	Unstructured relationships between tables 
**This project solves these challenges using:**
1.	Excel for data cleaning and preprocessing 
2.	MySQL for relational database creation and SQL analytics
2. Project Objectives
**The major objectives of this project are:**
•	Clean and standardize raw retail datasets using Excel. 
•	Create a structured relational database using MySQL. 
•	Apply primary key and foreign key relationships. 
•	Perform sales and customer analysis using SQL queries. 
•	Identify top-selling products and high-value customers. 
•	Monitor inventory stock levels and supplier performance. 
•	Analyze customer reviews and product ratings. 
•	Generate business reports for decision-making.
**3. Main Concepts Used
3.1 Excel Concepts**
•	Data Cleaning - Used to remove inconsistent and duplicate records.
•	Remove Duplicates - Eliminates repeated customer and product records.
•	Data Validation - Ensures correct values are entered into columns.
•	Sorting & Filtering - Used to organize datasets for analysis.
•	Conditional Formatting - Highlights important business metrics such as low stock.
•	Pivot Tables - Summarizes sales and category-wise data.
•	CSV Export - Exports cleaned datasets for SQL import.
**3.2 MySQL Concepts
Database Creation**
Created a relational database named Amazon.
CREATE DATABASE Amazon;
USE Amazon;

**ALTER TABLE**
Used to modify column data types and constraints.
ALTER TABLE customers
MODIFY COLUMN CustomerID VARCHAR(50);

**Primary Key**
Used to uniquely identify records.
ALTER TABLE customers
ADD CONSTRAINT pk_customer
PRIMARY KEY(CustomerID);

**Foreign Key**
Creates relationships between related tables.
ALTER TABLE orders
ADD CONSTRAINT fk_customers
FOREIGN KEY(CustomerID)
REFERENCES customers(CustomerID);
<img width="505" height="498" alt="image" src="https://github.com/user-attachments/assets/9533fdd8-06d5-43d5-ad15-47b87aed845f" />

**Aggregate Functions**
Aggregate Functions in MySQL are used to perform calculations on multiple rows of data and return a single summarized result. These functions are very important in data analytics and business reporting because they help analyze sales, customers, products, revenue, and inventory data efficiently.
In the Amazon Fresh Analytics Project, aggregate functions were used to generate business insights such as total sales, customer orders, average ratings, highest revenue products, and inventory analysis.
**1. SUM()**
The SUM() function is used to calculate the total value of a numeric column.
Purpose in This Project
•	Calculate total sales revenue 
•	Find total spending by customers 
•	Analyze category-wise revenue 
Example Query
SELECT SUM(quantity * unit_price) AS total_revenue
FROM order_details;
________________________________________
**2. COUNT()**
The COUNT() function is used to count the number of rows or records in a table.
Purpose in This Project
•	Count total orders 
•	Count total customers 
•	Count products in stock 
•	Count supplier products 
Example Query
SELECT COUNT(order_id) AS total_orders
FROM orders;
________________________________________
**3. AVG()**
The AVG() function calculates the average value of a numeric column.
Purpose in This Project
•	Find average product ratings 
•	Calculate average order value 
•	Analyze average customer spending 
Example Query
SELECT AVG(rating) AS average_rating
FROM reviews;
________________________________________
**4. MAX()**
The MAX() function returns the highest value from a column.
Purpose in This Project
•	Identify highest-priced products 
•	Find maximum revenue generated 
•	Detect highest stock quantity 
Example Query
SELECT MAX(unit_price) AS highest_price
FROM products;
________________________________________
**5. MIN()**
The MIN() function returns the smallest value from a column.
Purpose in This Project
•	Identify lowest-priced products 
•	Detect minimum stock levels 
•	Find smallest order quantity 
Example Query
SELECT MIN(stock_quantity) AS minimum_stock
FROM products;

**SQL Clauses**
SQL Clauses are used to filter, organize, group, and retrieve data from database tables. In the Amazon Fresh Analytics Project, SQL clauses were heavily used to analyze customer orders, product sales, revenue, inventory, and supplier performance.
These clauses helped transform raw transactional data into meaningful business reports and analytical insights.
________________________________________
**1. WHERE Clause**
The WHERE clause is used to filter records based on specific conditions.
Purpose in This Project
•	Identify low-stock products 
•	Filter customers by age 
•	Retrieve delivered orders only 
•	Find products with high ratings 
Example Query
SELECT ProductName, StockQuantity
FROM products
WHERE StockQuantity < 20;
________________________________________
**2. GROUP BY Clause**
The GROUP BY clause is used to group rows that have the same values into summary rows.
Purpose in This Project
•	Category-wise sales analysis 
•	Customer purchase analysis 
•	Supplier product count 
•	Order status summary 
Example Query
SELECT CategoryID,
COUNT(ProductID) AS Total_Products
FROM products
GROUP BY CategoryID;
________________________________________
**3. ORDER BY Clause**
The ORDER BY clause is used to sort query results in ascending or descending order.
Purpose in This Project
•	Sort products by revenue 
•	Rank customers by spending 
•	Display highest-rated products 
•	Analyze top-selling products 
Example Query
SELECT ProductName, UnitPrice
FROM products
ORDER BY UnitPrice DESC;
________________________________________
**4. HAVING Clause**
The HAVING clause is used to filter grouped data after applying aggregate functions.
Purpose in This Project
•	Identify products with high average ratings 
•	Filter categories with high sales 
•	Find customers with high spending 
Example Query
SELECT ProductID,
AVG(Rating) AS Avg_Rating
FROM reviews
GROUP BY ProductID
HAVING Avg_Rating > 4;
________________________________________
**5. JOIN Clause**
The JOIN clause is used to combine data from multiple related tables.
Types Used in This Project
•	INNER JOIN 
•	LEFT JOIN 
Purpose in This Project
•	Combine customer and order data 
•	Connect products with suppliers 
•	Analyze order details with product information 
Example Query
SELECT c.Name, o.OrderID
FROM customers c
JOIN orders o
ON c.CustomerID = o.CustomerID;
________________________________________
**6. LIMIT Clause**
The LIMIT clause is used to restrict the number of rows returned in query results.
Purpose in This Project
•	Display top-selling products 
•	Retrieve top customers 
•	Show highest revenue records 
Example Query
SELECT ProductName,
SUM(Quantity * UnitPrice) AS Revenue
FROM order_details od
JOIN products p
ON od.ProductID = p.ProductID
GROUP BY ProductName
ORDER BY Revenue DESC
LIMIT 5;
<img width="1086" height="507" alt="image" src="https://github.com/user-attachments/assets/075c3e2d-ea10-4632-ba0e-8e98a6b8a196" />
<img width="1082" height="243" alt="image" src="https://github.com/user-attachments/assets/2149d118-e87b-415a-b2a2-2ebce607512f" />

**4. Database Structure & Relationships
4.1 Tables Used
Table Name	Descriptio**n
customers	Stores customer information
orders	Stores order details
order_details	Stores product-level transaction records
products	Stores product information
reviews	Stores customer reviews and ratings
suppliers	Stores supplier information
categories	Stores product category details

**4.2	Relationships Between Tables**
Customer & Orders - One customer can place multiple orders. 
Orders & Order Details - One order can contain multiple products. 
Products & Suppliers - One supplier can supply multiple products. 
Products & Reviews - Customers can review products.

**4.3 Foreign Key Relationships**
Foreign Key	Reference Table
orders.CustomerID	customers.CustomerID
order_details.OrderID	orders.OrderID
order_details.ProductID	products.ProductID
reviews.ProductID	products.ProductID
reviews.CustomerID	customers.CustomerID
products.SupplierID	suppliers.SupplierID

**6. Data Cleaning & Preparation (Excel)
6.1 Standardize Data Types**
Column types were standardized before database import.
Example
Column	Converted To
CustomerID	VARCHAR
ProductID	VARCHAR
OrderID	VARCHAR

**6.2 Handle Invalid Age Values**
The project ensured all customers were above 18 years old.
ALTER TABLE customers
ADD CONSTRAINT chk_age
CHECK (Age > 18);
This improved data validation and customer record accuracy.

**6.3 Remove Duplicate Customer Names**
Duplicate customer names were identified and updated using SQL queries.
Purpose:
•	Prevent duplicate customer records 
•	Maintain unique customer identification 

**6.4 Add Default Values**
Default values were assigned to PrimeMember column.
ALTER TABLE customers
MODIFY PrimeMember VARCHAR(10)
DEFAULT 'No';

**7. Database Management & SQL Implementation (MySQL)
7.1 Database Creation**
CREATE DATABASE Amazon;
USE Amazon;

**7.2 Primary Key Implementation**
Primary keys were added to all major tables.
Example
ALTER TABLE products
ADD PRIMARY KEY(ProductID);
Purpose:
•	Ensure unique product records 
•	Prevent duplicate IDs 

**7.3 Foreign Key Implementation**
Foreign keys created relationships between transactional tables.
Example
ALTER TABLE order_details
ADD CONSTRAINT fk_products
FOREIGN KEY(ProductID)
REFERENCES products(ProductID);
Purpose:
•	Maintain relational integrity 
•	Connect sales and product data 

**7.4 Check Constraints**
Implemented constraints for valid ratings.
ALTER TABLE reviews
ADD CONSTRAINT chk_rating
CHECK (Rating BETWEEN 1 AND 5);
Purpose:
•	Ensure valid customer review ratings

**8. SQL Analysis & Business Queries
8.1 Customer Analysis**
Total Customer Spending
SELECT c.CustomerID, c.Name,
SUM(od.Quantity * od.UnitPrice) AS Total_Spending
FROM customers c
JOIN orders o ON c.CustomerID = o.CustomerID
JOIN order_details od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.Name
ORDER BY Total_Spending DESC;
Purpose
•	Identify high-value customers 
•	Analyze customer purchasing behaviour 

**8.2 Customer Ranking**
SELECT c.CustomerID, c.Name,
SUM(Quantity * UnitPrice) AS Total_Spending,
RANK() OVER (
ORDER BY SUM(Quantity * UnitPrice) DESC
) AS Customer_Ranking
FROM customers c
JOIN orders o ON c.CustomerID = o.CustomerID
JOIN order_details od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.Name;
Purpose
•	Rank customers based on total spending 

**8.3 Product Sales Analysis**
Top Selling Products
SELECT p.ProductID, p.ProductName,
SUM(od.Quantity * od.UnitPrice) AS Total_Revenue
FROM products p
JOIN order_details od
ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY Total_Revenue DESC
LIMIT 3;
Purpose
•	Identify highest revenue-generating products 
**8.4 Product Rating Analysis**
SELECT p.ProductID,
p.ProductName,
AVG(rating) AS avg_rating
FROM reviews r
JOIN products p
ON r.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
HAVING avg_rating > 4;
Purpose
•	Identify highly rated products 

**8.5 Revenue Analysis**
Total Revenue Per Order
SELECT o.OrderID,
SUM(Quantity * UnitPrice) AS Total_Revenue
FROM Orders o
JOIN Order_details od
ON o.OrderID = od.OrderID
GROUP BY o.OrderID;
Purpose
•	Calculate order-level revenue 

**8.6 Supplier Analysis**
SELECT s.SupplierID,
s.SupplierName,
COUNT(p.ProductID) AS Total_Products
FROM suppliers s
JOIN products p
ON s.SupplierID = p.SupplierID
GROUP BY s.SupplierID, s.SupplierName
ORDER BY Total_Products DESC;
Purpose
•	Identify suppliers managing most products 

**8.7 Inventory Analysis**
Low Stock Products
SELECT ProductID, StockQuantity
FROM products
WHERE StockQuantity < 20;
Purpose
•	Monitor inventory shortages 

**8.8 Customer Without Orders**
SELECT c.CustomerID, c.Name
FROM customers c
LEFT JOIN orders o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL;
Purpose
•	Identify inactive customers

<img width="795" height="485" alt="image" src="https://github.com/user-attachments/assets/51330eb9-d41f-421f-8b57-3ab76cc9ea77" />

<img width="765" height="480" alt="image" src="https://github.com/user-attachments/assets/6346174a-1f43-41e2-9867-609456b31ac4" />

<img width="984" height="505" alt="image" src="https://github.com/user-attachments/assets/24531d2f-a562-44bc-a4af-fac4d3f7b4cd" />

**9. Results & Key Findings**
Key Findings
Customer Insights - High-value customers were successfully identified based on spending patterns.
Product Performance - Top-selling products generated the highest sales revenue.
Inventory Monitoring - Low-stock products were detected for restocking purposes.
Product Ratings - Products with average ratings above 4 were identified as highly preferred products.
Supplier Performance - Supplier analysis helped identify suppliers managing the largest inventory.
Revenue Analysis - Order-level revenue calculations improved business reporting accuracy.
**10. Conclusion**
The Amazon Fresh Analytics Project successfully demonstrates how Microsoft Excel and MySQL can be integrated to build a complete retail and grocery analytics system. The project focused on transforming raw transactional data into structured and meaningful business information through systematic data processing and SQL-based analysis.
The project involved multiple stages including:
•	Data cleaning and preprocessing using Excel 
•	Creation of a relational database in MySQL 
•	Implementation of primary and foreign key relationships 
•	Execution of SQL queries for business analysis 
•	Revenue and sales reporting 
•	Customer and product analytics 
•	Inventory and stock monitoring 
Through this project, valuable business insights were generated regarding:
•	Customer purchasing behaviour 
•	Product sales performance 
•	Revenue generation 
•	Inventory management 
•	Order tracking and reporting 
The analysis helped identify:
•	Top-selling products 
•	High-value customers 
•	Low-stock inventory items 
•	Product category performance 
•	Order trends and sales patterns 
Overall, the Amazon Fresh Analytics Project demonstrates a real-world retail analytics workflow and highlights the importance of structured data analysis in improving business decision-making and operational efficiency.


