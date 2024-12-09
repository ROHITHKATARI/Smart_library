package LIBRARY_PROJECT.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import LIBRARY_PROJECT.dao.DBConnection;

@WebServlet("/UpdateProfile")
public class UpdateAdminProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        if (email == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String name = request.getParameter("name");
        long mobile = Long.parseLong(request.getParameter("mobile")); // Parsing mobile as long
        String password = request.getParameter("password");

        try {
            Connection conn = DBConnection.getConnection();
            String query = "UPDATE admin SET name = ?, mobile = ?, password = ? WHERE email = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setLong(2, mobile); // Setting mobile as long
            ps.setString(3, password);
            ps.setString(4, email);

            int result = ps.executeUpdate();
            conn.close();

            if (result > 0) {
                session.setAttribute("Name", name);
                response.sendRedirect("adminDashboard.jsp?message=Profile updated successfully");
            } else {
                response.sendRedirect("updateProfile.jsp?error=Failed to update profile");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("updateProfile.jsp?error=An error occurred");
        }
    }

}
