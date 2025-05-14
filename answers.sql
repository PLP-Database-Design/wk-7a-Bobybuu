CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(255),
    Products VARCHAR(255)
);

SELECT 
    OrderID,
    CustomerName,
    TRIM(product) AS Product
FROM (
    SELECT 
        OrderID,
        CustomerName,
        JSON_TABLE(
            CONCAT('["', REPLACE(Products, ',', '","'), '"]'),
            "$[*]" COLUMNS (product VARCHAR(255) PATH "$")
        ) AS jt
    FROM ProductDetail
) AS split_products;

SELECT DISTINCT 
    OrderID,
    CustomerName
FROM 
    OrderDetails;

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

SELECT 
    OrderID,
    Product,
    Quantity
FROM 
    OrderDetails;

CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

