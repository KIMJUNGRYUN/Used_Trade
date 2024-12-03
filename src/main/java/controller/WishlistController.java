package controller;

import dao.WishlistDAO;
import dao.WishlistDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/WishlistController")
public class WishlistController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private WishlistDAO wishlistDAO = new WishlistDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = (Integer) session.getAttribute("userId");
        int productId = Integer.parseInt(request.getParameter("product_id"));

        if (!wishlistDAO.isProductInWishlist(userId, productId)) {
            wishlistDAO.addToWishlist(userId, productId);
            response.sendRedirect("main.jsp?status=wishlist_added");
        } else {
            response.sendRedirect("main.jsp?status=already_in_wishlist");
        }
    }
}
