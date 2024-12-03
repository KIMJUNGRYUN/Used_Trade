package controller;

import dao.CustomerDAO;
import dao.CustomerDAOImpl;
import model.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/CustomerController")
public class CustomerController extends HttpServlet {
    private static final int PAGE_SIZE = 10; // 한 페이지에 표시할 고객 수

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomerDAO customerDAO = new CustomerDAOImpl();

        // 현재 페이지 번호 가져오기
        int pageNumber = 1; // 기본값
        if (request.getParameter("page") != null) {
            pageNumber = Integer.parseInt(request.getParameter("page"));
        }

        // 페이징 데이터 가져오기
        List<Customer> customerList = customerDAO.getCustomersByPage(pageNumber, PAGE_SIZE);
        int totalCustomers = customerDAO.getTotalCustomerCount(); // 전체 고객 수
        int totalPages = (int) Math.ceil((double) totalCustomers / PAGE_SIZE); // 총 페이지 수

        // JSP로 데이터 전달
        request.setAttribute("customerList", customerList);
        request.setAttribute("currentPage", pageNumber);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/customer_list.jsp").forward(request, response);
    }
}
