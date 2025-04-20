USE FShop
-- Query District of each province
SELECT p.FullNameEn, d.FullNameEn, w.FullNameEn, w.Code FROM Provinces p
LEFT JOIN Districts d ON d.ProvinceCode = p.Code
LEFT JOIN Wards w ON w.DistrictCode = d.Code
WHERE p.Code = 94 AND d.Code = 944

-- Query Orders ordered by orderID
SELECT o.OrderID, od.SKU, MIN(i.[Image])
FROM Orders o 
LEFT JOIN OrderDetails od ON o.OrderID = od.OrderID
LEFT JOIN Products i ON od.SKU = i.SKU 
GROUP BY o.OrderID, od.SKU, od.Quantity
GO
WITH RankedProducts AS (
    SELECT SKU, FullName, Image,
           ROW_NUMBER() OVER (PARTITION BY SKU ORDER BY SKU) AS rn
    FROM Products
)
SELECT SKU, FullName, Image
FROM RankedProducts
WHERE rn = 1;
GO
SELECT * FROM Orders o 
LEFT JOIN OrderStatus ot ON o.Status = ot.ID 

-- Query OrderDetails
SELECT * 
FROM OrderDetails;

-- Query Carts
SELECT c.SKU, c.Quantity, p.[Image], p.FullName, sp.Price, p.CategoryID  
FROM Carts c 
LEFT JOIN Products p ON c.SKU = p.SKU
LEFT JOIN ShopProducts sp ON p.SKU = sp.SKU
WHERE c.CustomerID = 1
SELECT * FROM Customers
-- Query Accounts
SELECT * 
FROM Customers;

-- Query Products
SELECT p.FullName, p.Model, p.[Status], [at].AttributeName, a.AttributeInfor 
FROM Products p 
LEFT JOIN AttributeDetails a ON p.SKU = a.PSKU
LEFT JOIN Attributes [at] ON a.AttributeID = [at].AID


SELECT * FROM InventoryProducts

SELECT * FROM ShopProducts

	SELECT a.AddressID, a.Street, w.FullNameEn, d.FullNameEn, p.FullNameEn, a.IsDefault FROM Addresses a
	LEFT JOIN Provinces p ON a.Province = p.Code
	LEFT JOIN Districts d ON a.District = d.Code
	LEFT JOIN Wards w ON a.Ward = w.Code
	Where CustomerID = 1 AND a.IsDefault = 1

SELECT a.AddressID, a.Street, w.NameEn, d.NameEn, p.NameEn, a.IsDefault FROM Addresses a
LEFT JOIN Provinces p ON a.Province = p.Code
LEFT JOIN Districts d ON a.District = d.Code
LEFT JOIN Wards w ON a.Ward = w.Code
Where CustomerID = 1

SELECT * FROM Wards WHERE DistrictCode LIKE '944'

SELECT * FROM ShopProducts

SELECT * 
FROM Products;

SELECT * 
FROM Products JOIN Products ON Laptops.pd_SKU = Products.pd_SKU
JOIN Suppliers ON Products.brandID = Suppliers.supplierID;

SELECT * FROM Products WHERE  AND price BETWEEN 20000000 AND 25000000)


SELECT * 
FROM Suppliers;

SELECT * 
FROM Brands;

SELECT * 
FROM Categories;

SELECT * 
FROM [Roles];
-- Delete from Carts
-- DELETE FROM Carts WHERE pd_ID = 2 AND a_ID LIKE 'user1';

-- Query for Laptops with specific brand and price range

SELECT * 
FROM Laptops 
JOIN Products ON Laptops.pd_ID = Products.pd_ID
WHERE Laptops.pd_ID IN (
    SELECT pd_ID 
    FROM Products 
    WHERE pd_ID IN (SELECT pd_ID FROM Laptops) 
      AND brandID IN (9) 
      AND (price BETWEEN 25000000 AND 30000000 OR price BETWEEN 35000000 AND 40000000)
);



SELECT * FROM Products P JOIN Brands B ON P.BrandID = B.BrandID
WHERE B.Name IN (SELECT Name FROM Brands WHERE [Name] IN ('Apple'))

