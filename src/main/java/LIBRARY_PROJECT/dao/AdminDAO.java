package LIBRARY_PROJECT.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import LIBRARY_PROJECT.dao.DBConnection;

public class AdminDAO {
    
    // Sign Up Method
    public boolean signUp(String username, String password, String email, String mobile) {
        try (Connection conn = DBConnection.getConnection()) {
            String query = "INSERT INTO admin (name, password, email, mobile) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password); // Password hashing can be added later
            ps.setString(3, email);
            ps.setString(4, mobile);
            int rows = ps.executeUpdate();
            return rows > 0; // Returns true if the insertion was successful
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Login Method
    public boolean login(String email, String password) {
        try (Connection conn = DBConnection.getConnection()) {
            String query = "SELECT * FROM admin WHERE email = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // Returns true if the user exists
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
