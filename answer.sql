-- Week 7 Assignment: Database Design and Normalization
CREATE DATABASE IF NOT EXISTS week7_normalization;
USE week7_normalization;

-- =====================================================
-- Question 1: Achieving First Normal Form (1NF)
-- Problem: the Products column held several values in one cell
-- (e.g. "Laptop, Mouse"). Fix: one product per row.
-- =====================================================
DROP TABLE IF EXISTS ProductDetail;

CREATE TABLE ProductDetail (
    OrderID INT NOT NULL,
    CustomerName VARCHAR(100) NOT NULL,
    Product VARCHAR(100) NOT NULL,
    PRIMARY KEY (OrderID, Product)
);

INSERT INTO ProductDetail (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- =====================================================
-- Question 2: Achieving Second Normal Form (2NF)
-- Partial dependency: CustomerName depends only on OrderID,
-- not on the whole key (OrderID, Product).
-- Fix: move CustomerName into an Orders table, and keep
-- products and quantities in OrderItems.
-- =====================================================
DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
    OrderID INT NOT NULL,
    CustomerName VARCHAR(100) NOT NULL,
    PRIMARY KEY (OrderID)
);

CREATE TABLE OrderItems (
    OrderID INT NOT NULL,
    Product VARCHAR(100) NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders (OrderID)
);

INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

INSERT INTO OrderItems (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);