SELECT * FROM Products P JOIN Brands B ON P.BrandID = B.BrandID
WHERE B.Name IN (SELECT Name FROM Brands WHERE Name IN ('Apple'))

select * from Brands




-- Query for Laptops with Asus brand and specific price range
SELECT * 
FROM Laptops 
JOIN Products ON Laptops.pd_ID = Products.pd_ID
WHERE Laptops.pd_ID IN (
    SELECT pd_ID 
    FROM Products 
    WHERE pd_ID IN (SELECT pd_ID FROM Laptops) 
      AND brandID IN (8) 
      AND (price BETWEEN 25000000 AND 30000000 OR price BETWEEN 30000000 AND 35000000)
);select * from Products where CategoryID = 1
SELECT * FROM Employees
SELECT * FROM Roles


SELECT DISTINCT B.[Name] FROM Brands B JOIN Products P ON B.BrandID = P.BrandID WHERE P.CategoryID IN (SELECT CategoryID FROM Categories WHERE [Name] = 'Laptop')

SELECT * FROM Products P JOIN Brands B ON P.BrandID = B.BrandID WHERE B.Name IN (SELECT Name FROM Brands WHERE Name IN ('Apple')) AND WHERE P.CategoryID IN (SELECT CategoryID FROM Categories WHERE [Name] = 'Laptop')

SELECT * FROM Products P JOIN Brands B ON P.BrandID = B.BrandID WHERE B.Name IN (SELECT Name FROM Brands WHERE  AND price > 30000000) AND P.CategoryID IN (SELECT CategoryID FROM Categories WHERE [Name] = 'Laptop')

SELECT * FROM Products P JOIN Brands B ON P.BrandID = B.BrandID WHERE B.Name IN (SELECT Name FROM Brands WHERE Name IN ('Apple', 'Asus', 'Dell', 'Lenovo', 'MSI')) AND P.CategoryID IN (SELECT CategoryID FROM Categories WHERE [Name] = 'Laptop')

SELECT * FROM Products P JOIN Brands B ON P.BrandID = B.BrandID WHERE B.Name IN (SELECT Name FROM Brands WHERE Name IN ('Apple', 'Asus', 'Dell', 'Lenovo', 'MSI') AND price BETWEEN 20000000 AND 25000000) AND P.CategoryID IN (SELECT CategoryID FROM Categories WHERE [Name] = 'Laptop')

SELECT * FROM Products P JOIN Brands B ON P.BrandID = B.BrandID WHERE B.Name IN (SELECT Name FROM Brands WHERE Name IN ('Apple', 'Asus', 'Dell', 'Lenovo', 'MSI') AND (price BETWEEN 20000000 AND 25000000 OR price BETWEEN 25000000 AND 30000000)) AND P.CategoryID IN (SELECT CategoryID FROM Categories WHERE [Name] = 'Laptop')


SELECT * FROM Products
SELECT * FROM ImportOrders
SELECT * FROM ImportOrderDetails

UPDATE Products SET Stock = 10 WHERE ProductID IN (1, 2, 3)

UPDATE Products SET Stock = Stock + 10 WHERE ProductID = 1, Stock = Stock + 11 WHERE ProductID = 2

UPDATE P SET P.Stock = P.Stock + D.Quantity FROM Products P INNER JOIN ImportOrderDetails D ON P.ProductID = D.ProductID WHERE D.IOID = 4

UPDATE ImportOrders SET Completed = 1, ImportDate = GETDATE(), TotalCost = 1 WHERE IOID = 4


UPDATE Products SET Stock = Stock + CASE WHEN ProductID = 1 THEN 10 ELSE 0 END

UPDATE Products SET Stock = Stock + CASE WHEN ProductID = 1 THEN 1 ProductID = 3 THEN 1 ProductID = 5 THEN 1 ELSE 0 END

UPDATE Products SET Stock = Stock + CASE WHEN ProductID = 1 THEN 1  WHEN ProductID = 3 THEN 1  WHEN ProductID = 5 THEN 1 END WHERE ProductID IN (1, 3, 5);


