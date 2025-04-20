USE FShop;

-- Insert Roles
INSERT INTO Roles ([Name]) VALUES 
('Admin'),
('Shop Manager'),
('Order Manager'),
('Warehouse Manager');

-- Insert Categories
INSERT INTO Categories ([Name]) 
VALUES 
('Laptop'), ('Smartphone'), ('Mouse'), ('Headphone'), ('Charger'), ('Charging Cable');

-- Insert Brands
INSERT INTO Brands ([Name]) 
VALUES 
('Apple'), ('Samsung'), ('Sony'), ('Huawei'), ('Xiaomi'),
('Dell'), ('HP'), ('Asus'), ('Lenovo'), ('Acer'),
('MSI'), ('Microsoft'), ('Google'), ('LG'), ('Razer');

-- Insert Suppliers
SET IDENTITY_INSERT Suppliers ON;
INSERT INTO Suppliers (SupplierID, TaxID, [Name], Email, PhoneNumber, Address, CreatedDate, LastModify, IsDeleted, IsActivate) 
VALUES 
(1, '0100101234', 'TechGear Solutions', 'contact@techgear.com', '0901234567', '123 Tech Street, District 1, Ho Chi Minh City', GETDATE(), GETDATE(), 0, 1),
(2, '0200101235', 'GadgetWorld', 'info@gadgetworld.vn', '0912345678', '456 Innovation Blvd, District 3, Ho Chi Minh City', GETDATE(), GETDATE(), 0, 1),
(3, '0300101236', 'DigitalZone', 'support@digitalzone.vn', '0923456789', '789 Digital Avenue, District 5, Ho Chi Minh City', GETDATE(), GETDATE(), 0, 1),
(4, '0400101237', 'SmartTech Supplies', 'sales@smarttech.vn', '0934567890', '101 Future Drive, District 7, Ho Chi Minh City', GETDATE(), GETDATE(), 0, 0),
(5, '0500101238', 'NextGen Electronics', 'hello@nextgen.vn', '0945678901', '202 Silicon Valley, District 2, Ho Chi Minh City', GETDATE(), GETDATE(), 0, 0);
SET IDENTITY_INSERT Suppliers OFF;

-- Insert Attributes
-- Insert Attributes
INSERT INTO [Attributes] ([CategoryID], [Name]) VALUES

-- ======== Dùng chung cho Laptop & Điện thoại ========
(1, 'GPU'),                        
(1, 'CPU Speed'),                  
(1, 'Display Technology'),         
(1, 'Screen Resolution'),          
(1, 'Screen Size'),                
(1, 'Touchscreen Glass'),          
(1, 'Battery Capacity'),           
(1, 'Battery Technology'),         
(1, 'Charging Port'),              
(1, 'Bluetooth'),                  
(1, 'Design'),                     
(1, 'Material'),                   
(1, 'Size & Weight'),              

(2, 'GPU'),                        
(2, 'CPU Speed'),                  
(2, 'Display Technology'),         
(2, 'Screen Resolution'),          
(2, 'Screen Size'),                
(2, 'Touchscreen Glass'),          
(2, 'Battery Capacity'),           
(2, 'Battery Technology'),         
(2, 'Charging Port'),              
(2, 'Bluetooth'),                  
(2, 'Design'),                     
(2, 'Material'),                   
(2, 'Size & Weight'),              

-- ======== Laptop ========
(1, 'Keyboard Type'),              
(1, 'LED Backlight'),              
(1, 'Mouse & Keyboard Connection Type'), 

-- ======== Điện thoại ========
(2, 'Mobile Network'),             
(2, 'SIM'),                        
(2, 'Rear Camera Resolution'),     
(2, 'Front Camera Resolution'),    
(2, 'Max Charging Support'),       
(2, 'Advanced Security'),                             

-- ======== Tai nghe ========
(4, 'Headphone Type'),             
(4, 'Audio Technology'),           
(4, 'Connectivity'),               
(4, 'Battery Capacity'),           
(4, 'Usage Time'),                 
(4, 'Charging Time'),              

-- ======== Sạc & Cáp ========
(5, 'Charger Type'),               
(5, 'Charging Power (W)'),         
(5, 'Fast Charging Standard'),     

(6, 'Connector Type'),             
(6, 'Cable Length'),               
(6, 'Cable Material'),             

-- ======== Chuột ========
(3, 'Mouse Type'),                 
(3, 'RGB Lighting');              

-- Insert Products
SET IDENTITY_INSERT Products ON;

