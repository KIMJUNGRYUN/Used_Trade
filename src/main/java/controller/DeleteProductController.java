package controller;

import java.io.IOException;

import dao.ProductDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/DeleteProductController")
public class DeleteProductController extends HttpServlet{
	
@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		// 세션 확인
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp?status=unauthorized");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        String role = (String) session.getAttribute("role");

        // 상품 ID 가져오기
        String productIdParam = request.getParameter("id");
        if (productIdParam == null || productIdParam.isEmpty()) {
            response.sendRedirect("main.jsp?status=invalid_product");
            return;
        }

        int productId = Integer.parseInt(productIdParam);
        ProductDAOImpl productDAO = new ProductDAOImpl();

        // 삭제 권한 확인
        boolean hasPermission = role.equals("admin") || productDAO.getProductById(productId).getSellerId() == userId;
        if (!hasPermission) {
            response.sendRedirect("main.jsp?status=access_denied");
            return;
        }

        // 상품 삭제
        boolean isDeleted = productDAO.deleteProduct(productId);
        if (isDeleted) {
            response.sendRedirect("main.jsp?status=delete_success");
        } else {
            response.sendRedirect("product_detail.jsp?id=" + productId + "&status=delete_failed");
        }
    }

}

