package controller;

import dao.LoginDAOImple;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CheckEmailServlet")
public class CheckEmailServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");

        LoginDAOImple loginDAO = new LoginDAOImple();
        boolean exists = loginDAO.isEmailExists(email);

        response.setContentType("text/plain");
        response.getWriter().write(exists ? "exists" : "available");
    }
}
