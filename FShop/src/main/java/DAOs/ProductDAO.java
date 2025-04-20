/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBContext;
import Models.AttributeDetail;
import Models.Category;
import Models.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author KienBTCE180180
 */
public class ProductDAO {

    DBContext db = new DBContext();
    Connection connector = db.getConnection();

    public ArrayList<Product> getAllProducts() {
        ArrayList<Product> list = new ArrayList<>();

        String query = "SELECT * FROM Products WHERE IsDeleted = 0 AND Stock > 0";

        try {
            PreparedStatement ps = connector.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("ProductID"),
                        rs.getInt("BrandID"),
                        rs.getInt("CategoryID"),
                        rs.getString("Model"),
                        rs.getString("FullName"),
                        rs.getString("Description"),
                        rs.getInt("IsDeleted"),
                        rs.getLong("Price"),
                        rs.getString("Image"),
                        rs.getInt("Quantity"),
                        rs.getInt("Stock")
                ));
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }

        return list;
    }
    
    public ArrayList<Product> getAllAvailabilityProducts() {
        ArrayList<Product> list = new ArrayList<>();

        String query = "SELECT * FROM Products";

        try {
            PreparedStatement ps = connector.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("ProductID"),
                        rs.getInt("BrandID"),
                        rs.getInt("CategoryID"),
                        rs.getString("Model"),
                        rs.getString("FullName"),
                        rs.getString("Description"),
                        rs.getInt("IsDeleted"),
                        rs.getLong("Price"),
                        rs.getString("Image"),
                        rs.getInt("Quantity"),
                        rs.getInt("Stock")
                ));
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }

        return list;
    }

    public ArrayList<Product> getAllProductsByCategory(String category) {
        ArrayList<Product> list = new ArrayList<>();

        String query = "SELECT *, B.Name AS BrandName FROM Products P JOIN Categories C ON P.CategoryID = C.CategoryID JOIN Brands B ON B.BrandID = P.BrandID WHERE C.CategoryID = ? AND P.IsDeleted = 0 AND P.Stock > 0";

        try {
            PreparedStatement ps = connector.prepareStatement(query);
            ps.setString(1, category);
            System.out.println(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("ProductID"),
                        rs.getInt("BrandID"),
                        rs.getInt("CategoryID"),
                        rs.getString("Model"),
                        rs.getString("FullName"),
                        rs.getString("Description"),
                        rs.getInt("IsDeleted"),
                        rs.getLong("Price"),
                        rs.getString("Image"),
                        rs.getInt("Quantity"),
                        rs.getInt("Stock")
                );
                p.setBrandName(rs.getString("BrandName"));
                list.add(p);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }

        return list;
    }

    public boolean isModelExists(String model) {
        String sql = "SELECT COUNT(*) FROM Products WHERE Model = ?";
        try {
            PreparedStatement pr = connector.prepareStatement(sql);
            pr.setString(1, model);
            ResultSet rs = pr.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean isFullnameExists(String fullName) {
        String sql = "SELECT COUNT(*) FROM Products WHERE FullName = ?";
        try {
            PreparedStatement pr = connector.prepareStatement(sql);
            pr.setString(1, fullName);
            ResultSet rs = pr.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public ArrayList<Product> findProductsByFilter(ArrayList<String> filters, String category) {
        ArrayList<Product> list = null;

        String query = "SELECT * FROM Products P JOIN Brands B ON P.BrandID = B.BrandID WHERE B.Name IN (SELECT Name FROM Brands WHERE ";

        for (String filter : filters) {
            query += filter;
        }

        query += ") AND P.CategoryID IN (SELECT CategoryID FROM Categories WHERE [Name] = ?) AND P.IsDeleted = 0";

//        System.out.println("QUERY " + query);
        try {
            PreparedStatement ps = connector.prepareStatement(query);
            ps.setString(1, category);
            ResultSet rs = ps.executeQuery();
            list = new ArrayList<>();
            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("ProductID"),
                        rs.getInt("BrandID"),
                        rs.getInt("CategoryID"),
                        rs.getString("Model"),
                        rs.getString("FullName"),
                        rs.getString("Description"),
                        rs.getInt("IsDeleted"),
                        rs.getLong("Price"),
                        rs.getString("Image"),
                        rs.getInt("Quantity"),
                        rs.getInt("Stock")
                ));
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }

        return list;
    }

    public ArrayList<Product> filterProductsByPrice(ArrayList<String> filters) {
        ArrayList<Product> list = null;

        String query = "SELECT * FROM Products P JOIN Brands B ON P.BrandID = B.BrandID WHERE B.Name IN (SELECT Name FROM Brands WHERE ";

        for (String filter : filters) {
            query += filter;
        }

        query += ") AND P.IsDeleted = 0";

//        System.out.println("QUERY " + query);
        try {
            PreparedStatement ps = connector.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            list = new ArrayList<>();
            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("ProductID"),
                        rs.getInt("BrandID"),
                        rs.getInt("CategoryID"),
                        rs.getString("Model"),
                        rs.getString("FullName"),
                        rs.getString("Description"),
                        rs.getInt("IsDeleted"),
                        rs.getLong("Price"),
                        rs.getString("Image"),
                        rs.getInt("Quantity"),
                        rs.getInt("Stock")
                ));
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }

        return list;
    }

    public ArrayList<String> getAllBrandByCategory(String category) {
        ArrayList<String> list = null;

        String query = "SELECT DISTINCT B.[Name] FROM Brands B JOIN Products P ON B.BrandID = P.BrandID WHERE P.CategoryID IN (SELECT CategoryID FROM Categories WHERE [Name] = ?)  AND P.IsDeleted = 0";

        try {
            PreparedStatement ps = connector.prepareStatement(query);
            ps.setString(1, category);
            ResultSet rs = ps.executeQuery();
            list = new ArrayList<>();
            while (rs.next()) {
                list.add(rs.getString("Name"));
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }

        return list;
    }

    //Lay danh sach san pham - shop manager
    public ArrayList<Product> getProductList() {
        ArrayList<Product> list = new ArrayList<>();
        String query = "SELECT sp.ProductID, c.Name AS CategoryName, b.Name AS BrandName, "
                + "sp.FullName, sp.Price, sp.Stock, sp.isDeleted "
                + "FROM Products sp "
                + "JOIN Categories c ON sp.CategoryID = c.CategoryID "
                + "JOIN Brands b ON sp.BrandID = b.BrandID ORDER BY IsDeleted DESC";

        try ( PreparedStatement ps = connector.prepareStatement(query);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("ProductID"),
                        rs.getString("CategoryName"),
                        rs.getString("BrandName"),
                        rs.getString("FullName"),
                        rs.getLong("Price"),
                        rs.getInt("Stock"),
                        rs.getInt("isDeleted") // Tránh lỗi nếu DB lưu isDeleted dưới dạng INT
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    //Thong tin chi tiet cua san pham - shop manager
    public Product getProductByID(int productId) {
        Product s = null;

        String query = "SELECT sp.ProductID, c.Name AS CategoryName, b.Name AS BrandName, "
                + "sp.FullName, sp.Price, sp.Image, sp.Image1, sp.Image2, sp.Image3, sp.Stock, sp.isDeleted, sp.Description, sp.Model "
                + "FROM Products sp "
                + "JOIN Categories c ON sp.CategoryID = c.CategoryID "
                + "JOIN Brands b ON sp.BrandID = b.BrandID "
                + "WHERE sp.ProductID = ?";

        try {
            PreparedStatement ps = connector.prepareStatement(query);
            ps.setInt(1, productId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                s = new Product(
                        rs.getInt("ProductID"),
                        rs.getString("CategoryName"),
                        rs.getString("BrandName"),
                        rs.getString("Model"),
                        rs.getString("FullName"),
                        rs.getString("Description"),
                        rs.getInt("isDeleted"),
                        rs.getLong("Price"),
                        rs.getString("Image"),
                        rs.getString("Image1"),
                        rs.getString("Image2"),
                        rs.getString("Image3"),
                        rs.getInt("Stock")
                );
                // Sử dụng đối tượng s đã có
                AttributeDAO attributeDAO = new AttributeDAO();
                List<AttributeDetail> attributes = attributeDAO.getAttributesByProductID(s.getProductId());
                s.setAttributeDetails(attributes);
            }
            return s;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return s;
    }

    //delete product - shop manager
    public int deleteProduct(int productId) {
        int count = 0;
        try {
            String sql = "UPDATE Products SET isDeleted = 1 WHERE ProductID = ?";
            PreparedStatement pst = connector.prepareStatement(sql);
            pst.setInt(1, productId);
            count = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    //restore product - shop manager
    public int restoreProduct(int productId) {
        int count = 0;
        try {
            String sql = "UPDATE Products SET isDeleted = 0 WHERE ProductID = ?";
            PreparedStatement pst = connector.prepareStatement(sql);
            pst.setInt(1, productId);
            count = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public int createProduct(Product product) {
        int productId = 0;  // Khởi tạo productId với giá trị mặc định là 0 (nếu không lấy được ID)
        String sql = "INSERT INTO Products (BrandID, CategoryID, Model, FullName, Description, IsDeleted, Price, Image, Image1, Image2, Image3) "
                + "VALUES ((SELECT BrandID FROM Brands WHERE Name = ?), "
                + "(SELECT CategoryID FROM Categories WHERE Name = ?), ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try ( PreparedStatement ps = connector.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {  // Sử dụng Statement.RETURN_GENERATED_KEYS để lấy khóa tự động
            // Thiết lập các tham số cho câu lệnh SQL
            ps.setString(1, product.getBrandName());
            ps.setString(2, product.getCategoryName());
            ps.setString(3, product.getModel());
            ps.setString(4, product.getFullName());
            ps.setString(5, product.getDescription());
            ps.setInt(6, product.getDeleted());
            ps.setLong(7, product.getPrice());
            ps.setString(8, product.getImage());
            ps.setString(9, product.getImage1());
            ps.setString(10, product.getImage2());
            ps.setString(11, product.getImage3());

            // Thực thi câu lệnh INSERT
            int rowsAffected = ps.executeUpdate();  // Trả về số dòng bị ảnh hưởng
            if (rowsAffected > 0) {
                // Nếu có sản phẩm được thêm vào, lấy khóa tự động sinh ra (ProductID)
                try ( ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        productId = rs.getInt(1);  // Lấy ProductID (khóa tự động sinh ra)
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();  // In ra lỗi nếu có
        }

        return productId;  // Trả về ProductID (nếu thành công) hoặc 0 nếu không có ID
    }

    public int addAttributeDetail(AttributeDetail attributeDetail) {
        int result = 0;
        String sql = "INSERT INTO AttributeDetails (AttributeID, ProductID, AttributeInfor) VALUES (?, ?, ?)";

        try {
            PreparedStatement ps = connector.prepareStatement(sql);

            ps.setInt(1, attributeDetail.getAttributeId());
            ps.setInt(2, attributeDetail.getProductId());
            ps.setString(3, attributeDetail.getAttributeInfor());
            result = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public int updateProduct(Product p) {
        // Câu lệnh cập nhật sản phẩm
        String query = "UPDATE Products SET Model=?, FullName=?, Description=?, Price=?, Image=?, Image1=?, Image2=?, Image3=?, IsDeleted=?, "
                + "BrandID = (SELECT BrandID FROM Brands WHERE Name = ?), "
                + "CategoryID = (SELECT CategoryID FROM Categories WHERE Name = ?) "
                + "WHERE ProductID=?";
        try {
            // Bắt đầu transaction
            connector.setAutoCommit(false);
            int result;

            // Update thông tin sản phẩm
            try ( PreparedStatement ps = connector.prepareStatement(query)) {
                ps.setString(1, p.getModel());
                ps.setString(2, p.getFullName());
                ps.setString(3, p.getDescription());
                ps.setLong(4, p.getPrice());
                ps.setString(5, p.getImage());
                ps.setString(6, p.getImage1());
                ps.setString(7, p.getImage2());
                ps.setString(8, p.getImage3());
                ps.setInt(9, p.getDeleted());
                ps.setString(10, p.getBrandName());
                ps.setString(11, p.getCategoryName());
                ps.setInt(12, p.getProductId());

                result = ps.executeUpdate();
            }

            // Nếu sản phẩm có attribute details, cập nhật chúng
            if (p.getAttributeDetails() != null && !p.getAttributeDetails().isEmpty()) {
                String query2 = "UPDATE AttributeDetails SET AttributeInfor = ? WHERE ProductID = ? AND AttributeID = ?";
                try ( PreparedStatement ps2 = connector.prepareStatement(query2)) {
                    // Duyệt qua danh sách attribute details và add batch
                    for (AttributeDetail attr : p.getAttributeDetails()) {
                        ps2.setString(1, attr.getAttributeInfor());
                        ps2.setInt(2, p.getProductId());
                        ps2.setInt(3, attr.getAttributeId());
                        ps2.addBatch();
                    }
                    ps2.executeBatch();
                }
            }

            // Commit transaction nếu mọi thứ đều ổn
            connector.commit();
            return result;
        } catch (SQLException ex) {
            // Rollback nếu có lỗi
            try {
                connector.rollback();
            } catch (SQLException e) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
            }
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            // Đặt lại AutoCommit về true
            try {
                connector.setAutoCommit(true);
            } catch (SQLException e) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return 0;
    }

    public List<Product> searchProductByName(String keyword) {
        List<Product> list = new ArrayList<>();
        String query = "SELECT sp.ProductID, c.Name AS CategoryName, b.Name AS BrandName, "
                + "sp.FullName, sp.Price, sp.Image, sp.Stock, sp.isDeleted, sp.Description, sp.Model "
                + "FROM Products sp "
                + "JOIN Categories c ON sp.CategoryID = c.CategoryID "
                + "JOIN Brands b ON sp.BrandID = b.BrandID "
                + "WHERE sp.FullName LIKE ? AND sp.IsDeleted != 1 AND sp.Stock > 0 ORDER BY Price DESC";

        try ( PreparedStatement ps = connector.prepareStatement(query)) {
            ps.setString(1, "%" + keyword + "%");

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product(
                            rs.getInt("ProductID"),
                            rs.getString("CategoryName"),
                            rs.getString("BrandName"),
                            rs.getString("FullName"),
                            rs.getLong("Price"),
                            rs.getInt("Stock"),
                            rs.getInt("isDeleted")
                    );
                    p.setStock(rs.getInt("Stock"));
                    p.setImage(rs.getString("Image"));
                    list.add(p);
                }

            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Product> sortProduct(String keyword, String sort) {
        List<Product> list = new ArrayList<>();
        String orderBy = "ASC";
        if ("DESC".equalsIgnoreCase(sort)) {
            orderBy = "DESC";
        }
        String query = "SELECT sp.ProductID, c.Name AS CategoryName, b.Name AS BrandName, "
                + "sp.FullName, sp.Price, sp.Image, sp.Stock, sp.isDeleted, sp.Description, sp.Model "
                + "FROM Products sp "
                + "JOIN Categories c ON sp.CategoryID = c.CategoryID "
                + "JOIN Brands b ON sp.BrandID = b.BrandID "
                + "WHERE sp.FullName LIKE ? AND sp.IsDeleted != 1 AND sp.Stock > 0 ORDER BY Price " + orderBy;

        try ( PreparedStatement ps = connector.prepareStatement(query)) {
            ps.setString(1, "%" + keyword + "%");

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product(
                            rs.getInt("ProductID"),
                            rs.getString("CategoryName"),
                            rs.getString("BrandName"),
                            rs.getString("FullName"),
                            rs.getLong("Price"),
                            rs.getInt("Stock"),
                            rs.getInt("isDeleted")
                    );
                    p.setStock(rs.getInt("Stock"));
                    p.setImage(rs.getString("Image"));
                    list.add(p);
                }

            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Map<String, Object>> getSalesData(String period) throws SQLException {
        String query = "SELECT FORMAT(OrderedDate, 'yyyy-MM-dd') AS date, SUM(Quantity) AS total "
                + "FROM Orders JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID "
                + "WHERE OrderedDate >= DATEADD(" + period + ", -1, GETDATE()) "
                + "GROUP BY FORMAT(OrderedDate, 'yyyy-MM-dd') ORDER BY date";
        return executeQuery(query);
    }

    public List<Map<String, Object>> getTopSellingProducts() throws SQLException {
        String query = "SELECT TOP 10 Products.FullName, SUM(OrderDetails.Quantity) AS totalSold "
                + "FROM OrderDetails JOIN Products ON OrderDetails.ProductID = Products.ProductID "
                + "GROUP BY Products.FullName ORDER BY totalSold DESC";
        return executeQuery(query);
    }

    public List<Map<String, Object>> getLowStockProducts() throws SQLException {
        String query = "SELECT FullName, Stock FROM Products WHERE Stock < 10 ORDER BY Stock ASC";
        return executeQuery(query);
    }

    public List<Map<String, Object>> getCategorySales() throws SQLException {
        String query = "SELECT Categories.Name, SUM(OrderDetails.Quantity) AS totalSold "
                + "FROM OrderDetails JOIN Products ON OrderDetails.ProductID = Products.ProductID "
                + "JOIN Categories ON Products.CategoryID = Categories.CategoryID "
                + "GROUP BY Categories.Name ORDER BY totalSold DESC";
        return executeQuery(query);
    }

    private List<Map<String, Object>> executeQuery(String query) throws SQLException {
        List<Map<String, Object>> data = new ArrayList<>();
        try (
                 Statement stmt = connector.createStatement();  ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Map<String, Object> record = new HashMap<>();
                ResultSetMetaData metaData = rs.getMetaData();
                for (int i = 1; i <= metaData.getColumnCount(); i++) {
                    record.put(metaData.getColumnName(i), rs.getObject(i));
                }
                data.add(record);
            }
        }
        return data;
    }

    public Map<String, Object> getDashboardStats() throws SQLException {
        Map<String, Object> stats = new HashMap<>();
        String query = "SELECT "
                + "    (SELECT COUNT(*) FROM Customers) AS totalCustomers, "
                + "    (SELECT COUNT(*) FROM Products) AS totalProducts, "
                + "    (SELECT SUM(Stock) FROM Products) AS totalInventory, "
                + "    (SELECT COUNT(*) FROM Orders) AS totalOrders";

        try ( Statement stmt = connector.createStatement();  ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                stats.put("totalCustomers", rs.getInt("totalCustomers"));
                stats.put("totalProducts", rs.getInt("totalProducts"));
                stats.put("totalInventory", rs.getInt("totalInventory"));
                stats.put("totalOrders", rs.getInt("totalOrders"));
            }
        }
        return stats;
    }

    public List<Map<String, Object>> getWeeklySales(String category) throws SQLException {
        List<Map<String, Object>> sales = new ArrayList<>();
        String query
                = "SELECT p.FullName, SUM(od.Quantity) AS totalSold "
                + "FROM OrderDetails od "
                + "JOIN Products p ON od.ProductID = p.ProductID "
                + "JOIN Categories c ON p.CategoryID = c.CategoryID "
                + "WHERE c.Name = ? AND od.OrderID IN ( "
                + "    SELECT OrderID FROM Orders WHERE OrderedDate >= DATEADD(DAY, -7, GETDATE()) "
                + ") "
                + "GROUP BY p.FullName ORDER BY totalSold DESC";

        try ( PreparedStatement stmt = connector.prepareStatement(query)) {
            stmt.setString(1, category);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Map<String, Object> data = new HashMap<>();
                data.put("productName", rs.getString("FullName"));
                data.put("totalSold", rs.getInt("totalSold"));
                sales.add(data);
            }
        }
        return sales;
    }

    public List<Map<String, Object>> getNewCustomers() throws SQLException {
        List<Map<String, Object>> customers = new ArrayList<>();
        String query
                = "SELECT TOP 2 FullName, Email FROM Customers ORDER BY CreatedDate DESC";

        try ( Statement stmt = connector.createStatement();  ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Map<String, Object> customer = new HashMap<>();
                customer.put("name", rs.getString("FullName"));
                customer.put("email", rs.getString("Email"));
                customers.add(customer);
            }
        }
        return customers;
    }

    public List<Map<String, Object>> getNewProducts() throws SQLException {
        List<Map<String, Object>> products = new ArrayList<>();
        String query
                = "SELECT TOP 10 p.ProductID, p.FullName, c.Name AS Category, p.Price, io.ImportDate "
                + "FROM Products p "
                + "JOIN ImportStockDetails iod ON p.ProductID = iod.ProductID "
                + "JOIN ImportStocks io ON iod.ImportID = io.ImportID "
                + "JOIN Categories c ON p.CategoryID = c.CategoryID "
                + "ORDER BY io.ImportDate DESC";

        try ( PreparedStatement ps = connector.prepareStatement(query);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> product = new HashMap<>();
                product.put("id", rs.getInt("ProductID"));
                product.put("name", rs.getString("FullName"));
                product.put("category", rs.getString("Category"));
                product.put("price", rs.getLong("Price"));
                product.put("added_date", rs.getTimestamp("ImportDate"));
                products.add(product);
            }
        }
        return products;
    }

    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String query = "SELECT * FROM Categories";
        try ( PreparedStatement ps = connector.prepareStatement(query);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                categories.add(new Category(rs.getInt("CategoryID"), rs.getString("Name")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    public List<Product> getProductsByCategory(int categoryID) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT p.ProductID, p.FullName, p.Price, p.Stock, p.isDeleted, "
                + "c.Name AS CategoryName, b.Name AS BrandName "
                + "FROM Products p "
                + "JOIN Categories c ON p.CategoryID = c.CategoryID "
                + "JOIN Brands b ON p.BrandID = b.BrandID "
                + "WHERE p.CategoryID = ?";

        try ( PreparedStatement ps = connector.prepareStatement(query)) {
            ps.setInt(1, categoryID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("ProductID"),
                        rs.getString("CategoryName"),
                        rs.getString("BrandName"),
                        rs.getString("FullName"),
                        rs.getLong("Price"),
                        rs.getInt("Stock"),
                        rs.getInt("isDeleted")
                );
                products.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> getNewImportedProducts() {
        List<Product> products = new ArrayList<>();
        String query = "SELECT p.ProductID, p.FullName, p.Price, p.Stock, p.isDeleted, "
                + "c.Name AS CategoryName, b.Name AS BrandName "
                + "FROM Products p "
                + "JOIN Categories c ON p.CategoryID = c.CategoryID "
                + "JOIN Brands b ON p.BrandID = b.BrandID "
                + "WHERE p.ProductID IN (SELECT DISTINCT ProductID FROM ImportStockDetails "
                + "JOIN ImportStocks ON ImportStockDetails.ImportID = ImportStocks.ImportID "
                + "WHERE ImportStocks.ImportDate >= DATEADD(DAY, -7, GETDATE()))";

        try ( PreparedStatement ps = connector.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("ProductID"),
                        rs.getString("CategoryName"),
                        rs.getString("BrandName"),
                        rs.getString("FullName"),
                        rs.getLong("Price"),
                        rs.getInt("Stock"),
                        rs.getInt("isDeleted")
                );
                products.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public boolean checkDuplicateProduct(String fullName, String model, int productId) {
        boolean exists = false;
        String sql = "SELECT COUNT(*) FROM Products WHERE (fullName = ? OR model = ?) AND productId <> ?";
        try ( PreparedStatement ps = connector.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, model);
            ps.setInt(3, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                exists = count > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return exists;
    }

    public List<Product> getProductsSortedByStatus(String sortBy) {
        List<Product> products = new ArrayList<>();
        // Kiểm tra nếu sortBy là một giá trị hợp lệ
        if (!sortBy.equals("IsDeleted") && !sortBy.equals("Price") && !sortBy.equals("FullName")) {
            sortBy = "IsDeleted";  // Mặc định nếu giá trị không hợp lệ
        }

        String query = "SELECT sp.ProductID, c.Name AS CategoryName, b.Name AS BrandName, "
                + "sp.FullName, sp.Price, sp.Stock, sp.isDeleted "
                + "FROM Products sp "
                + "JOIN Categories c ON sp.CategoryID = c.CategoryID "
                + "JOIN Brands b ON sp.BrandID = b.BrandID "
                + "ORDER BY " + sortBy;

        try ( PreparedStatement ps = connector.prepareStatement(query);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                products.add(new Product(
                        rs.getInt("ProductID"),
                        rs.getString("CategoryName"),
                        rs.getString("BrandName"),
                        rs.getString("FullName"),
                        rs.getLong("Price"),
                        rs.getInt("Stock"),
                        rs.getInt("isDeleted")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

}