INSERT INTO Products (ProductID, BrandID, CategoryID, Model, FullName, [Description], [Image], Price, IsDeleted, Stock) VALUES 
(1, 1, 1, 'Macbook Pro 14', 'Apple Macbook Pro 14 inch M1 Pro chip', 'New model from Apple', '250-7038-macbook-pro-2021-apple-m1-1.jpg', 50000000, 0, 50),
(2, 2, 2, 'Galaxy S23 Ultra', 'Samsung Galaxy S23 Ultra 5G 256GB', 'Latest flagship from Samsung', 'samsung-galaxy-s23-xanh-600x600-1.jpg', 30000000, 1, 50),
(3, 3, 1, 'Sony Vaio Z900', 'Sony Vaio Z900 Core i7 16GB RAM', 'High-performance laptop', 'vaio-z900.jpg', 20000000, 0, 50),
(4, 8, 1, 'ASUS-FA706', 'ASUS TUF Gaming A17', 'Durable gaming laptop with high performance', '250-8562-line-laptop.png', 28909000, 1, 50),
(5, 1, 2, 'iPhone-16-Pro-Max', 'iPhone 16 Pro Max', 'Premium smartphone with advanced camera and powerful performance', 'iphone-16-pro-max-black-thumb-600x600.jpg', 32529000, 0, 30),
(6, 2, 2, 'Galaxy-S23', 'Samsung Galaxy S23', 'Samsung flagship phone with stunning design and excellent camera', 'samsung-galaxy-s23-xanh-600x600-1.jpg', 25899000, 1, 50),
(7, 9, 1, 'Legion-Pro-5', 'Lenovo Legion Pro 5', 'High-end gaming laptop with powerful specs and 240Hz display', '0yp3jx9d-1090-lenovo-legion-pro-5-y9000p-2023-core-i9-13900hx-16gb-1tb-rtx-4050-6gb-16-wqxga-240hz-new.jpg', 38909000, 0, 50),
(8, 8, 1, 'ASUS-TUF-A17', 'ASUS TUF Gaming A17', 'Durable gaming laptop with strong performance and modern design', 'ASUS-TUF-Gaming-A17-FA706-600x600.jpg', 31909000, 1, 50),
(9, 11, 1, 'MSI-Katana-A15', 'MSI Katana Gaming A15', 'Gaming laptop powered by AMD Ryzen 9 and RTX 4060 GPU', '5e0dkkrb-1411-msi-katana-gaming-a15-ai-b8vf-406ca-amd-ryzen-r9-8945hs-32gb-1tb-rtx-4060-8gb-15-6-144hz-fhd-new.jpg', 33909000, 1, 50),
(10, 6, 1, 'Dell-G5511', 'Dell Gaming G5511', 'Gaming laptop with strong design and high performance', '45606_dell_gaming_5511_dark_grey_ha3.jpg', 35909000, 0, 50),
(11, 4, 2, 'Xperia-1-III', 'Sony Xperia 1 III', 'Sony flagship phone with stunning OLED 4K display', 'sony-xperia-1-iii.png', 35999000, 0, 40),
(12, 5, 2, 'Pixel-6-Pro', 'Google Pixel 6 Pro', 'Google flagship phone with Google Tensor chip', '678582_684274_04_front_comping.jpg', 28999000, 0, 60),
(13, 6, 1, 'HP-Omen-15', 'HP Omen 15', 'Powerful gaming laptop with AMD Ryzen 9', 'hp-omen-15.jpg', 42900000, 0, 35),
(14, 3, 1, 'Acer-Predator-Helios-300', 'Acer Predator Helios 300', 'Gaming laptop with Intel i7 and RTX 3070', 'acer-predator-helios-300.jpg', 37999000, 1, 20),
(15, 4, 2, 'Xiaomi-Redmi-Note-11', 'Xiaomi Redmi Note 11', 'Affordable smartphone with great performance', 'Xiaomi-Redmi-11.jpg', 7990000, 0, 100),
(16, 2, 2, 'Samsung-Galaxy-A53', 'Samsung Galaxy A53', 'Mid-range smartphone with 5G and powerful camera', 'samsung-galaxy-a53.png', 18999000, 0, 75),
(17, 10, 1, 'Razer-Blade-15', 'Razer Blade 15', 'Premium gaming laptop with high performance', 'razer-blade-15.jpg', 47900000, 0, 25),
(18, 9, 1, 'Alienware-X17', 'Alienware X17', 'High-end gaming laptop with Intel i9 and RTX 3080', 'alienware-x17.jpg', 59999000, 0, 10),
(19, 11, 1, 'MSI-GS66', 'MSI GS66 Stealth', 'Slim gaming laptop with Intel i7 and RTX 3070', 'msi-gs66.jpg', 44999000, 1, 50),
(20, 8, 1, 'Asus-Zephyrus-G14', 'Asus Zephyrus G14', 'Powerful gaming laptop with AMD Ryzen 9 and RTX 3060', 'asus-zephyrus-g14.jpg', 35999000, 0, 30);

