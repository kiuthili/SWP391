/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBContext;
import Models.Customer;
import Models.Order;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author NhutBMCE180569
 */
public class OrderDAO {

    DBContext db = new DBContext();
    Connection connector = db.getConnection();

    public List<Order> getOrderList() {
        List<Order> list = new ArrayList<>();
        String url = "select * from Orders where Orders.Status != 6 Order BY Orders.Status  ASC";
        try {

            PreparedStatement pre = connector.prepareStatement(url);
            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                Order o = new Order(rs.getInt("OrderID"),
                        rs.getInt("CustomerID"),
                        rs.getString("FullName"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Address"),
                        rs.getInt("TotalAmount"),
                        rs.getString("OrderedDate"),
                        rs.getInt("Status"));
                list.add(o);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public Order getOrderByID(String orderID) {
        Order o = new Order();
        String query = "select * from Orders where Orders.OrderID = ?";
        try {
            PreparedStatement pre = connector.prepareStatement(query);
            pre.setString(1, orderID);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                o.setOrderID(rs.getInt("OrderID"));
                o.setAccountID(rs.getInt("CustomerID"));
                o.setFullName(rs.getString("FullName"));
                o.setPhone(rs.getString("PhoneNumber"));
                o.setAddress(rs.getString("Address"));
                o.setTotalAmount(rs.getInt("TotalAmount"));
                o.setOrderDate(rs.getString("OrderedDate"));
                o.setStatus(rs.getInt("Status"));
                o.setDiscount(rs.getInt("Discount"));
            }
        } catch (Exception e) {
        }
        return o;
    }

    public int getNewestOrderID() {
        int id = 0;
        try {
            PreparedStatement pre = connector.prepareStatement("Select top 1* from Orders\n"
                    + "order by OrderID desc");
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                id = rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return id;
    }

//    public void createNewOrder(Order o) {
//        try {
//            String data = "";
//            data = "'" + o.getAccountID() + "',";
//            data += "'" + o.getFullName() + "',";
//            data += "'" + o.getPhone() + "',";
//            data += "N'" + o.getAddress() + "',";
//            data += o.getTotalAmount() + "";
//
//            PreparedStatement pre = connector.prepareStatement("Insert into [Orders] (CustomerID, FullName, PhoneNumber, [Address], TotalAmount, [Status], OrderedDate)"
//                    + " values (" + data + ", 1, GETDATE())");
//            pre.executeUpdate();
//        } catch (SQLException e) {
//            System.out.println(e);
//        }
//    }
    public void createOrder(Order o) {
        try {
            String data = "";
            data = "'" + o.getAccountID() + "',";
            data += "'" + o.getFullName() + "',";
            data += "'" + o.getPhone() + "',";
            data += "N'" + o.getAddress() + "',";
            data += o.getTotalAmount() + "";

            PreparedStatement pre = connector.prepareStatement("Insert into [Orders] (CustomerID, FullName, PhoneNumber, [Address], TotalAmount, [Status], OrderedDate, Discount)"
                    + " values (" + data + ", 1, DATEADD(HOUR, 7, GETUTCDATE()), ?)");
            pre.setInt(1, o.getDiscount());
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void addOrderDetail(int orderID, int productID, int quantity, long price) {
        try {
            PreparedStatement pre = connector.prepareStatement("Insert into [OrderDetails] values"
                    + "(?, ?, ?, ?)");
            pre.setInt(1, orderID);
            pre.setInt(2, productID);
            pre.setInt(3, quantity);
            pre.setLong(4, price);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void subtractQuantityAfterBuy(int productID, int quantity) {
        try {
            PreparedStatement pr = connector.prepareStatement("Update Products set Stock = Stock - ? where ProductID=?");
            pr.setInt(1, quantity);
            pr.setInt(2, productID);
            pr.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void plusQuantityAfterCancel(int productID, int quantity) {
        try {
            PreparedStatement pr = connector.prepareStatement("Update Products set Quantity = quantity + ? where ProductID=?");
            pr.setInt(1, quantity);
            pr.setInt(2, productID);
            pr.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void addQuantityAfterCancel(int productID, int quantity) {
        try {
            PreparedStatement pr = connector.prepareStatement("Update Products set Quantity = quantity + ? where ProductID=?");
            pr.setInt(1, quantity);
            pr.setInt(2, productID);
            pr.executeUpdate();
        } catch (Exception e) {
        }
    }

    public int updateOrder(int orderID, int status) {
        int count = 0;
        String query = "Update Orders SET Orders.Status= ? WHERE Orders.OrderID=?";
          String query2 = "UPDATE Orders\n"
                + "SET Status = ?,\n"
                + "    DeliveredDate = DATEADD(HOUR, 7, GETUTCDATE())\n"
                + "WHERE OrderID = ?;";
        try {
            if(status == 4){
             PreparedStatement pre = connector.prepareStatement(query2);
            pre.setInt(1, status);
            pre.setInt(2, orderID);
                    
             count = pre.executeUpdate();
            }else{
            PreparedStatement pre = connector.prepareStatement(query);
            pre.setInt(1, status);
            pre.setInt(2, orderID);
                    
             count = pre.executeUpdate();
                    }
        } catch (Exception e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return count;
    }

    public int deleteOrder(int month) {
        int count = 0;
        String query = "DECLARE @CurrentUTC DATETIME = GETUTCDATE();\n"
                + "DECLARE @ThresholdUTC DATETIME = DATEADD(MONTH, -?, @CurrentUTC);\n"
                + "\n"
                + "\n"
                + "DELETE FROM OrderDetails \n"
                + "WHERE OrderID IN (\n"
                + "    SELECT OrderID FROM Orders \n"
                + "    WHERE [Status] = '5' AND OrderedDate < @ThresholdUTC\n"
                + ");\n"
                + "\n"
                + "\n"
                + "DELETE FROM Orders \n"
                + "WHERE [Status] = '5' AND OrderedDate < @ThresholdUTC;";
        try {
            PreparedStatement pre = connector.prepareStatement(query);

            pre.setInt(1, month);
            count = pre.executeUpdate();

        } catch (Exception e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return count;
    }

    public List<Order> getAllOrderOfCustomer(int customerID) {
        List<Order> list = new ArrayList<>();
        try {
            PreparedStatement pre = connector.prepareStatement("SELECT * FROM Orders WHERE CustomerID = ?\n"
                    + "Order by OrderedDate DESC");
            pre.setInt(1, customerID);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Order(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getInt(8), rs.getInt(9)));
            }
        } catch (SQLException e) {
            System.out.println(e + "");
        }
        return list;
    }

    public int checkHaveOrders(int id) {
        String query = "SELECT * FROM Orders WHERE "
                + "CustomerID = ? AND Status != 4 AND Status != 5";
        try {
            PreparedStatement pre = connector.prepareStatement(query);
            pre.setInt(1, id);

            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return 1;
            }
        } catch (Exception e) {
            return 1;
        }
        return 0;
    }

    public List<Order> searchOrders(String searchQuery) {
        List<Order> list = new ArrayList<>();
        String query = "SELECT * FROM Orders WHERE "
                + "FullName LIKE ? OR "
                + "PhoneNumber LIKE ?  Order BY Status ASC";
        try {
            PreparedStatement pre = connector.prepareStatement(query);

            pre.setString(1, "%" + searchQuery + "%");
            pre.setString(2, "%" + searchQuery + "%");

            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Order o = new Order(
                        rs.getInt("OrderID"),
                        rs.getInt("CustomerID"),
                        rs.getString("FullName"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Address"),
                        rs.getInt("TotalAmount"),
                        rs.getString("OrderedDate"),
                        rs.getInt("Status")
                );
                list.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Customer getCustomerByOrderId(int id) {
        String sql = "SELECT c.CustomerID, c.FullName, c.PhoneNumber, c.Email, "
                + "c.IsBlock, c.IsDeleted FROM customers c "
                + "JOIN orders o ON c.CustomerID = o.CustomerID WHERE o.OrderID = ?";
        try ( PreparedStatement ps = connector.prepareStatement(sql)) {
            ps.setInt(1, id);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Customer(
                            rs.getInt("CustomerID"),
                            rs.getString("FullName"),
                            null,
                            null,
                            null,
                            rs.getString("PhoneNumber"),
                            rs.getString("Email"),
                            null,
                            rs.getInt("IsBlock"),
                            rs.getInt("IsDeleted"),
                            null
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }

        return null; // Không tìm thấy khách hàng
    }

    public List<Order> getOrdersToDelete(int month) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM Orders "
                + "WHERE [Status] = '5' "
                + "AND OrderedDate < DATEADD(MONTH, -?, GETUTCDATE())";
        try {
            PreparedStatement pre = connector.prepareStatement(sql);
            pre.setInt(1, month);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Order o = new Order(
                        rs.getInt("OrderID"),
                        rs.getInt("CustomerID"),
                        rs.getString("FullName"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Address"),
                        rs.getInt("TotalAmount"),
                        rs.getString("OrderedDate"),
                        rs.getInt("Status")
                );
                list.add(o);
            }
        } catch (SQLException e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return list;
    }

    public static void main(String[] args) {
        OrderDAO o = new OrderDAO();
//        o.addOrderDetail(1, 1, 3, 34000000);
//        List<Order> list = o.getAllOrderOfCustomer(1);
//        for (Order order : list) {
//            System.out.println(order.getAddress());
//        }
        Order od = new Order(13, "Bui Minh Nhut", "034931105", "fjds, fds fds, sdfhds, dshfdd", 20000000, 30000);
        
    }
}
