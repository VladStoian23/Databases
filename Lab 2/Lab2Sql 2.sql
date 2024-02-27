CREATE DATABASE SneakerStoreDB;
GO

USE SneakerStoreDB;
GO


CREATE TABLE Customers(
	CustomerID INT PRIMARY KEY,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	Email VARCHAR(100),
	PhoneNumber VARCHAR(20));

CREATE TABLE Brands(
	BrandID INT PRIMARY KEY,
	BrandName VARCHAR(50),
	CountryOfOrigin VARCHAR(50)
	
	);
CREATE TABLE Categories(
	CategoryID INT PRIMARY KEY,
	CategoryName VARCHAR(50)

);

CREATE TABLE Products(
	ProductID INT PRIMARY KEY,
	ProductName VARCHAR(100),
	BrandID INT,
	CategoryID INT,
	Price DECIMAL(10,2),
	StockQuantity INT,
	FOREIGN KEY (BrandID) REFERENCES Brands(BrandID),
	FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
	);

CREATE TABLE Orders(
	OrderID INT PRIMARY KEY,
	CustomerID INT,
	OrderDate DATE,
	TotalAmount Decimal(10,2),
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
	);
CREATE TABLE OrderDetails(
	OrderDetailID INT PRIMARY KEY,
	OrderID INT,
	ProductID INT,
	Quantity INT,
	Subtotal DECIMAL(10,2),
	FOREIGN KEY (OrderID) References Orders(OrderID),
	FOREIGN KEY (ProductID) References Products(ProductID)
	);


CREATE TABLE HighValueProducts (
    ProductID INT PRIMARY KEY,
    CONSTRAINT FK_HighValue_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    CHECK (ProductID IS NOT NULL)
);

CREATE TABLE LowStockProducts (
    ProductID INT PRIMARY KEY,
    CONSTRAINT FK_LowStock_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    CHECK (ProductID IS NOT NULL)
);


DROP  RunningShoes;