UPDATE Products SET Stock = Stock + CASE WHEN ProductID = 1 THEN 1  WHEN ProductID = 3 THEN 1  WHEN ProductID = 5 THEN 1 END WHERE ProductID IN ((1, 3, 5), 1(1, 3, 5), 3(1, 3, 5), 51, 3, 5), 1(1, 3, 5), 3(1, 3, 5), 5)


UPDATE Products SET Stock = Stock + CASE WHEN ProductID = 1 THEN 1 END WHERE ProductID IN ((1, 3, 5)(1)1, 3, 5)(1))


UPDATE Products SET Stock = Stock + CASE WHEN ProductID = 1 THEN 1 END WHERE ProductID IN (1)

UPDATE Products SET Stock = Stock + CASE WHEN ProductID = 1 THEN 1 WHEN ProductID = 3 THEN 1 WHEN ProductID = 5 THEN 1 END WHERE ProductID IN (1, 3, 5)

UPDATE Products SET Stock = Stock + CASE WHEN ProductID = 1 THEN 1 WHEN ProductID = 3 THEN 4 WHEN ProductID = 5 THEN 4 WHEN ProductID = 7 THEN 5 WHEN ProductID = 10 THEN 1 END WHERE ProductID IN (1, 3, 5, 7, 10)

DELETE ImportOrderDetails WHERE ProductID = 3 AND IOID = 5

DELETE ImportOrderDetails WHERE ProductID = 3 AND IOID = 5

DELETE ImportOrders WHERE IOID in (13, 14, 15, 16)

SELECT * FROM ImportOrders WHERE ImportDate BETWEEN '06-03 00:00:00' AND '2025-03-06 23:59:59'

SELECT sp.ProductID, c.Name AS CategoryName, b.Name AS BrandName, sp.FullName, sp.Price, sp.Image, sp.Stock, sp.isDeleted, sp.Description, sp.Model FROM Products sp JOIN Categories c ON sp.CategoryID = c.CategoryID JOIN Brands b ON sp.BrandID = b.BrandID WHERE sp.FullName LIKE '%apple%'
select * from Products

SELECT SUM(Stock) AS TotalStock
FROM Products;


SELECT 
    p.FullName AS ProductName,
    COALESCE(SUM(od.Quantity), 0) AS SoldQuantity,   
    ROUND((COALESCE(SUM(od.Quantity), 0) * 100.0) / p.Stock, 3) AS SoldPercentage
FROM 
    Products p
LEFT JOIN 
    OrderDetails od ON p.ProductID = od.ProductID
GROUP BY 
    p.ProductID, p.FullName, p.Stock
ORDER BY 
    SoldPercentage DESC;



SELECT * FROM Products
SELECT * FROM OrderDetails
SELECT * FROM OrderStatus

SELECT 
    c.FullName AS CustomerName,
    c.Email AS CustomerEmail,
    COUNT(o.OrderID) AS SuccessfulOrders
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    OrderStatus os ON o.Status = os.ID
WHERE 
    os.[Status] = 'Waiting for acceptance'  
GROUP BY 
    c.CustomerID, c.FullName, c.Email
ORDER BY 
    SuccessfulOrders DESC;


SELECT p.Model AS Model, p.Stock AS StockQuantity
FROM Products p
WHERE p.CategoryID = 2 ;
SELECT * FROM Products
SELECT * FROM ImportOrders
SELECT * FROM Categories;
SELECT * FROM Orders
SELECT * FROM OrderDetails

SELECT 
    MONTH(o.OrderedDate) AS Month,
    SUM(od.Quantity * od.Price) AS Revenue
FROM 
    Products p
JOIN 
    OrderDetails od ON p.ProductID = od.ProductID
JOIN 
    Orders o ON od.OrderID = o.OrderID
WHERE 
    p.CategoryID = 2
  
GROUP BY 
    p.Model,  MONTH(o.OrderedDate)
