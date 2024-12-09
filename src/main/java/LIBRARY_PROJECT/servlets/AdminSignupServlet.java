package LIBRARY_PROJECT.servlets;

import java.io.IOException;
//import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import LIBRARY_PROJECT.dao.DBConnection;

@WebServlet("/admin-signup")
public class AdminSignupServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Long mobile = Long.parseLong(request.getParameter("mobile"));
        

        try (Connection conn = DBConnection.getConnection()) {
            String query = "INSERT INTO admin (Name, Email, Password, Mobile) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, password);
            stmt.setLong(4, mobile);

            int rowsInserted = stmt.executeUpdate();
            response.setContentType("text/html");
//            PrintWriter out = response.getWriter();

            if (rowsInserted > 0) {
            	response.sendRedirect("adminWelcome.jsp");
            } else {
            	response.sendRedirect("adminWelcome.jsp?error=Signup_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminWelcome.jsp?error=Signup_failed_duplicate_entry_found");
        }
    }
}
