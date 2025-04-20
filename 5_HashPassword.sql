CREATE FUNCTION HASHED_PASSWORD(@password NVARCHAR(255))
RETURNS NVARCHAR(32)
AS
BEGIN
    RETURN CONVERT(NVARCHAR(32), HASHBYTES('MD5', @password), 2)
END
GO

-- Insert Customers
DECLARE @pwd1 NVARCHAR(32), @pwd2 NVARCHAR(32), @pwd3 NVARCHAR(32), @pwd4 NVARCHAR(32), @pwd5 NVARCHAR(32),
        @pwd6 NVARCHAR(32), @pwd7 NVARCHAR(32), @pwd8 NVARCHAR(32), @pwd9 NVARCHAR(32), @pwd10 NVARCHAR(32),
		@pwd11 NVARCHAR(32), @pwd12 NVARCHAR(32), @pwd13 NVARCHAR(32), @pwd14 NVARCHAR(32), @pwd15 NVARCHAR(32), 
		@pwd16 NVARCHAR(32)
SELECT @pwd1 = dbo.HASHED_PASSWORD('password123'),
       @pwd2 = dbo.HASHED_PASSWORD('securepass'),
       @pwd3 = dbo.HASHED_PASSWORD('mysecret'),
       @pwd4 = dbo.HASHED_PASSWORD('pass2024'),
       @pwd5 = dbo.HASHED_PASSWORD('strongpass'),
       @pwd6 = dbo.HASHED_PASSWORD('letmein'),
       @pwd7 = dbo.HASHED_PASSWORD('hiddencode'),
       @pwd8 = dbo.HASHED_PASSWORD('password456'),
       @pwd9 = dbo.HASHED_PASSWORD('pass789'),
       @pwd10 = dbo.HASHED_PASSWORD('secrethash'),
	   @pwd11 = dbo.HASHED_PASSWORD('pass2024'),
       @pwd12 = dbo.HASHED_PASSWORD('strongpass'),
       @pwd13 = dbo.HASHED_PASSWORD('letmein'),
       @pwd14 = dbo.HASHED_PASSWORD('hiddencode'),
       @pwd15 = dbo.HASHED_PASSWORD('password456'),
       @pwd16 = dbo.HASHED_PASSWORD('pass789')

INSERT INTO Customers (FullName, Birthday, [Password], PhoneNumber, Email, Gender, CreatedDate, IsBlock, IsDeleted, Avatar)
VALUES 
('Nguyen Van B', '1995-05-15', @pwd1, '0901234567', 'nguyenvanb@example.com', 'Male', GETDATE(), 0, 0, 'avatar1.jpg'),
('Tran Thi C', '1992-08-21', @pwd2, '0912345678', 'tranthic@example.com', 'Female', GETDATE(), 0, 0, 'avatar2.jpg'),
('Le Van D', '1988-11-10', @pwd3, '0923456789', 'levand@example.com', 'Male', GETDATE(), 0, 0, 'avatar3.jpg'),
('Pham Hong E', '2000-01-05', @pwd4, '0934567890', 'phamhonge@example.com', 'Female', GETDATE(), 0, 0, 'avatar4.jpg'),
('Hoang Minh F', '1997-07-30', @pwd5, '0945678901', 'hoangminhf@example.com', 'Male', GETDATE(), 0, 0, 'avatar5.jpg'),
('Dang Thi G', '1993-09-18', @pwd6, '0956789012', 'dangthig@example.com', 'Female', GETDATE(), 0, 0, 'avatar6.jpg'),
('Vu Quoc H', '1985-12-25', @pwd7, '0967890123', 'vuquoch@example.com', 'Male', GETDATE(), 0, 0, 'avatar7.jpg'),
('Bui Kim I', '1999-06-14', @pwd8, '0978901234', 'buikimi@example.com', 'Female', GETDATE(), 0, 0, 'avatar8.jpg'),
('Nguyen Thanh J', '1994-04-22', @pwd9, '0989012345', 'nguyenthanhj@example.com', 'Male', GETDATE(), 0, 0, 'avatar9.jpg'),
('Doan Lan K', '1996-02-28', @pwd10, '0990123456', 'doanlank@example.com', 'Female', GETDATE(), 0, 0, 'avatar10.jpg'),
('Nguyen', '1994-04-22', @pwd11, '0989012345', 'nguyenthanhj@example.com', 'Male', GETDATE(), 0, 0, 'avatar9.jpg'),
('Doan Lan ', '1996-02-28', @pwd12, '0990123456', 'doanlank@example.com', 'Female', GETDATE(), 0, 0, 'avatar10.jpg'),
('Thanh J', '1994-04-22', @pwd13, '0989012345', 'nguyenthanhj@example.com', 'Male', GETDATE(), 0, 0, 'avatar9.jpg'),
('Lan K', '1996-02-28', @pwd14, '0990123456', 'doanlank@example.com', 'Female', GETDATE(), 0, 0, 'avatar10.jpg'),
('nh J', '1994-04-22', @pwd15, '0989012345', 'nguyenthanhj@example.com', 'Male', GETDATE(), 0, 0, 'avatar9.jpg'),
('D K', '1996-02-28', @pwd16, '0990123456', 'doanlank@example.com', 'Female', GETDATE(), 0, 0, 'avatar10.jpg');