-- Insert Products for Headphone, Charger, and Charging Cable
-- Headphones
INSERT INTO Products (ProductID, BrandID, CategoryID, Model, FullName, [Description], [Image], Price, IsDeleted, Stock) VALUES 
(21, 3, 4, 'Sony-WH-1000XM5', 'Sony WH-1000XM5', 'Premium noise-canceling wireless headphones', 'sony-wh-1000xm5.jpg', 8490000, 0, 30),
(22, 5, 4, 'Xiaomi-FlipBuds-Pro', 'Xiaomi FlipBuds Pro', 'True wireless earbuds with ANC', 'xiaomi-flipbuds-pro.jpg', 2990000, 0, 50),
(23, 14, 4, 'LG-Tone-Free-FP9', 'LG Tone Free FP9', 'Wireless earbuds with UV cleaning case', 'lg-tone-free-fp9.jpg', 3290000, 0, 40),
(24, 4, 4, 'Huawei-FreeBuds-Pro-2', 'Huawei FreeBuds Pro 2', 'High-quality sound with dynamic drivers', 'huawei-freebuds-pro-2.jpg', 3990000, 0, 35),
(25, 10, 4, 'Acer-Predator-Galea-350', 'Acer Predator Galea 350', 'Gaming headset with surround sound', 'acer-predator-galea-350.jpg', 2590000, 0, 20);

-- Chargers
INSERT INTO Products (ProductID, BrandID, CategoryID, Model, FullName, [Description], [Image], [Image1], [Image2], Price, IsDeleted, Stock) VALUES 
(26, 1, 5, 'Apple-20W-USB-C', 'Apple 20W USB-C Charger', 'Fast charging for iPhone and iPad', 'apple-20w-usb-c.jpg', 'adapter-20w-apple-5_1.png', 'adapter-20w-apple-5_1_1.png', 590000, 0, 100),
(27, 2, 5, 'Samsung-25W-USB-C', 'Samsung 25W USB-C Charger', 'Super Fast Charging adapter', 'samsung-25w-usb-c.jpg', 'cu-sac-nhanh-samsung-25w-ep-t2510nbegww-2.png', 'cu-sac-nhanh-samsung-25w-ep-t2510nbegww-4.png', 690000, 0, 80),
(28, 5, 5, 'Xiaomi-67W-SuperCharge', 'Xiaomi 67W Super Charge', 'High-speed charging adapter', 'xiaomi-67w.jpg','cu-sac-xiaomi-usb-a-gan-67w-kem-cap-type-c_3_.png', 'cu-sac-xiaomi-usb-a-gan-67w-kem-cap-type-c_4_.png', 890000, 0, 70),
(29, 4, 5, 'Huawei-40W-SuperCharge', 'Huawei 40W Super Charge', 'Fast charging technology', 'huawei-40w.jpg','','', 790000, 0, 60),
(30, 9, 5, 'Lenovo-65W-Charger', 'Lenovo 65W Laptop Charger', 'Fast charging for Lenovo laptops', 'lenovo-65w.jpg', '4X20M26268-560x450-02.61f5a0696c22551d.png','6hz00evh8lohwi8iag5nh0yoq8jh4t069238.png',1290000, 0, 50);

-- Charging Cables
INSERT INTO Products (ProductID, BrandID, CategoryID, Model, FullName, [Description], [Image],  Price, IsDeleted, Stock) VALUES 
(31, 1, 6, 'Apple-USB-C-Lightning', 'Apple USB-C to Lightning Cable', 'Official Apple charging cable', 'apple-usb-c-lightning.jpg', 490000, 0, 200),
(32, 2, 6, 'Samsung-USB-C-Cable', 'Samsung USB-C Cable 1m', 'Durable and fast-charging', 'samsung-usb-c.jpg', 290000, 0, 180),
(33, 5, 6, 'Xiaomi-Braided-USB-C', 'Xiaomi Braided USB-C Cable', 'Reinforced and tangle-free', 'xiaomi-braided-usb-c.jpg', 390000, 0, 160),
(34, 4, 6, 'Huawei-SuperCharge-Cable', 'Huawei SuperCharge USB-C Cable', 'Supports high-speed charging', 'huawei-supercharge.jpg', 450000, 0, 140),
(35, 9, 6, 'Lenovo-Thunderbolt-4', 'Lenovo Thunderbolt 4 Cable', 'High-speed data and charging', 'lenovo-thunderbolt-4.jpg', 990000, 0, 120);

SET IDENTITY_INSERT Products OFF;

