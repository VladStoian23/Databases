use SneakerStoreDB
go

--a)user defined function for Brand existance validation
CREATE FUNCTION dbo.BrandExistent(@BrandName VARCHAR (100))
RETURNS BIT
AS
BEGIN
	DECLARE  @BrandExistent BIT;

	If EXISTS(SELECT 1 FROM Brands WHERE BrandName=@BrandName)
		SET @BrandExistent =1; --TRUE
	else
		SET @BrandExistent=0;--false

		Return @BrandExistent;
END;
GO

	CREATE OR ALTER PROCEDURE InsertProductsAndBrands
    @BrandName VARCHAR(50),
    @Price INT,
    @StockQuantity INT,
    @ProductID INT OUTPUT
AS 
BEGIN
    DECLARE @BrandID INT;

    -- if the brand exists
    IF NOT EXISTS (SELECT 1 FROM Brands WHERE BrandName = @BrandName)
    BEGIN
        INSERT INTO Brands (BrandName)
        VALUES (@BrandName);

        SET @BrandID = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        --  get the BrandID
        SET @BrandID = (SELECT BrandID FROM Brands WHERE BrandName = @BrandName);
    END

    -- Insert into Products table
    INSERT INTO Products (ProductName, BrandID, Price, StockQuantity)
    VALUES (@BrandName, @BrandID, @Price, @StockQuantity);

    SET @ProductID = SCOPE_IDENTITY();
END;

GO


	--b)
CREATE VIEW ProductViews AS 
    SELECT 
        P.ProductName,
        B.BrandName,
        P.Price,
        P.StockQuantity,
        B.CountryOfOrigin
    FROM Products P
    JOIN Brands B ON P.BrandID = B.BrandID;
go

SELECT * FROM ProductViews;
GO

--c)
--CREATE CHANGELOG TABLE and a trigger 
CREATE TABLE ChangeLog
(
	ChangeLogID int PRIMARY KEY IDENTITY(1,1),
	ChangeDate DATETIME,
	ActionType VARCHAR (50),
	NameOfTable Varchar(50),
	RecordCounter INT


);
GO

create or alter trigger LogChanging
On Products
AFTER INSERT,UPDATE,DELETE
AS
BEGIN
	Declare @ActionType Varchar(50);

	IF EXISTS (SELECT * FROM inserted)
	Begin 
		If EXISTS(SELECT * From deleted)
			set @ActionType='UPDATE';
		ELSE
			SET @ActionType='INSERT';
	END
	ELSE
		SET @ActionType = 'DELETE';

	DECLARE @RecordCounter INT;

	IF @ActionType ='UPDATE'
		SET @RecordCounter = (SELECT COUNT(*) FROM inserted);
	ELSE
		SET @RecordCounter = (SELECT ISNULL(COUNT(*), 0) FROM inserted) + (SELECT ISNULL(COUNT(*), 0) FROM deleted);

INSERT INTO ChangeLog (ChangeDate,ActionType,NameOfTable,RecordCounter)
Values (GETDATE(),@ActionType,'Products',@RecordCounter);
END;

GO

Update Products
Set ProductName='Product1'
WHERE Price >=102

go

select * from ChangeLog

go

DELETE FROM Products 
WHERE BrandID =3

DELETE FROM Brands
WHERE BrandID=3


--d) Query w clustered index seek and non clustered index scanning
Select *
From Products
WHERE ProductId=1
Order by ProductName;

-- select products with a specific brand and their stockquantity

SELECT
    P1.ProductName,
    B.BrandName,
    P1.StockQuantity
FROM 
    Products P1
JOIN
    Brands B ON P1.BrandID = B.BrandID
JOIN
    Products P2 ON P1.StockQuantity = P2.StockQuantity
WHERE  
    B.BrandName = 'Nike'
ORDER BY
    P1.ProductName;
