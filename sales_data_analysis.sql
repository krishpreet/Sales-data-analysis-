Create the database
CREATE DATABASE IF NOT EXISTS SalesDB;

-- Use the database
USE SalesDB;

-- Create Customers table
CREATE TABLE IF NOT EXISTS Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    ContactName VARCHAR(100),
    Country VARCHAR(50)
);

-- Create Products table
CREATE TABLE IF NOT EXISTS Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2)
);

-- Create Sales table
CREATE TABLE IF NOT EXISTS Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    CustomerID INT,
    SaleDate DATE,
    Quantity INT,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert data into Customers table
INSERT INTO Customers (CustomerID, CustomerName, ContactName, Country)
VALUES
(1, 'Customer A', 'Contact A', 'USA'),
(2, 'Customer B', 'Contact B', 'Canada'),
(3, 'Customer C', 'Contact C', 'UK')
ON DUPLICATE KEY UPDATE
CustomerName = VALUES(CustomerName),
ContactName = VALUES(ContactName),
Country = VALUES(Country);

-- Insert data into Products table
INSERT INTO Products (ProductID, ProductName, Category, Price)
VALUES
(1, 'Product 1', 'Category 1', 10.00),
(2, 'Product 2', 'Category 2', 20.00),
(3, 'Product 3', 'Category 3', 30.00)
ON DUPLICATE KEY UPDATE
ProductName = VALUES(ProductName),
Category = VALUES(Category),
Price = VALUES(Price);

-- Insert data into Sales table
INSERT INTO Sales (SaleID, ProductID, CustomerID, SaleDate, Quantity, TotalAmount)
VALUES
(1, 1, 1, '2023-01-01', 2, 20.00),
(2, 2, 2, '2023-01-05', 1, 20.00),
(3, 3, 3, '2023-02-01', 3, 90.00),
(4, 1, 2, '2023-03-01', 1, 10.00),
(5, 2, 1, '2023-03-15', 2, 40.00)
ON DUPLICATE KEY UPDATE
ProductID = VALUES(ProductID),
CustomerID = VALUES(CustomerID),
SaleDate = VALUES(SaleDate),
Quantity = VALUES(Quantity),
TotalAmount = VALUES(TotalAmount);

-- Analytical Queries
-- Total Sales by Product
SELECT ProductID, SUM(TotalAmount) AS TotalSales
FROM Sales
GROUP BY ProductID;

-- Total Sales by Customer
SELECT CustomerID, SUM(TotalAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID;

-- Monthly Sales Analysis
SELECT DATE_FORMAT(SaleDate, '%Y-%m') AS Month, SUM(TotalAmount) AS TotalSales
FROM Sales
GROUP BY DATE_FORMAT(SaleDate, '%Y-%m');

-- Top 5 Customers by Sales
SELECT CustomerID, SUM(TotalAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID
ORDER BY TotalSales DESC
LIMIT 5;

-- Top 5 Products by Sales
SELECT ProductID, SUM(TotalAmount) AS TotalSales
FROM Sales
GROUP BY ProductID
ORDER BY TotalSales DESC
LIMIT 5;
