package LIBRARY_PROJECT.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import LIBRARY_PROJECT.dao.DBConnection;

@WebServlet("/deleteProfile")
public class DeleteProfileServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Retrieve the email parameter from the request
        String email = request.getParameter("email");

        if (email != null) {
            try (Connection conn = DBConnection.getConnection()) {
                // Prepare SQL query to delete the user profile from the database
                String query = "DELETE FROM admin WHERE email = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, email);

                // Execute the delete statement
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    // Profile deleted successfully, invalidate session and redirect to welcome page
                    request.getSession().invalidate(); // Invalidates the session
                    response.sendRedirect("adminWelcome.jsp"); // Redirect to welcome page
                } else {
                    // If no rows were deleted, redirect with an error message
                    response.sendRedirect("adminDashboard.jsp?error=Profile not found");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("adminDashboard.jsp?error=Unable to delete profile");
            }
        } else {
            response.sendRedirect("adminDashboard.jsp?error=Email missing");
        }
    }
}
