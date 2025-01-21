-- Create Sales table
CREATE TABLE Sales (
    SaleID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    SaleDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create Sales_Details table
CREATE TABLE Sales_Details (
    SaleDetailID INT AUTO_INCREMENT PRIMARY KEY,
    SaleID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (SaleID) REFERENCES Sales(SaleID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert sample data into Sales
INSERT INTO Sales (CustomerID, TotalAmount) VALUES
(1, 1200.00),
(2, 500.00);

-- Insert sample data into Sales_Details
INSERT INTO Sales_Details (SaleID, ProductID, Quantity, Subtotal) VALUES
(1, 1, 1, 1200.00), -- Sale 1: 1 Laptop
(2, 2, 2, 500.00); -- Sale 2: 2 Desks

-- Query to list all sales with customer information
SELECT 
    Sales.SaleID,
    Customers.CustomerName,
    Sales.SaleDate,
    Sales.TotalAmount
FROM Sales
JOIN Customers ON Sales.CustomerID = Customers.CustomerID;

-- Query to view details of a specific sale
SELECT 
    Sales_Details.SaleID,
    Products.ProductName,
    Sales_Details.Quantity,
    Sales_Details.Subtotal
FROM Sales_Details
JOIN Products ON Sales_Details.ProductID = Products.ProductID
WHERE Sales_Details.SaleID = 1;

-- Query to calculate total revenue
SELECT 
    SUM(Sales.TotalAmount) AS TotalRevenue
FROM Sales;

-- Query to list top-selling products
SELECT 
    Products.ProductName,
    SUM(Sales_Details.Quantity) AS TotalSold
FROM Sales_Details
JOIN Products ON Sales_Details.ProductID = Products.ProductID
GROUP BY Products.ProductName
ORDER BY TotalSold DESC;
