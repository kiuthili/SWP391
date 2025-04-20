USE FShop

-- IMPORT STOCK

GO
CREATE OR ALTER PROCEDURE ImportInventoryAndHistory(
    @SKU INT,
	@SupplierID INT,
    @ProductCost BIGINT,
    @Stock INT,
    @EmployeeID INT,
    @Note TEXT)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;

    DECLARE @PackageID INT;
    DECLARE @Price BIGINT;
    DECLARE @Quantity INT;

	BEGIN TRY
		INSERT INTO InventoryProducts (SKU, SupplierID, ProductCost, Stock)
		VALUES (@SKU, @SupplierID, @ProductCost, @Stock);

		SET @PackageID = SCOPE_IDENTITY();
		SET @Price = @ProductCost;
		SET @Quantity = @Stock;

		INSERT INTO InventoryHistories (PackageID, SKU, EmployeeID, TransactionAt, StatusID, Price, Quantity, Note)
		VALUES (@PackageID, @SKU, @EmployeeID, GETDATE(), 1, @Price, @Quantity, @Note);

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

--EXEC ImportInventoryAndHistory @SKU=1, @SupplierID=1, @ProductCost=100, @Stock=10, @EmployeeID=1, @Note='Quy 1'

-- EXPORT STOCK

GO
CREATE OR ALTER PROCEDURE ExportInventoryAndHistory(
    @PackageID INT,
	@SKU INT,
    @EmployeeID INT,
    @Price BIGINT,
    @Quantity INT,
    @Note TEXT)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;

	BEGIN TRY
		DECLARE @CurrentStock INT;
        SELECT @CurrentStock = Stock FROM InventoryProducts WHERE PackageID = @PackageID AND SKU = @SKU;

        IF @CurrentStock < @Quantity
        BEGIN
            THROW 50001, 'Error quantity', 1;
        END

		UPDATE InventoryProducts
		SET Stock = Stock - @Quantity
		WHERE PackageID = @PackageID AND SKU = @SKU;

		INSERT INTO InventoryHistories (PackageID, SKU, EmployeeID, TransactionAt, StatusID, Price, Quantity, Note)
		VALUES (@PackageID, @SKU, @EmployeeID, GETDATE(), 2, @Price, @Quantity, @Note);

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

--EXEC ExportInventoryAndHistory @PackageID = 2, @SKU=1, @EmployeeID = 1, @Price=1000, @Quantity=9, @Note='Sell Quy 1'

--select * from Employees
--select * from InventoryProducts
--select * from InventoryHistories
--select * from Suppliers
--select * from Employees
--select * from InventoryStatus
--select * from InventoryStatus
--select * from ShopProducts