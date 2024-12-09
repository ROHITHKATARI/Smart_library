package LIBRARY_PROJECT.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/deleteStudentProfile")
public class DeleteStudentProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email"); // Retrieve email from request

        if (email != null && !email.isEmpty()) {
            try (Connection conn = LIBRARY_PROJECT.dao.DBConnection.getConnection()) {
                // Prepare SQL query to delete the student profile
                String query = "DELETE FROM student WHERE Email = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, email);

                // Execute the delete statement
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    // Success: invalidate session and redirect
                    request.getSession().invalidate();
                    response.sendRedirect("welcome.jsp?success=Student_Profile_deleted_successfully");
                } else {
                    // Failure: profile not found
                    response.sendRedirect("studentDashboard.jsp?error=Profile not found");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("studentDashboard.jsp?error=An error occurred while deleting profile");
            }
        } else {
            // Missing email parameter
            response.sendRedirect("studentDashboard.jsp?error=Invalid request");
        }
    }
}
