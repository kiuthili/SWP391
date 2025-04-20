-- dữ liệu để thống kê sản phẩm bán chạy theo tuần
CREATE TABLE #InsertedOrders (OrderID INT);

-- Insert thêm nhiều đơn hàng với trạng thái "Delivered" để thống kê bán hàng
INSERT INTO Orders (CustomerID, FullName, [Address], PhoneNumber, OrderedDate, DeliveredDate, Status, TotalAmount)
OUTPUT INSERTED.OrderID INTO #InsertedOrders -- Lưu OrderID mới vào bảng tạm
VALUES 
(1, 'Nguyen Van A', '123 Tech Street, District 1, Ho Chi Minh City', '0901234567', DATEADD(DAY, -1, GETDATE()), GETDATE(), 4, 50000000),
(1, 'Nguyen Van A', '123 Tech Street, District 1, Ho Chi Minh City', '0901234567', DATEADD(DAY, -7, GETDATE()), DATEADD(DAY, -6, GETDATE()), 4, 60000000),
(1, 'Nguyen Van A', '123 Tech Street, District 1, Ho Chi Minh City', '0901234567', DATEADD(DAY, -14, GETDATE()), DATEADD(DAY, -13, GETDATE()), 4, 40000000),
(1, 'Nguyen Van A', '123 Tech Street, District 1, Ho Chi Minh City', '0901234567', DATEADD(DAY, -30, GETDATE()), DATEADD(DAY, -29, GETDATE()), 4, 30000000),
(1, 'Nguyen Van A', '123 Tech Street, District 1, Ho Chi Minh City', '0901234567', DATEADD(DAY, -60, GETDATE()), DATEADD(DAY, -59, GETDATE()), 4, 20000000);