-- Insert AttributeDetails for Headphone
INSERT INTO AttributeDetails (AttributeID, ProductID, AttributeInfor)
VALUES
(23, 11, 'Over-ear'), (24, 11, 'Active Noise Cancelling'), (25, 11, 'Bluetooth 5.2'), (26, 11, '30 hours'), (27, 11, '3 hours'),
(23, 12, 'In-ear'), (24, 12, 'Hybrid ANC'), (25, 12, 'Bluetooth 5.2'), (26, 12, '7 hours (earbuds), 28 hours (case)'), (27, 12, '1.5 hours'),
(23, 13, 'In-ear'), (24, 13, 'Adaptive ANC'), (25, 13, 'Bluetooth 5.2'), (26, 13, '10 hours (earbuds), 24 hours (case)'), (27, 13, '2 hours'),
(23, 14, 'In-ear'), (24, 14, 'Active Noise Cancelling'), (25, 14, 'Bluetooth 5.3'), (26, 14, '6 hours (earbuds), 30 hours (case)'), (27, 14, '1 hour'),
(23, 15, 'Over-ear'), (24, 15, '7.1 Surround Sound'), (25, 15, 'Wired, USB & 3.5mm'), (26, 15, 'N/A'), (27, 15, 'N/A');

-- Insert AttributeDetails for Chargers
INSERT INTO AttributeDetails (AttributeID, ProductID, AttributeInfor)
VALUES
(28, 16, 'USB-C'), (29, 16, '20W'), (30, 16, 'PD Fast Charging'),
(28, 17, 'USB-C'), (29, 17, '25W'), (30, 17, 'Super Fast Charging'),
(28, 18, 'USB-C'), (29, 18, '67W'), (30, 18, 'Quick Charge 4+'),
(28, 19, 'USB-C'), (29, 19, '40W'), (30, 19, 'SuperCharge'),
(28, 20, 'USB-C, DC'), (29, 20, '65W'), (30, 20, 'Laptop Fast Charging');

-- Insert AttributeDetails for Charging Cables
INSERT INTO AttributeDetails (AttributeID, ProductID, AttributeInfor)
VALUES
(31, 21, 'USB-C to Lightning'), (32, 21, '1m'), (33, 21, 'Braided Nylon'),
(31, 22, 'USB-C to USB-C'), (32, 22, '1m'), (33, 22, 'Rubber'),
(31, 23, 'USB-C to USB-C'), (32, 23, '1.5m'), (33, 23, 'Braided Nylon'),
(31, 24, 'USB-C to USB-C'), (32, 24, '1m'), (33, 24, 'Fast-Charge Certified'),
(31, 25, 'Thunderbolt 4'), (32, 25, '1.2m'), (33, 25, 'High-Speed Data Transfer');

SET IDENTITY_INSERT Products OFF;

