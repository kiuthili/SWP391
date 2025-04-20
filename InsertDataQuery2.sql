-- Insert a new Order
INSERT INTO Orders (CustomerID, FullName, [Address], PhoneNumber, OrderedDate, DeliveredDate, Status, TotalAmount)
VALUES 
(2, 'Tran Thi B', '456 Nguyen Du Street, District 3, Ho Chi Minh City', '0909876543', '2024-02-15', NULL, 1, 50000000);

-- Insert details of the products in the new order (OrderDetails)
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES 
(13, 1, 2, 50000000),  -- 2 Macbook Pro 14
(13, 2, 3, 75000000);  -- 3 Galaxy S23 Ultra

-- Insert Ratings for the products
INSERT INTO ProductRatings (CustomerID, ProductID, OrderID, CreatedDate, Star, Comment, IsDeleted, IsRead)
VALUES 
(2, 1, 13, GETDATE(), 5, 'Excellent performance and sleek design! Highly recommended.', 0, 0),  -- Rating for Macbook Pro 14
(2, 2, 13, GETDATE(), 4, 'Great phone, but the camera could be improved.', 0, 0);  -- Rating for Galaxy S23 Ultra


-- Insert Rating Replies from Employees
INSERT INTO RatingReplies (EmployeeID, RateID, Answer, IsRead)
VALUES 
(1, 1, 'Thank you for your feedback! We are glad you are happy with the Macbook Pro.', 0),  -- Reply to Macbook Pro 14 rating
(2, 2, 'Thank you for your input! We are always working to improve our products.', 0);  -- Reply to Galaxy S23 Ultra rating


-- Thêm đơn hàng 1 tháng trước
INSERT INTO Orders (CustomerID, FullName, [Address], PhoneNumber, OrderedDate, DeliveredDate, Status, TotalAmount)
VALUES 
(1, 'Nguyen Van A', '123 Tech Street, District 1, Ho Chi Minh City', '0901234567', DATEADD(MONTH, -1, GETUTCDATE()), NULL, 5, 50000000);

-- Chi tiết đơn hàng 1 tháng trước
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES 
(14, 1, 2, 50000000),  -- 2 Macbook Pro 14
(14, 2, 3, 75000000);  -- 3 Galaxy S23 Ultra

-- Thêm đơn hàng 3 tháng trước
INSERT INTO Orders (CustomerID, FullName, [Address], PhoneNumber, OrderedDate, DeliveredDate, Status, TotalAmount)
VALUES 
(2, 'Tran Thi B', '456 Nguyen Du Street, District 3, Ho Chi Minh City', '0909876543', DATEADD(MONTH, -3, GETUTCDATE()), NULL, 5, 75000000);

-- Chi tiết đơn hàng 3 tháng trước
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES 
(15, 3, 2, 20000000),  -- 2 Sony Vaio Z900
(15, 4, 1, 12000000);  -- 1 ASUS TUF Gaming A17

-- Thêm đơn hàng 6 tháng trước
INSERT INTO Orders (CustomerID, FullName, [Address], PhoneNumber, OrderedDate, DeliveredDate, Status, TotalAmount)
VALUES 
(3, 'Le Minh C', '789 Le Lai Street, District 5, Ho Chi Minh City', '0912345678', DATEADD(MONTH, -6, GETUTCDATE()), NULL, 5, 25000000);

-- Chi tiết đơn hàng 6 tháng trước
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES 
(16, 5, 2, 30000000),  -- 2 iPhone-16-Pro-Max
(16, 6, 4, 40000000);  -- 4 Galaxy-S23

-- Thêm đơn hàng 12 tháng trước
INSERT INTO Orders (CustomerID, FullName, [Address], PhoneNumber, OrderedDate, DeliveredDate, Status, TotalAmount)
VALUES 
(4, 'Pham Thi D', '321 Pham Ngoc Thach, District 1, Ho Chi Minh City', '0923456789', DATEADD(MONTH, -12, GETUTCDATE()), NULL, 5, 12000000);

-- Chi tiết đơn hàng 12 tháng trước
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES 
(17, 7, 3, 60000000),  -- 3 Lenovo Legion Pro 5
(17, 8, 1, 15000000);  -- 1 ASUS-TUF-A17
