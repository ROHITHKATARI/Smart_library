package LIBRARY_PROJECT.controller;

import LIBRARY_PROJECT.dao.Book;
import LIBRARY_PROJECT.dao.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/BookServlet")
public class BookServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Book> bookList = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String query = "SELECT * FROM books";
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setNumOfCopies(rs.getInt("num_of_copies"));
                book.setPublishedYear(rs.getInt("published_year"));
                bookList.add(book);
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Set the bookList as a request attribute and forward to JSP
        request.setAttribute("bookList", bookList);
        request.getRequestDispatcher("StudentDashboard.jsp").forward(request, response);
    }
}
