<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    String email = (String) session.getAttribute("email");

    if (email == null) {
        response.sendRedirect("studentWelcome.jsp?error=Please log in first");
        return;
    }

    String name = "";
    long mobile = 0;
    String password = "";

    try {
        Connection conn = LIBRARY_PROJECT.dao.DBConnection.getConnection();
        String query = "SELECT * FROM student WHERE email = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
        	name = rs.getString("name");
            mobile = rs.getLong("mobile");
            password = rs.getString("password");
        }

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Hub</title>
    <link rel="stylesheet" href="studentWelcome.css">
    <link rel="icon" type="image/png" href="./images/icon.png">
</head>
<body>

    <main class="main-content">
        <div class="form-container">
            <h1>Update Profile</h1>
            <form action="updateProfileHandler" method="post">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="<%= name %>" required><br><br>

                <label for="mobile">Mobile:</label>
                <input type="text" id="mobile" name="mobile" value="<%= mobile %>" required><br><br>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= email %>" readonly><br><br>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" value="<%= password %>" required><br><br>

                <button type="submit" class="submit-btn">Update Profile</button>
            </form>
        </div>
    </main>
</body>
</html>