-- Insert AttributeDetails
INSERT INTO AttributeDetails (AttributeID, ProductID, AttributeInfor)
VALUES
-- MacBook Pro 14
(1, 1, 'Apple M1 Pro GPU'),
(2, 1, '3.2 GHz'),
(3, 1, 'Liquid Retina XDR'),
(4, 1, '3024 x 1964'),
(5, 1, '14 inch'),
(6, 1, 'No'),
(7, 1, '70Wh'),
(8, 1, 'Li-Po'),
(9, 1, 'USB-C (Thunderbolt 4)'),
(10, 1, '5.0'),
(11, 1, 'Slim, thin bezels'),
(12, 1, 'CNC Aluminum'),
(13, 1, '31.26 x 22.12 x 1.55 cm, 1.6 kg'),
(14, 1, 'Magic Keyboard'),
(15, 1, 'Yes'),
(16, 1, 'Bluetooth'),
-- Sony Vaio Z900
(1, 3, 'Intel Iris Xe'),
(2, 3, '3.1 GHz'),
(3, 3, 'IPS'),
(4, 3, '1920 x 1080'),
(5, 3, '14 inch'),
(6, 3, 'No'),
(7, 3, '53Wh'),
(8, 3, 'Li-ion'),
(9, 3, 'USB-C'),
(10, 3, '5.1'),
(11, 3, 'Ultra-thin, premium'),
(12, 3, 'Carbon fiber'),
(13, 3, '32.0 x 21.5 x 1.6 cm, 1.2 kg'),
(14, 3, 'Chiclet'),
(15, 3, 'Yes'),
(16, 3, 'Bluetooth'),
-- ASUS TUF Gaming A17
(1, 4, 'RTX 3050 4GB'),
(2, 4, '4.2 GHz'),
(3, 4, 'IPS'),
(4, 4, '1920 x 1080'),
(5, 4, '17.3 inch'),
(6, 4, 'No'),
(7, 4, '90Wh'),
(8, 4, 'Li-ion'),
(9, 4, 'USB-C, DC-in'),
(10, 4, '5.2'),
(11, 4, 'Powerful gaming'),
(12, 4, 'Hard plastic & metal'),
(13, 4, '39.9 x 26.8 x 2.5 cm, 2.6 kg'),
(14, 4, 'RGB Backlit'),
(15, 4, 'Yes'),
(16, 4, 'USB, Bluetooth'),
-- Lenovo Legion Pro 5
(1, 7, 'RTX 4050 6GB'),
(2, 7, '4.5 GHz'),
(3, 7, 'IPS'),
(4, 7, '2560 x 1600'),
(5, 7, '16 inch'),
(6, 7, 'No'),
(7, 7, '80Wh'),
(8, 7, 'Li-ion'),
(9, 7, 'USB-C, DC-in'),
(10, 7, '5.2'),
(11, 7, 'Powerful gaming'),
(12, 7, 'Aluminum & hard plastic'),
(13, 7, '35.9 x 26.5 x 2.6 cm, 2.5 kg'),
(14, 7, 'RGB Backlit'),
(15, 7, 'Yes'),
(16, 7, 'USB, Bluetooth'),
-- Samsung Galaxy S23 Ultra
(1, 2, 'Adreno 740'),
(2, 2, '3.36 GHz'),
(3, 2, 'Dynamic AMOLED 2X'),
(4, 2, '3088 x 1440'),
(5, 2, '6.8 inch'),
(6, 2, 'Gorilla Glass Victus 2'),
(7, 2, '5000mAh'),
(8, 2, 'Li-ion'),
(9, 2, 'USB-C'),
(10, 2, '5.3'),
(11, 2, 'Glass back, aluminum frame'),
(12, 2, 'Armor aluminum + tempered glass'),
(13, 2, '163.4 x 78.1 x 8.9 mm, 234g'),
(17, 2, '5G'),
(18, 2, 'Dual SIM (Nano-SIM + eSIM)'),
(19, 2, '200MP + 12MP + 10MP + 10MP'),
(20, 2, '12MP'),
(21, 2, '45W'),
(22, 2, 'Ultrasonic fingerprint'),
-- Galaxy S23
(1, 6, 'Adreno 740'),
(2, 6, '3.36 GHz'),
(3, 6, 'Dynamic AMOLED 2X'),
(4, 6, '2340 x 1080'),
(5, 6, '6.1 inch'),
(7, 6, '3900mAh'),
(8, 6, 'Li-ion'),
(9, 6, 'USB-C'),
(10, 6, '5.3'),
(19, 6, '50MP + 10MP + 12MP'),
-- ASUS TUF A17
(1, 8, 'RTX 4060 8GB'),
(2, 8, '4.2 GHz'),
(3, 8, 'IPS'),
(4, 8, '1920 x 1080'),
(5, 8, '17.3 inch'),
(7, 8, '90Wh'),
(8, 8, 'Li-ion'),
-- MSI Katana A15
(1, 9, 'RTX 4060 8GB'),
(2, 9, '4.5 GHz'),
(3, 9, 'IPS'),
(4, 9, '1920 x 1080'),
(5, 9, '15.6 inch'),
(7, 9, '90Wh'),
(8, 9, 'Li-ion'),
-- Dell G5511
(1, 10, 'RTX 3060 6GB'),
(2, 10, '4.6 GHz'),
(3, 10, 'IPS'),
(4, 10, '1920 x 1080'),
(5, 10, '15.6 inch'),
(7, 10, '86Wh'),
(8, 10, 'Li-ion');

