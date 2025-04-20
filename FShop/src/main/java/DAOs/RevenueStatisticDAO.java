/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBContext;
import Models.RevenueStatistic;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author NguyenPVT-CE181835
 */
public class RevenueStatisticDAO {

    DBContext db = new DBContext();
    Connection connector = db.getConnection();

    public ArrayList<RevenueStatistic> getRevenuePhone() {
        ArrayList<RevenueStatistic> list = new ArrayList<>();
        String sql = "  SELECT \n"
                + "               MONTH(o.OrderedDate) AS Month,\n"
                + "              SUM(od.Quantity * od.Price) AS Revenue\n"
                + "                FROM\n"
                + "               Products p\n"
                + "               JOIN \n"
                + "               OrderDetails od ON p.ProductID = od.ProductID\n"
                + "                JOIN \n"
                + "                Orders o ON od.OrderID = o.OrderID\n"
                + "                WHERE \n"
                + "                p.CategoryID = 2 AND o.Status = 4\n"
                + "               GROUP BY\n"
                + "                p.Model,  MONTH(o.OrderedDate)\n"
                + "                ORDER BY \n"
                + "               Month Asc";
        try {
            PreparedStatement pr = connector.prepareStatement(sql);
            ResultSet rs = pr.executeQuery();
            while (rs.next()) {
                list.add(new RevenueStatistic(rs.getInt(1), rs.getLong(2)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public ArrayList<RevenueStatistic> getRevenueLaptop() {
        ArrayList<RevenueStatistic> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    MONTH(o.OrderedDate) AS Month,\n"
                + "    SUM(od.Quantity * od.Price) AS Revenue\n"
                + "FROM \n"
                + "    Products p\n"
                + "JOIN \n"
                + "    OrderDetails od ON p.ProductID = od.ProductID\n"
                + "JOIN \n"
                + "    Orders o ON od.OrderID = o.OrderID\n"
                + "WHERE \n"
                + "    p.CategoryID = 1 AND o.Status = 4\n"
                + "GROUP BY \n"
                + "    p.Model,  MONTH(o.OrderedDate)\n"
                + "ORDER BY \n"
                + "    Month Asc";
        try {
            PreparedStatement pr = connector.prepareStatement(sql);
            ResultSet rs = pr.executeQuery();
            while (rs.next()) {
                list.add(new RevenueStatistic(rs.getInt(1), rs.getLong(2)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public ArrayList<RevenueStatistic> getRevenueByDay() {
        ArrayList<RevenueStatistic> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "   CONVERT(DATE, o.OrderedDate) AS OrderDate,\n"
                + "   COUNT(DISTINCT o.OrderID) AS TotalOrders,\n"
                + "   SUM(od.Quantity * od.Price) AS TotalRevenue,\n"
                + "   SUM(od.Quantity) AS TotalProductsSold\n"
                + "   FROM \n"
                + "   Orders o\n"
                + "   JOIN\n"
                + "   OrderDetails od ON o.OrderID = od.OrderID\n"
                + "   WHERE \n"
                + "   o.Status = 4\n"
                + "   GROUP BY \n"
                + "   CONVERT(DATE, o.OrderedDate)";
        try {
            PreparedStatement pr = connector.prepareStatement(sql);
            ResultSet rs = pr.executeQuery();
            while (rs.next()) {
                list.add(new RevenueStatistic(rs.getDate(1), rs.getInt(2), rs.getLong(3), rs.getInt(4)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public ArrayList<RevenueStatistic> getRevenueByMonth() {
        ArrayList<RevenueStatistic> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    YEAR(o.OrderedDate) AS OrderYear,\n"
                + "    MONTH(o.OrderedDate) AS OrderMonth,\n"
                + "    COUNT(DISTINCT o.OrderID) AS TotalOrders,\n"
                + "    SUM(od.Quantity * od.Price) AS TotalRevenue,\n"
                + "    SUM(od.Quantity) AS TotalProductsSold\n"
                + "FROM \n"
                + "    Orders o\n"
                + "JOIN \n"
                + "    OrderDetails od ON o.OrderID = od.OrderID\n"
                + "   WHERE \n"
                + "   o.Status = 4\n"
                + "GROUP BY \n"
                + "    YEAR(o.OrderedDate), MONTH(o.OrderedDate)";
        try {
            PreparedStatement pr = connector.prepareStatement(sql);
            ResultSet rs = pr.executeQuery();
            while (rs.next()) {
                list.add(new RevenueStatistic(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getLong(4), rs.getInt(5)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public ArrayList<RevenueStatistic> getRevenueByYear() {
        ArrayList<RevenueStatistic> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    YEAR(o.OrderedDate) AS OrderYear,\n"
                + "    COUNT(DISTINCT o.OrderID) AS TotalOrders,\n"
                + "    SUM(od.Quantity * od.Price) AS TotalRevenue,\n"
                + "    SUM(od.Quantity) AS TotalProductsSold\n"
                + "FROM \n"
                + "    Orders o\n"
                + "JOIN \n"
                + "    OrderDetails od ON o.OrderID = od.OrderID\n"
                + "   WHERE \n"
                + "   o.Status = 4\n"
                + "GROUP BY \n"
                + "    YEAR(o.OrderedDate)";
        try {
            PreparedStatement pr = connector.prepareStatement(sql);
            ResultSet rs = pr.executeQuery();
            while (rs.next()) {
                list.add(new RevenueStatistic(rs.getInt(1), rs.getInt(2), rs.getLong(3), rs.getInt(4)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public static void main(String[] args) {
        RevenueStatisticDAO r = new RevenueStatisticDAO();
        ArrayList<RevenueStatistic> l = r.getRevenueLaptop();
        for (RevenueStatistic re : l) {
            System.out.println(re.getRevenue());
        }
    }
}
