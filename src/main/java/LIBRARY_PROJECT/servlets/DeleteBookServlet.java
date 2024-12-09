package LIBRARY_PROJECT.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;

@WebServlet("/deleteBook")
public class DeleteBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("book_id")); // Retrieve the book ID from the request

        try (Connection conn = LIBRARY_PROJECT.dao.DBConnection.getConnection()) {
            String deleteSQL = "DELETE FROM books WHERE book_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(deleteSQL);
            pstmt.setInt(1, bookId);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                // Redirect with a success message
                response.sendRedirect("adminDashboard.jsp?message=Book+deleted+successfully");
            } else {
                // Redirect with an error message
                response.sendRedirect("adminDashboard.jsp?error=Failed+to+delete+the+book");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Redirect with an error message in case of exception
            response.sendRedirect("adminDashboard.jsp?error=An+unexpected+error+occurred");
        }
    }
}
