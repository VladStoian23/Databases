INSERT INTO Customers(CustomerID,FirstName,LastName,Email,PhoneNumber)
VALUES (1,'Vlad','Stoian','vladstoian23@gmail.com','0756360627');
SELECT *FROM Customers Where CustomerID>0;
--insertion 1
INSERT INTO Brands(BrandID,BrandName,CountryOfOrigin)
VALUES (1,'Nike','USA');
--insertion 2
INSERT INTO Categories(CategoryID,CategoryName)
VALUES (1,'RunningShoes');
--insertion 3
INSERT INTO Products(ProductID,ProductName,BrandID,CategoryID,Price,StockQuantity)
VALUES 
	(4, 'Product1', 1, 1, 59.99, 10),
    (2, 'Product2', 1, 1, 45.00, 20);
--insertion 4
SELECT *FROM Products where BrandID=1;

INSERT INTO Orders(OrderID,CustomerID,OrderDate,TotalAmount)
VALUES (1,1,'2023-11-22',160.99);
--insertion 5

INSERT INTO OrderDetails(OrderDetailID,OrderID,ProductID,Quantity,Subtotal)
VALUES (1,1,1,2,59.99);
SELECT *FROM OrderDetails WHERE OrderID=1;

--Update data for at least 1 table 
UPDATE Customers
SET Email='changed.email@gmail.com'
WHERE CustomerID=1 and Email like '%.com';

SELECT *from Customers

--delete date from at least 1 table (1)
DELETE FROM OrderDetails
WHERE OrderID IS NOT NULL;
--delete (2)
DELETE FROM Orders
WHERE OrderID=1;

SELECT * FROM Orders;

SELECT * FROM OrderDetails WHERE OrderID = 1;
--update WHERE conditiomn
UPDATE Products
SET Price =Price * 1.5
WHERE Price in (60,70,80);
SELECT *FROM Products WHERE Price>1;


SELECT *FROM Orders WHERE CustomerID>0;
SELECT *from Customers;
DELETE FROM Orders
WHERE CustomerID IN(
	SELECT CustomerID
	FROM Customers
	WHERE LastName='Stoian'
)AND TotalAmount>0;


INSERT INTO HighValueProducts(ProductID) VALUES (2);
SELECT *FROM HighValueProducts Where ProductID>0
INSERT INTO LowStockProducts (ProductID) VALUES (2);
SELECT *FROM LowStockProducts Where ProductID>0

INSERT INTO RunningShoes (ProductID) VALUES (1);
INSERT INTO RunningShoes (ProductID) VALUES (2);
SELECT *FROM RunningShoes Where ProductID>0

SELECT *FROM Products Where ProductID>0
INSERT INTO NewArrivals (ProductID) VALUES (2);
SELECT *FROM NewArrivals Where ProductID>0
INSERT INTO BestSellers (ProductID) VALUES (4);
SELECT *FROM BestSellers Where ProductID>0
INSERT INTO BestSellers (ProductID) VALUES (2);

--UNION
SELECT OrderID from OrderDetails
UNION
SELECT OrderID from OrderDetails; 

--INTERSECT
SELECT ProductID from HighValueProducts
INTERSECT
SELECT ProductID from BestSellers;

--EXCEPT
SELECT ProductID from HighValueProducts
EXCEPT
SELECT ProductID from NewArrivals;

--INNER JOIN 
SELECT Orders.OrderID,Customers.FirstName,Customers.LastName,Products.ProductName
FROM Orders
INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID
INNER JOIN OrderDetails ON Orders.OrderID=OrderDetails.OrderID
INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID;


--Left Join
SELECT Customers.CustomerID, Customers.FirstName, Customers.LastName, Orders.OrderID
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID=Orders.OrderID;

--Right Join
SELECT Orders.OrderID,Customers.FirstName,Customers.LastName
FROM Orders
RIGHT JOIN Customers ON Orders.CustomerID=Customers.CustomerID;


--FULL JOIN
SELECT Customers.CustomerID,Customers.FirstName,Customers.LastName,Orders.OrderID
FROM Customers
FULL JOIN Orders on Customers.CustomerID=Orders.CustomerID;

SELECT ProductID, ProductName
FROM Products
WHERE 
    ProductID IN (SELECT ProductID FROM HighValueProducts)
    OR 
    ProductID IN (SELECT ProductID FROM LowStockProducts);

--2 QUERIES USING IN AND EXIST c)

SELECT DISTINCT ProductID
FROM NewArrivals
WHERE EXISTS(SELECT 1 FROM BestSellers Where BestSellers.ProductID=NewArrivals.ProductID);
SELECT DISTINCT ProductID
FROM NewArrivals;
--IN LOC DE NewArrivals cred ca ar merge WHERE Orders.OrderDate < o valoare setata?

SELECT TOP 2 ProductID
FROM BestSellers
ORDER BY ProductID DESC;

SELECT ProductID
FROM RunningShoes
ORDER BY ProductID;

SELECT ProductID, ProductName
FROM Products
WHERE 
    ProductID IN (SELECT ProductID FROM HighValueProducts)
    OR 
    ProductID IN (SELECT ProductID FROM BestSellers)
ORDER BY ProductName;


SELECT CustomerID,FirstName,LastName
FROM(
	SELECT CustomerID,FirstName,LastName
	FROM Customers
	WHERE Email like '%.com'
	)AS Subquery;

