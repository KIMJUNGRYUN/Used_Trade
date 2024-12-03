package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.LoginDAO;
import dao.LoginDAOImple;
import model.Login;
import util.DBConnection;

@WebServlet("/Loginprocess")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("Login attempt: email=" + email + ", password=" + password);

        String query = "SELECT id, username, role FROM tbl_users WHERE email = ? AND password = ?";

        try (Connection con = DBConnection.openConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, email);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int userId = rs.getInt("id");
                    String username = rs.getString("username");
                    String role = rs.getString("role");

                    System.out.println("Login success: userId=" + userId + ", username=" + username + ", role=" + role);

                    HttpSession session = request.getSession(true); // 세션 생성
                    session.setAttribute("userId", userId);
                    session.setAttribute("username", username);
                    session.setAttribute("role", role);

                    if ("admin".equals(role)) {
                        response.sendRedirect("admin.jsp");
                    } else if ("user".equals(role)) {
                        response.sendRedirect("user.jsp");
                    }
                } else {
                    System.out.println("Login failed: invalid email or password.");
                    response.sendRedirect("index.jsp?status=false");
                }
            }
        } catch (Exception e) {
            System.err.println("Database error: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("index.jsp?status=error");
        }
    }
}
