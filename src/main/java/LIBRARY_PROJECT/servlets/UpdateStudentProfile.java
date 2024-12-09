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

@WebServlet("/updateProfileHandler")
public class UpdateStudentProfile extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        if (email == null) {
            response.sendRedirect("studentWelcome.jsp?error=Please log in first");
            return;
        }

        // Retrieve form parameters
        String name = request.getParameter("name");
        String mobile = request.getParameter("mobile");
        String password = request.getParameter("password");

        try {
            // Update the student record in the database
            Connection conn = LIBRARY_PROJECT.dao.DBConnection.getConnection();
            String query = "UPDATE student SET name = ?, mobile = ?, password = ? WHERE email = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, mobile);
            ps.setString(3, password);
            ps.setString(4, email);

            int rowsUpdated = ps.executeUpdate();
            conn.close();

            if (rowsUpdated > 0) {
                // Redirect on successful update
                response.sendRedirect("studentDashboard.jsp?success=Profile updated successfully");
            } else {
                // Handle case where no rows were updated
                response.sendRedirect("updateStudentProfile.jsp?error=Unable to update profile");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("updateStudentProfile.jsp?error=Error occurred while updating profile");
        }
    }
}
