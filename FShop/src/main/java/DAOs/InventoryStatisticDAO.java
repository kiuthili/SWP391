/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBContext;
import Models.InventoryStatistic;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author NguyenPVT-CE181835
 */
public class InventoryStatisticDAO {

    DBContext db = new DBContext();
    Connection connector = db.getConnection();
    
    
    public ArrayList<InventoryStatistic> getInventoryforSmartPhone() {
        ArrayList<InventoryStatistic> list = new ArrayList<>();
        String sql = "SELECT p.Model AS Model, p.Stock AS StockQuantity\n"
                + "FROM Products p\n"
                + "WHERE p.CategoryID = 2 ;";
        try {
            PreparedStatement pr = connector.prepareStatement(sql);
            ResultSet rs = pr.executeQuery();
            while (rs.next()) {
                list.add(new InventoryStatistic(rs.getString(1), rs.getInt(2)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public ArrayList<InventoryStatistic> getInventoryforLaptop() {
        ArrayList<InventoryStatistic> list = new ArrayList<>();
        String sql = "SELECT p.Model AS Model, p.Stock AS StockQuantity\n"
                + "FROM Products p\n"
                + "WHERE p.CategoryID = 1 ;";
        try {
            PreparedStatement pr = connector.prepareStatement(sql);
            ResultSet rs = pr.executeQuery();
            while (rs.next()) {
                list.add(new InventoryStatistic(rs.getString(1), rs.getInt(2)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }


    public ArrayList<InventoryStatistic> getAllInventory() {
        ArrayList<InventoryStatistic> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    c.Name AS CategoryName,\n"
                + "    b.Name AS BrandName,\n"
                + "    p.Model,\n"
                + "    p.FullName AS ProductName,\n"
                + "    p.Stock AS StockQuantity,  \n"
                + "    s.Name AS SupplierName,\n"
                + "    i.ImportDate AS LastImportDate,\n"
                + "    iod.ImportPrice AS ProductImportPrice \n"
                + "FROM \n"
                + "    Products p\n"
                + "JOIN \n"
                + "    Categories c ON p.CategoryID = c.CategoryID\n"
                + "JOIN \n"
                + "    Brands b ON p.BrandID = b.BrandID\n"
                + "LEFT JOIN \n"
                + "    ImportStockDetails iod ON p.ProductID = iod.ProductID\n"
                + "LEFT JOIN \n"
                + "    ImportStocks i ON iod.ImportID = i.ImportID\n"
                + "LEFT JOIN \n"
                + "    Suppliers s ON i.SupplierID = s.SupplierID\n"
                + "ORDER BY \n"
                + "    c.CategoryID;";
        try {
            PreparedStatement pr = connector.prepareStatement(sql);
            ResultSet rs = pr.executeQuery();
            while (rs.next()) {
                list.add(new InventoryStatistic(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), rs.getString(6), rs.getDate(7), rs.getLong(8)));
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public ArrayList<InventoryStatistic> searchInventory(String keyword) {
        ArrayList<InventoryStatistic> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "     c.Name AS CategoryName,\n"
                + " b.Name AS BrandName,\n"
                + "    p.Model,\n"
                + "    p.FullName AS ProductName,\n"
                + "    p.Stock AS StockQuantity,  \n"
                + "    s.Name AS SupplierName,\n"
                + "    i.ImportDate AS LastImportDate,\n"
                + "    iod.ImportPrice AS ProductImportPrice \n"
                + "FROM \n"
                + "    Products p\n"
                + "JOIN \n"
                + "    Categories c ON p.CategoryID = c.CategoryID\n"
                + "JOIN \n"
                + "    Brands b ON p.BrandID = b.BrandID\n"
                + "LEFT JOIN \n"
                + "    ImportStockDetails iod ON p.ProductID = iod.ProductID\n"
                + "LEFT JOIN \n"
                + "     ImportStocks i ON iod.ImportID = i.ImportID\n"
                + "LEFT JOIN \n"
                + "    Suppliers s ON i.SupplierID = s.SupplierID\n"
                + "WHERE \n"
                + "     (p.FullName LIKE ? OR c.Name LIKE ? OR b.Name LIKE ? OR s.Name LIKE ?)\n"
                + "ORDER BY \n"
                + "     c.CategoryID;";

        try {
            PreparedStatement pr = connector.prepareStatement(sql);
            String searchKeyword = "%" + keyword + "%"; // Thêm dấu % để tìm kiếm theo chuỗi con
            pr.setString(1, searchKeyword);
            pr.setString(2, searchKeyword);
            pr.setString(3, searchKeyword);
            pr.setString(4, searchKeyword);

            ResultSet rs = pr.executeQuery();
            while (rs.next()) {
                list.add(new InventoryStatistic(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), rs.getString(6), rs.getDate(7), rs.getLong(8)));
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public static void main(String[] args) {
        InventoryStatisticDAO i = new InventoryStatisticDAO();
        ArrayList<InventoryStatistic> l = i.getAllInventory();
        for (InventoryStatistic f : l) {
            System.out.println(f.getCategoryName());
        }
    }
}