ORDER BY 
    Month Asc

	SELECT 
    p.ProductID, 
    p.FullName AS ProductName,
    p.Model,
    p.Description,
    p.Stock AS StockQuantity,
    c.Name AS CategoryName,
    b.Name AS BrandName,
    s.Name AS SupplierName,
    i.ImportDate AS LastImportDate,
    iod.Quantity AS ImportedQuantity,
    p.Price AS ProductPrice
FROM 
    Products p
JOIN 
    Categories c ON p.CategoryID = c.CategoryID
JOIN 
    Brands b ON p.BrandID = b.BrandID
LEFT JOIN 
    ImportOrderDetails iod ON p.ProductID = iod.ProductID
LEFT JOIN 
    ImportOrders i ON iod.IOID = i.IOID
LEFT JOIN 
    Suppliers s ON i.SupplierID = s.SupplierID
	WHERE c.CategoryID = 1
ORDER BY 
    p.ProductID;




SELECT 
 c.Name AS CategoryName,
 	 b.Name AS BrandName,
     p.Model,

    p.FullName AS ProductName,
    p.Stock AS StockQuantity,  

    s.Name AS SupplierName,
    i.ImportDate AS LastImportDate,
    iod.Quantity AS ImportedQuantity,
    iod.ImportPrice AS ProductImportPrice 
FROM 
    Products p
JOIN 
    Categories c ON p.CategoryID = c.CategoryID
JOIN 
    Brands b ON p.BrandID = b.BrandID
LEFT JOIN 
    ImportOrderDetails iod ON p.ProductID = iod.ProductID
LEFT JOIN 
    ImportOrders i ON iod.IOID = i.IOID
LEFT JOIN 
    Suppliers s ON i.SupplierID = s.SupplierID
ORDER BY 
    c.CategoryID;

SELECT 
    CONVERT(DATE, o.OrderedDate) AS OrderDate,
    SUM(od.Quantity * od.Price) AS TotalRevenue
FROM 
    Orders o
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID

GROUP BY 
    CONVERT(DATE, o.OrderedDate)
ORDER BY 
    OrderDate DESC;

SELECT 
    YEAR(o.OrderedDate) AS OrderYear,
    MONTH(o.OrderedDate) AS OrderMonth,
    SUM(od.Quantity * od.Price) AS TotalRevenue
FROM 
    Orders o
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID

GROUP BY 
    YEAR(o.OrderedDate), MONTH(o.OrderedDate)
ORDER BY 
    OrderYear DESC, OrderMonth DESC;


	SELECT 
    YEAR(o.OrderedDate) AS OrderYear,
    SUM(od.Quantity * od.Price) AS TotalRevenue
FROM 
    Orders o
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
GROUP BY 
    YEAR(o.OrderedDate)
ORDER BY 
    OrderYear DESC;

	-- Revenue Statistic by Day
SELECT 
    CONVERT(DATE, o.OrderedDate) AS OrderDate, 
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(od.Quantity * od.Price) AS TotalRevenue,
    SUM(od.Quantity) AS TotalProductsSold
FROM 
    Orders o
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
GROUP BY 
    CONVERT(DATE, o.OrderedDate)
ORDER BY 
    OrderDate DESC;
	SELECT 
    YEAR(o.OrderedDate) AS OrderYear,
    MONTH(o.OrderedDate) AS OrderMonth,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(od.Quantity * od.Price) AS TotalRevenue,
    SUM(od.Quantity) AS TotalProductsSold
FROM 
    Orders o
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID

GROUP BY 
    YEAR(o.OrderedDate), MONTH(o.OrderedDate)

	SELECT 
    YEAR(o.OrderedDate) AS OrderYear,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(od.Quantity * od.Price) AS TotalRevenue,
    SUM(od.Quantity) AS TotalProductsSold
FROM 
    Orders o
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID

GROUP BY 
    YEAR(o.OrderedDate)
ORDER BY 
    OrderYear DESC;

SELECT TOP 5 * FROM ImportOrders I JOIN ImportOrderDetails D ON I.IOID = D.IOID

