package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.DBConnection;

@WebServlet("/RegisterProcess")
public class RegisterProcess extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 이메일 형식 검증 (정규식)
        if (!isValidEmail(email)) {
            response.sendRedirect("register.jsp?status=invalid_email");
            return;
        }

        String query = "INSERT INTO tbl_users (email, username, password) VALUES (?, ?, ?)";

        try (Connection con = DBConnection.openConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, email);
            ps.setString(2, username);
            ps.setString(3, password);

            int rowsAffected = ps.executeUpdate(); // 데이터 삽입 확인
            if (rowsAffected > 0) {
                System.out.println("User registered successfully: " + email);
                response.sendRedirect("index.jsp?status=registered"); // 회원가입 성공
            } else {
                response.sendRedirect("register.jsp?status=error"); // 회원가입 실패
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?status=error"); // 에러 발생
        }
    }

    private boolean isValidEmail(String email) {
        String emailRegex = "^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$";
        return email != null && email.matches(emailRegex);
    }
}
