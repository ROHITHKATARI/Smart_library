<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Book</title>
     <link rel="stylesheet" href="addBook.css">
    <link rel="icon" type="image/png" href="./images/icon.png">
</head>
<body>
    <div class="form-container">
        <h1>Edit Book</h1>
        <%
            int bookId = Integer.parseInt(request.getParameter("book_id"));
            try {
                Connection conn = LIBRARY_PROJECT.dao.DBConnection.getConnection();
                String query = "SELECT * FROM books WHERE book_id = ?";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setInt(1, bookId);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
        %>
        <form action="EditBook" method="post">
            <input type="hidden" name="book_id" value="<%= rs.getInt("book_id") %>" readonly>

            <label for="title">Book Title:</label>
            <input type="text" id="title" name="title" value="<%= rs.getString("title") %>" required>

            <label for="author">Author:</label>
            <input type="text" id="author" name="author" value="<%= rs.getString("author") %>" required>

            <label for="num_of_copies">Number of Copies:</label>
            <input type="number" id="num_of_copies" name="num_of_copies" value="<%= rs.getInt("num_of_copies") %>" required>

            <label for="published_year">Published Year:</label>
            <input type="number" id="published_year" name="published_year" value="<%= rs.getInt("published_year") %>" required>

            <button type="submit" class="submit-btn">Update Book</button>
        </form>
        <%
                } else {
                    out.println("<p>Book not found!</p>");
                }
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </div>
</body>
</html>