SELECT 
    CAST(I.ImportDate AS DATE) AS ImportDate, 
    SUM(D.Quantity) AS TotalQuantity
FROM ImportOrders I
JOIN ImportOrderDetails D ON I.IOID = D.IOID
WHERE CAST(I.ImportDate AS DATE) IN (
    SELECT DISTINCT TOP 5 CAST(ImportDate AS DATE)
    FROM ImportOrders
    ORDER BY CAST(ImportDate AS DATE) DESC
)
GROUP BY CAST(I.ImportDate AS DATE)
ORDER BY ImportDate DESC;


SELECT TOP 3 FORMAT(I.ImportDate, 'yyyy-MM') AS ImportMonth, SUM(D.Quantity) AS TotalQuantity
FROM ImportOrders I
JOIN ImportOrderDetails D ON I.IOID = D.IOID
GROUP BY FORMAT(I.ImportDate, 'yyyy-MM')
ORDER BY ImportMonth DESC;

SELECT TOP 5 s.SupplierID, s.Name AS SupplierName, COUNT(io.IOID) AS OrderCount
FROM ImportOrders io
JOIN Suppliers s ON io.SupplierID = s.SupplierID
GROUP BY s.SupplierID, s.Name
ORDER BY OrderCount DESC;



SELECT TOP 5 D.ProductID, P.Model, SUM(D.Quantity) AS TotalQuantity
FROM ImportOrderDetails D
JOIN Products P ON D.ProductID = P.ProductID
GROUP BY D.ProductID, P.Model
ORDER BY TotalQuantity DESC;



SELECT io.import_date, SUM(iod.quantity * iod.price) AS total_amount
FROM ImportOrders io
JOIN ImportOrderDetails iod ON io.id = iod.import_order_id
GROUP BY io.import_date
ORDER BY io.import_date DESC;

SELECT 
    CONVERT(DATE, io.ImportDate) AS ImportDay,
    SUM(iod.Quantity * iod.ImportPrice) AS TotalAmount
FROM ImportOrders io
JOIN ImportOrderDetails iod ON io.IOID = iod.IOID
GROUP BY CONVERT(DATE, io.ImportDate)
ORDER BY ImportDay DESC;

SELECT 
    FORMAT(io.ImportDate, 'yyyy-MM') AS ImportMonth,
    SUM(iod.Quantity * iod.ImportPrice) AS TotalAmount
FROM ImportOrders io
JOIN ImportOrderDetails iod ON io.IOID = iod.IOID
GROUP BY FORMAT(io.ImportDate, 'yyyy-MM')
ORDER BY ImportMonth DESC;

SELECT *, B.Name AS BrandName FROM Products P JOIN Categories C ON P.CategoryID = C.CategoryID JOIN Brands B ON B.BrandID = P.BrandID WHERE C.Name = 'Laptop' AND P.IsDeleted = 0

select * from Employees

SELECT *
FROM ImportOrderDetails IOD
JOIN ImportOrders IO ON IOD.IOID = IO.IOID
JOIN Products P ON IOD.ProductID = P.ProductID
WHERE CAST(IO.ImportDate AS DATE) = CAST(GETDATE() AS DATE);

select * from ImportOrderDetails
select * from ImportOrders
select * from Products


SELECT 
  c.Name AS CategoryName,
  b.Name AS BrandName,
 p.Model,
 p.FullName AS ProductName,
             p.Stock AS StockQuantity, 
                s.Name AS SupplierName,
      i.ImportDate AS LastImportDate,
     iod.ImportPrice AS ProductImportPrice
      FROM 
            Products p
           JOIN 
              Categories c ON p.CategoryID = c.CategoryID
              JOIN
             Brands b ON p.BrandID = b.BrandID
                LEFT JOIN 
               ImportOrderDetails iod ON p.ProductID = iod.ProductID
                LEFT JOIN
               ImportOrders i ON iod.IOID = i.IOID
               LEFT JOIN 
              Suppliers s ON i.SupplierID = s.SupplierID
               ORDER BY
                c.CategoryID