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

@WebServlet("/EditBook")
public class EditBook extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("book_id"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        int numOfCopies = Integer.parseInt(request.getParameter("num_of_copies"));
        int publishedYear = Integer.parseInt(request.getParameter("published_year"));

        try {
            Connection conn = DBConnection.getConnection();
            String query = "UPDATE books SET title = ?, author = ?, num_of_copies = ?, published_year = ? WHERE book_id = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, title);
            ps.setString(2, author);
            ps.setInt(3, numOfCopies);
            ps.setInt(4, publishedYear);
            ps.setInt(5, bookId);

            int result = ps.executeUpdate();
            conn.close();

            if (result > 0) {
                response.sendRedirect("adminDashboard.jsp?message=Book updated successfully");
            } else {
                response.sendRedirect("editBook.jsp?book_id=" + bookId + "&error=Failed to update book");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("editBook.jsp?book_id=" + bookId + "&error=An error occurred");
        }
    }
}