-- Insert Customers
INSERT INTO Customers (FullName, Birthday, [Password], PhoneNumber, Email, Gender, CreatedDate, GoogleID, IsBlock, IsDeleted, Avatar)
VALUES 
('Nguyen Van A', '1995-05-15', '6ad14ba9986e3615423dfca256d04e3f', '0901234567', 'nguyenvana@example.com', 'Male', GETDATE(), '', 0, 0, 'avatar1.jpg'),
('Tran Thi B', '1989-08-20', '8d86fe393e67df6f56ffbdfc8d8754a1', '0909876543', 'tranthib@example.com', 'Female', GETDATE(), '', 0, 0, 'avatar2.jpg'),
('Le Minh C', '1992-03-25', 'fda82e8f01317cc1ca3b5ed334f317b2', '0912345678', 'leminhc@example.com', 'Male', GETDATE(), '', 0, 0, 'avatar3.jpg'),
('Pham Thi D', '1994-12-30', 'cc63426e11b8c85a2836f6312e021b47', '0923456789', 'phamthid@example.com', 'Female', GETDATE(), '', 0, 0, 'avatar4.jpg'),
('Hoang Minh E', '1987-07-10', '1f9d8655e8be12467d0b1fa3c290df6e', '0934567890', 'hoangminhe@example.com', 'Male', GETDATE(), '', 0, 0, 'avatar5.jpg'),
('Nguyen Thi F', '1990-11-01', '3d229f3e67dbebcf5d6c1b55e3a5b0db', '0945678901', 'nguyenthif@example.com', 'Female', GETDATE(), '', 0, 0, 'avatar6.jpg'),
('Pham Minh G', '1993-06-12', 'a9c3d0d4073b38cd302fa0547fdab3a0', '0956789012', 'phamminhg@example.com', 'Male', GETDATE(), '', 0, 0, 'avatar7.jpg'),
('Hoang Thi H', '1988-09-05', '1c43f7b5f88d4cd85e3e26ed9a0491a1', '0967890123', 'hoangthih@example.com', 'Female', GETDATE(), '', 0, 0, 'avatar8.jpg'),
('Le Thi I', '1991-01-17', '6e4d8f7f604a8f8fda8a527f28d5bb96', '0978901234', 'lethii@example.com', 'Female', GETDATE(), '', 0, 0, 'avatar9.jpg'),
('Nguyen Minh J', '1992-02-28', 'b63f2f35d2fe823cc7b21cfb97f7f160', '0989012345', 'nguyenminhj@example.com', 'Male', GETDATE(), '', 0, 0, 'avatar10.jpg'),
('Pham Thi K', '1995-04-18', '4a23d64a37a50d712e2d90b59802100b', '0990123456', 'phamthik@example.com', 'Female', GETDATE(), '', 0, 0, 'avatar11.jpg'),
('Le Minh L', '1990-10-22', 'e0a0c093ce5d47a3cc99213a2e4c39b8', '0902345678', 'leminhl@example.com', 'Male', GETDATE(), '', 0, 0, 'avatar12.jpg');


-- Insert OrderStatus
INSERT INTO OrderStatus (ID, [Status])
VALUES 
(1, 'Waiting for acceptance'),
(2, 'Packaging'),
(3, 'Waiting for delivery'),
(4, 'Delivered'),
(5, 'Canceled');

-- Insert Orders
INSERT INTO Orders (CustomerID, FullName, [Address], PhoneNumber, OrderedDate, DeliveredDate, Status, TotalAmount)
VALUES 
(1, 'Nguyen Van A', '123 Tech Street, District 1, Ho Chi Minh City', '0901234567', '2024-01-01', NULL, 4, 50000000),
(2, 'Tran Thi B', '456 Nguyen Du Street, District 3, Ho Chi Minh City', '0909876543', '2024-02-15', NULL, 4, 75000000),
(3, 'Le Minh C', '789 Le Lai Street, District 5, Ho Chi Minh City', '0912345678', '2024-03-20', NULL, 4, 25000000),
(4, 'Pham Thi D', '321 Pham Ngoc Thach, District 1, Ho Chi Minh City', '0923456789', '2024-04-05', NULL, 3, 12000000),
(5, 'Hoang Minh E', '654 Ha Noi Street, Hai Ba Trung, Hanoi', '0934567890', '2024-05-10', NULL, 4, 30000000),
(6, 'Nguyen Thi F', '112 Mai Thi Luu, District 3, Ho Chi Minh City', '0945678901', '2024-06-15', NULL, 4, 40000000),
(7, 'Pham Minh G', '234 Ly Tu Trong, District 1, Ho Chi Minh City', '0956789012', '2024-07-01', NULL, 2, 60000000),
(8, 'Hoang Thi H', '567 Le Duan, District 5, Ho Chi Minh City', '0967890123', '2024-08-12', NULL, 4, 15000000),
(9, 'Le Thi I', '678 Bach Dang, District 7, Ho Chi Minh City', '0978901234', '2024-09-08', NULL, 4, 55000000),
(10, 'Nguyen Minh J', '890 Pham Hung, District 8, Ho Chi Minh City', '0989012345', '2024-10-22', NULL, 4, 20000000),
(11, 'Pham Thi K', '123 Bui Thi Xuan, District 1, Ho Chi Minh City', '0990123456', '2024-11-18', NULL, 4, 45000000),
(12, 'Le Minh Hoo', '456 Huynh Tan Phat, District 7, Ho Chi Minh City', '0902345678', '2024-12-05', NULL, 4, 35000000),
(12, 'Le Minh Hoo', '456 Huynh Tan Phat, District 7, Ho Chi Minh City', '0902345678', '2024-12-05', NULL, 4, 35000000),
(12, 'Le Minh Hoo', '456 Huynh Tan Phat, District 7, Ho Chi Minh City', '0902345678', '2024-12-05', NULL, 4, 35000000),
(12, 'Le Minh Hoo', '456 Huynh Tan Phat, District 7, Ho Chi Minh City', '0902345678', '2024-12-05', NULL, 4, 35000000);


INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES 
(1, 1, 3, 50000000),
(2, 2, 5, 75000000),
(3, 3, 2, 25000000),
(4, 4, 1, 12000000),
(5, 5, 2, 30000000),
(6, 6, 4, 40000000),
(7, 7, 6, 60000000),
(8, 8, 1, 15000000),
(9, 9, 3, 55000000),
(10, 10, 2, 20000000),
(11, 11, 5, 45000000),
(12, 12, 2, 35000000),
(13, 12, 2, 35000000),
(14, 12, 2, 35000000),
(15, 12, 2, 35000000);


-- Insert Employees
SET IDENTITY_INSERT Employees ON;

INSERT INTO Employees (EmployeeID, FullName, Birthday, [Password], PhoneNumber, Email, Gender, [Status], CreatedDate, Avatar, RoleID) VALUES
(1, 'Nguyen Van A', '1990-01-01', '36fdba5968850579c0a89444f4ca4772', '0123456789', 'nguyenvana@example.com', 'Male', 1, GETDATE(), '', 1), -- Password là: User123@
(2, 'Nguyen Van B', '1990-01-01', '36fdba5968850579c0a89444f4ca4772', '0123456788', 'nguyenvanb@example.com', 'Male', 1, GETDATE(), '', 2), -- Password là: User123@
(3, 'Nguyen Van C', '1990-01-01', '36fdba5968850579c0a89444f4ca4772', '0123456789', 'nguyenvanc@example.com', 'Male', 1, GETDATE(), '', 3), -- Password là: User123@
(4, 'Bui Trung Kien', '1990-01-01', '36fdba5968850579c0a89444f4ca4772', '0123456789', 'nguyenvand@example.com', 'Male', 1, GETDATE(), '', 4); -- Password là: User123@

SET IDENTITY_INSERT Employees OFF;

-- Insert Carts
INSERT INTO Carts (CustomerID, ProductID, Quantity)
VALUES 
(1, 1, 1),
(1, 2, 5);


-- Insert Addresses
INSERT INTO Addresses (CustomerID, AddressDetails, IsDefault)
VALUES 
(1, 'Ap Tra Coi A, My Huong, My Tu, Soc Trang', 1);

-- Insert Imports
INSERT INTO ImportStocks (EmployeeID, SupplierID, ImportDate, TotalCost, Completed)
VALUES
(2, 1, GETDATE(), 2019500000, 1),
(2, 2, GETDATE(), 51052500000, 1);

-- Insert ImportDetails
INSERT INTO ImportStockDetails (ImportID, ProductID, ImportQuantity, ImportPrice)
VALUES
(1, 1, 50, 40390000),
(2, 2, 50, 20120000),
(2, 3, 50, 15050000);

INSERT INTO Vouchers (VoucherCode, VoucherValue, VoucherType, StartDate, EndDate, UsedCount, MaxUsedCount, MaxDiscountAmount, MinOrderValue, Status, [Description])
VALUES 
('NEWUSER', 50000, 0, '2025-03-01', '2025-12-31', 0, NULL, NULL, 100000, 1, N'50,000 VND discount for new customers on orders from 100,000 VND'),
('DISCOUNT10', 10, 1, '2025-03-01', '2025-03-31', 0, 100, 50000, 200000, 1, N'10% discount up to 50,000 VND for orders from 200,000 VND'),
('VIP50', 50000, 0, '2025-03-10', '2025-04-10', 0, 50, NULL, 500000, 1, N'50,000 VND discount for orders from 500,000 VND'),
('FLASHSALE', 20, 1, '2025-03-15', '2025-03-20', 0, 200, 70000, 300000, 1, N'20% discount up to 70,000 VND for orders from 300,000 VND');


-- Assign vouchers to Customer with ID = 1
INSERT INTO CustomerVoucher (CustomerID, VoucherID, ExpirationDate, Quantity)
VALUES 
(1, 1, '2026-01-10', 5),
(1, 2,'2026-01-10', 5),	
(1, 3, '2026-01-10', 5);

--Insert Product Rating
INSERT INTO ProductRatings (CustomerID, ProductID, OrderID, CreatedDate, Star, Comment, IsDeleted, IsRead)
VALUES
(1, 1, 1, GETDATE(), 5, N'Excellent performance and build quality!', 0, 1),
(2, 2, 2, GETDATE(), 4, N'Great phone but gets warm during gaming.', 0, 1),
(3, 3, 3, GETDATE(), 3, N'Decent battery life, could be better.', 0, 1),
(5, 5, 5, GETDATE(), 5, N'Highly satisfied with the product quality.', 0, 1),
(6, 6, 6, GETDATE(), 2, N'The item had some scratches upon arrival.', 0, 1),
(8, 8, 8, GETDATE(), 4, N'Sleek design and solid gaming performance.', 0, 1),
(9, 9, 9, GETDATE(), 5, N'Smooth experience and fast delivery.', 0, 1),
(10, 10, 10, GETDATE(), 3, N'Average performance for the price.', 0, 1);

