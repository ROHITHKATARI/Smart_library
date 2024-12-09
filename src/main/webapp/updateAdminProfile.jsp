<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Retrieve email from session
    String email = (String) session.getAttribute("email");

    if (email == null) {
        response.sendRedirect("adminDashboard.jsp?error=Please log in");
        return;
    }

    // Fetch admin details from database
    String name = "";
    long mobile = 0;
    String password = "";

    try {
        Connection conn = LIBRARY_PROJECT.dao.DBConnection.getConnection();
        String query = "SELECT * FROM admin WHERE email = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            name = rs.getString("name");
            mobile = rs.getLong("mobile");
            password = rs.getString("password");
        } else {
            response.sendRedirect("adminDashboard.jsp?error=Admin not found");
            return;
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("adminDashboard.jsp?error=Unable to fetch profile details");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Profile</title>
   
    <link rel="stylesheet" href="./adminWelcome.css">
</head>
<body>

    <main class="main-content">
        <div class="form-container">
            <h1>Update Profile</h1>
            <form action="UpdateProfile" method="post">
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
