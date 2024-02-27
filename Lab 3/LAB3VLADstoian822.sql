use SneakerStoreDB
go

-- Stored Procedures

--drop table DatabaseVersion

CREATE TABLE DatabaseVersion
(
	Version INT NOT NULL
);

GO

INSERT INTO DatabaseVersion
VALUES (3)

GO

CREATE OR ALTER PROCEDURE do_1  -- ADD  a COLUMN
AS
BEGIN 
	ALTER TABLE	Customers
	ADD Location varchar(50);

	-- Log version
	UPDATE DatabaseVersion SET Version=2;
END;

GO

EXEC do_1
GO

CREATE OR ALTER PROCEDURE undoFirst  -- DELETE COLUMN
AS
BEGIN
	ALTER TABLE	Customers
	DROP COLUMN Location;

	-- Log version
	UPDATE DatabaseVersion SET Version=1;
END;

GO

Exec undoFirst
GO

CREATE OR ALTER PROCEDURE do_2  -- WE ADD A DEFAULT CONSTRAINT
AS
BEGIN
	ALTER TABLE Customers
	ADD CONSTRAINT DF_Customers_Email DEFAULT 'email@gmail.com' FOR Email;
	-- Log version
	UPDATE DatabaseVersion SET Version=3;
END;

GO

Exec do_2
GO

CREATE OR ALTER PROCEDURE undoSecond  -- DELETE DEFAULT CONSTRAINT
AS
BEGIN
	ALTER TABLE Customers
	DROP CONSTRAINT DF_Customers_Email;

	-- Log version
	UPDATE DatabaseVersion SET Version=2;
END;

GO

Exec undoSecond
Go

CREATE OR ALTER PROCEDURE do_3  -- ADD A TABLE
AS
BEGIN
	CREATE TABLE FlashSale 
	(
	  SaleId INT PRIMARY KEY Identity,
	  SaleSeason VarChar(50) not Null,
	  ProductID INT
	);

	-- Log version
	UPDATE DatabaseVersion SET Version=4;
END;

GO

Exec do_3
GO

CREATE OR ALTER PROCEDURE undoThird  -- DELETE TABLE
AS
BEGIN
	DROP TABLE FlashSale

	-- Log version
	UPDATE DatabaseVersion SET Version=3;
END;

GO
Exec undoThird
GO

CREATE OR ALTER PROCEDURE do_4 
AS
BEGIN
	ALTER TABLE FlashSale 
	ADD CONSTRAINT FK_Product 
	FOREIGN KEY (ProductID) REFERENCES Products(ProductID)

	-- Log version
	UPDATE DatabaseVersion SET Version=5;
END;

Exec do_4
go

CREATE OR ALTER PROCEDURE undoForth  -- DELETEING FOREIGN KEY
AS
BEGIN
	ALTER TABLE FlashSale
	DROP CONSTRAINT FK_Product;

	-- Log version
	UPDATE DatabaseVersion SET Version=4;
END;
go

exec undoForth
go

CREATE OR ALTER  PROCEDURE goToVersion @TargetVersion INT
AS
BEGIN
	DECLARE @CurrentVersion INT;

	-- Get current version
	SELECT @CurrentVersion = Version FROM DatabaseVersion;

		-- Apply each operation
		WHILE @CurrentVersion < @TargetVersion
		BEGIN 
			SELECT @CurrentVersion = Version FROM DatabaseVersion;

			IF @CurrentVersion = 1
			BEGIN
				EXEC do_1;
			END
			ELSE IF @CurrentVersion = 2
			BEGIN
				EXEC do_2;
			END
			ELSE IF @CurrentVersion = 3
			BEGIN
				EXEC do_3;
			END
			ELSE IF @CurrentVersion = 4
			BEGIN
				EXEC do_4;
			END

			-- UPDATE @CurrentVersion
		
			SELECT @CurrentVersion = Version FROM DatabaseVersion;
		END;
		WHILE @CurrentVersion > @TargetVersion
		BEGIN
			SELECT @CurrentVersion = Version FROM DatabaseVersion;
			IF @CurrentVersion = 2
			BEGIN
				EXEC undoFirst;
			END
			ELSE IF @CurrentVersion = 3
			BEGIN
				EXEC undoSecond;
			END
			ELSE IF @CurrentVersion = 4
			BEGIN
				EXEC undoThird;
			END
			ELSE IF @CurrentVersion = 5
			BEGIN
				EXEC undoForth;
			END
			
			SELECT @CurrentVersion = Version FROM DatabaseVersion;
		END;
END;

exec goToVersion 2;
Select * from DatabaseVersion