-- Insert chi tiết đơn hàng (OrderDetails) chỉ khi OrderID hợp lệ
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
SELECT OrderID, ProductID, Quantity, Price FROM 
(
    SELECT (SELECT MIN(OrderID) FROM #InsertedOrders) AS OrderID, 1 AS ProductID, 2 AS Quantity, 50000000 AS Price UNION ALL
    SELECT (SELECT MIN(OrderID) FROM #InsertedOrders), 5, 3, 32529000 UNION ALL
    SELECT (SELECT MIN(OrderID) + 1 FROM #InsertedOrders), 2, 5, 30000000 UNION ALL
    SELECT (SELECT MIN(OrderID) + 1 FROM #InsertedOrders), 7, 1, 38909000 UNION ALL
    SELECT (SELECT MIN(OrderID) + 2 FROM #InsertedOrders), 3, 2, 20000000 UNION ALL
    SELECT (SELECT MIN(OrderID) + 2 FROM #InsertedOrders), 6, 3, 25899000 UNION ALL
    SELECT (SELECT MIN(OrderID) + 3 FROM #InsertedOrders), 4, 2, 28909000 UNION ALL
    SELECT (SELECT MIN(OrderID) + 3 FROM #InsertedOrders), 8, 1, 31909000 UNION ALL
    SELECT (SELECT MIN(OrderID) + 4 FROM #InsertedOrders), 9, 4, 33909000 UNION ALL
    SELECT (SELECT MIN(OrderID) + 4 FROM #InsertedOrders), 10, 3, 35909000
) AS OrderDetailsData
WHERE EXISTS (SELECT 1 FROM Orders WHERE OrderID = OrderDetailsData.OrderID);

-- Xóa bảng tạm sau khi sử dụng
DROP TABLE #InsertedOrders;
-----------------------------------------------------------------------


--------------------------------------------------------------------------------
-- dữ liệu để thống kê sản phẩm sắp hết hàng
UPDATE Products
SET Stock = CASE 
    WHEN ProductID = 1 THEN 2   -- MacBook Pro 14 còn 2 cái (Low Stock)
    WHEN ProductID = 2 THEN 5   -- Galaxy S23 Ultra còn 5 cái
    WHEN ProductID = 5 THEN 3   -- iPhone 16 Pro Max còn 3 cái
    WHEN ProductID = 9 THEN 1   -- MSI Katana A15 gần hết hàng
    ELSE Quantity
END
WHERE ProductID IN (1, 2, 5, 9);
-----------------------------------------------------------------------


-----------------------------------------------------------------------
-- Tạo bảng tạm để lưu OrderID mới

-- Thêm nhiều đơn hàng theo tháng/năm
INSERT INTO Orders (CustomerID, FullName, [Address], PhoneNumber, OrderedDate, DeliveredDate, Status, TotalAmount)
OUTPUT INSERTED.OrderID INTO #InsertedOrders
VALUES 
(2, 'Tran Thi B', '456 Digital Avenue, Hanoi', '0912345678', DATEADD(MONTH, -1, GETDATE()), DATEADD(MONTH, -1, GETDATE()), 4, 70000000),
(3, 'Le Van C', '789 Future Road, Da Nang', '0923456789', DATEADD(MONTH, -2, GETDATE()), DATEADD(MONTH, -2, GETDATE()), 4, 50000000),
(4, 'Pham Van D', '101 Innovation Blvd, HCM', '0934567890', DATEADD(MONTH, -3, GETDATE()), DATEADD(MONTH, -3, GETDATE()), 4, 65000000),
(5, 'Hoang Thi E', '222 AI Street, Can Tho', '0945678901', DATEADD(MONTH, -6, GETDATE()), DATEADD(MONTH, -6, GETDATE()), 4, 48000000),
(6, 'Nguyen Tuan F', '333 Cloud Lane, Hue', '0956789012', DATEADD(YEAR, -1, GETDATE()), DATEADD(YEAR, -1, GETDATE()), 4, 55000000),
(7, 'Do Thanh G', '444 IoT Drive, HCM', '0967890123', DATEADD(YEAR, -1, GETDATE()), DATEADD(YEAR, -1, GETDATE()), 4, 75000000);

-- Thêm chi tiết đơn hàng với cột tên rõ ràng
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
SELECT * FROM 
(
    SELECT (SELECT MIN(OrderID) FROM #InsertedOrders) AS OrderID, 1 AS ProductID, 2 AS Quantity, 50000000 AS Price UNION ALL
    SELECT (SELECT MIN(OrderID) FROM #InsertedOrders), 3, 1, 20000000 UNION ALL
    SELECT (SELECT MIN(OrderID) + 1 FROM #InsertedOrders), 2, 3, 30000000 UNION ALL
    SELECT (SELECT MIN(OrderID) + 1 FROM #InsertedOrders), 5, 2, 32529000 UNION ALL
    SELECT (SELECT MIN(OrderID) + 2 FROM #InsertedOrders), 4, 2, 28909000 UNION ALL
    SELECT (SELECT MIN(OrderID) + 2 FROM #InsertedOrders), 7, 1, 38909000 UNION ALL
    SELECT (SELECT MIN(OrderID) + 3 FROM #InsertedOrders), 6, 4, 25899000 UNION ALL
    SELECT (SELECT MIN(OrderID) + 3 FROM #InsertedOrders), 8, 2, 31909000 UNION ALL
    SELECT (SELECT MIN(OrderID) + 4 FROM #InsertedOrders), 9, 3, 33909000 UNION ALL
    SELECT (SELECT MIN(OrderID) + 4 FROM #InsertedOrders), 10, 2, 35909000 UNION ALL
    SELECT (SELECT MIN(OrderID) + 5 FROM #InsertedOrders), 2, 2, 30000000 UNION ALL
    SELECT (SELECT MIN(OrderID) + 5 FROM #InsertedOrders), 4, 1, 28909000
) AS OrderDetailsData;

SELECT Categories.Name, SUM(OrderDetails.Quantity) AS totalSold
FROM OrderDetails JOIN Products ON OrderDetails.ProductID = Products.ProductID
JOIN Categories ON Products.CategoryID = Categories.CategoryID
GROUP BY Categories.Name ORDER BY totalSold DESC