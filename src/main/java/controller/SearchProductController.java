package controller;

import dao.ProductDAOImpl;
import model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/SearchProductController")
public class SearchProductController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");

        // 검색어가 없는 경우 메인 페이지로 리디렉션
        if (keyword == null || keyword.trim().isEmpty()) {
            response.sendRedirect("main.jsp");
            return;
        }

        // DAO를 사용하여 검색 결과 가져오기
        ProductDAOImpl productDAO = new ProductDAOImpl();
        List<Product> searchResults = productDAO.searchProducts(keyword);

        // 결과를 request에 저장
        request.setAttribute("searchResults", searchResults);

        // 검색 결과 페이지로 포워딩
        request.getRequestDispatcher("search_results.jsp").forward(request, response);
    }
}
