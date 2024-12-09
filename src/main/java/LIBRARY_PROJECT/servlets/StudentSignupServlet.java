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

@WebServlet("/student_signup")
public class StudentSignupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Getting form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String mobile = request.getParameter("mobile");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            // Establish database connection
            connection = DBConnection.getConnection();

            // Check if the email already exists in the database
            String checkQuery = "SELECT * FROM student WHERE email = ?";
            preparedStatement = connection.prepareStatement(checkQuery);
            preparedStatement.setString(1, email);
            if (preparedStatement.executeQuery().next()) {
                // Email already exists
                request.setAttribute("errorMessage", "Email already exists. Please try with a different one.");
                request.getRequestDispatcher("studentWelcome.jsp").forward(request, response);
                return;
            }

            // Insert the new student data into the database
            String insertQuery = "INSERT INTO student (email, password, name, mobile) VALUES (?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(insertQuery);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);
            preparedStatement.setString(3, name);
            preparedStatement.setString(4, mobile);

            int result = preparedStatement.executeUpdate();
            if (result > 0) {
                // Sign-up successful, redirect to the login page
                response.sendRedirect("studentWelcome.jsp");
            } else {
                // Sign-up failed
                request.setAttribute("errorMessage", "Sign-up failed. Please try again later.");
                request.getRequestDispatcher("studentWelcome.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Error during signup
            request.setAttribute("errorMessage", "Something went wrong. Please try again later.");
            request.getRequestDispatcher("studentWelcome.jsp").forward(request, response);
        } finally {
            // Close resources
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

