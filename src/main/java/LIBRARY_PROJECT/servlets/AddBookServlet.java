package LIBRARY_PROJECT.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddBook")
public class AddBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Retrieve form data
        int bookId = Integer.parseInt(request.getParameter("book_id"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        int numOfCopies = Integer.parseInt(request.getParameter("num_of_copies"));
        int publishedYear = Integer.parseInt(request.getParameter("published_year"));

        try {
            // Establish database connection
            Connection conn = LIBRARY_PROJECT.dao.DBConnection.getConnection();

            // Check if the book ID already exists
            String checkQuery = "SELECT book_id FROM books WHERE book_id = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setInt(1, bookId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Book ID already exists
                response.getWriter().println("<h3>Error: Book ID already exists. <a href='addBook.jsp'>Try Again</a></h3>");
            } else {
                // Insert new book details
                String insertQuery = "INSERT INTO books (book_id, title, author, num_of_copies, published_year) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                insertStmt.setInt(1, bookId);
                insertStmt.setString(2, title);
                insertStmt.setString(3, author);
                insertStmt.setInt(4, numOfCopies);
                insertStmt.setInt(5, publishedYear);

                int rowsAffected = insertStmt.executeUpdate();

                if (rowsAffected > 0) {
                    // Redirect to admin dashboard
                    response.sendRedirect("adminDashboard.jsp");
                } else {
                    // Display error message
                    response.getWriter().println("<h3>Error: Unable to add book. <a href='addBook.jsp'>Try Again</a></h3>");
                }
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Error: Unable to add book. <a href='addBook.jsp'>Try Again</a></h3>");
        }
    }
}