--Insert RatingReplies
INSERT INTO RatingReplies (EmployeeID, RateID, Answer, IsRead)
VALUES
(3, 1, N'Thank you for your feedback! We appreciate your support.', 0),
(3, 2, N'Sorry for the heating issue. We will look into it.', 0),
(3, 3, N'Thank you! We’ll work on improving battery life.', 0),
(3, 4, N'Glad to hear you’re happy with the product!', 1),
(3, 5, N'Sorry for the inconvenience. We’ll review our packaging process.', 0),
(3, 6, N'Thanks for your review. Enjoy your new device!', 1),
(3, 7, N'We appreciate your trust and hope to serve you again.', 0),
(3, 8, N'Thank you! We’re happy it met your expectations.', 1);

-- Thêm đơn hàng 1 tháng trước
INSERT INTO Orders (CustomerID, FullName, [Address], PhoneNumber, OrderedDate, DeliveredDate, Status, TotalAmount)
VALUES 
(1, 'Nguyen Van A', '123 Tech Street, District 1, Ho Chi Minh City', '0901234567', DATEADD(MONTH, -1, GETUTCDATE()), NULL, 5, 50000000);

-- Chi tiết đơn hàng 1 tháng trước
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES 
(16, 1, 2, 50000000),  -- 2 Macbook Pro 14
(16, 2, 3, 75000000);  -- 3 Galaxy S23 Ultra

-- Thêm đơn hàng 3 tháng trước
INSERT INTO Orders (CustomerID, FullName, [Address], PhoneNumber, OrderedDate, DeliveredDate, Status, TotalAmount)
VALUES 
(2, 'Tran Thi B', '456 Nguyen Du Street, District 3, Ho Chi Minh City', '0909876543', DATEADD(MONTH, -3, GETUTCDATE()), NULL, 5, 75000000);

-- Chi tiết đơn hàng 3 tháng trước
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES 
(17, 3, 2, 20000000),  -- 2 Sony Vaio Z900
(17, 4, 1, 12000000);  -- 1 ASUS TUF Gaming A17

-- Thêm đơn hàng 6 tháng trước
INSERT INTO Orders (CustomerID, FullName, [Address], PhoneNumber, OrderedDate, DeliveredDate, Status, TotalAmount)
VALUES 
(3, 'Le Minh C', '789 Le Lai Street, District 5, Ho Chi Minh City', '0912345678', DATEADD(MONTH, -6, GETUTCDATE()), NULL, 5, 25000000);

-- Chi tiết đơn hàng 6 tháng trước
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES 
(18, 5, 2, 30000000),  -- 2 iPhone-16-Pro-Max
(18, 6, 4, 40000000);  -- 4 Galaxy-S23

-- Thêm đơn hàng 12 tháng trước
INSERT INTO Orders (CustomerID, FullName, [Address], PhoneNumber, OrderedDate, DeliveredDate, Status, TotalAmount)
VALUES 
(4, 'Pham Thi D', '321 Pham Ngoc Thach, District 1, Ho Chi Minh City', '0923456789', DATEADD(MONTH, -12, GETUTCDATE()), NULL, 5, 12000000);

-- Chi tiết đơn hàng 12 tháng trước
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES 
(19, 7, 3, 60000000),  -- 3 Lenovo Legion Pro 5
(19, 8, 1, 15000000);  -- 1 ASUS-TUF-A17
UPDATE Products
SET Image1 = 'MacBookProM4_02.jfif',
    Image2 = 'MacBookProM4_03.jfif'
WHERE ProductID = 1;

UPDATE Products
SET Image1 = 'SonyZ900_01.jfif',
    Image2 = 'SonyZ900_02.jfif'
WHERE ProductID = 3;


UPDATE Products
SET Image1 = 'Legion5_01.jfif',
    Image2 = 'Legion5_02.jfif'
WHERE ProductID = 7;

UPDATE Products
SET Image1 = 'DellG15_01.jpg',
    Image2 = 'DellG15_02.jfif'
WHERE ProductID = 10;


UPDATE Products
SET Image1 = 'HpOmen_01.jfif',
    Image2 = 'HpOmen_02.jfif'
WHERE ProductID = 13;


UPDATE Products
SET Image = 'Alienware.jfif', 
    Image1 = 'Alienware_01.jfif',
    Image2 = 'Alienware_02.jfif'
WHERE ProductID = 18;


UPDATE Products
SET Image = 'AsusG14.jfif', 
    Image1 = 'AsusG14_01.jfif',
    Image2 = 'AsusG14_02.jfif'
WHERE ProductID = 20;
