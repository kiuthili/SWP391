/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBContext;
import Models.Brand;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author kiuth
 */
public class BrandDAO {

    DBContext db = new DBContext();
    Connection connector = db.getConnection();

    public List<String> getAllBrandName() {
        List<String> list = new ArrayList<>();
        String query = "SELECT Name FROM Brands";
        try {
            PreparedStatement ps = connector.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("Name"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;

    }

    public int getBrandIdByName(String brandName) {
        int brandId = -1;
        String query = "SELECT BrandID FROM Brands WHERE Name = ?";
        try {
            PreparedStatement ps = connector.prepareStatement(query);
            ps.setString(1, brandName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                brandId = rs.getInt("BrandID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return brandId;
    }

    public List<Brand> getAllBrand() {
        List<Brand> list = new ArrayList<>();
        String query = "SELECT * FROM Brands";
        try {
            PreparedStatement ps = connector.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Brand(rs.getInt(1), rs.getString(2)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;

    }

    public int createBrand(Brand s) {

        String query = "INSERT INTO Brands (Name) VALUES (?)";
        try {
            PreparedStatement ps = connector.prepareStatement(query);
            ps.setString(2, s.getName());
            return ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }

        return 0;
    }
}
