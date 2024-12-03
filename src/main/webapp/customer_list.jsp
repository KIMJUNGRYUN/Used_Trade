<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, model.Customer, dao.CustomerDAOImpl" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
    // DAO 생성
    CustomerDAOImpl customerDAO = new CustomerDAOImpl();

    // 현재 페이지 번호 가져오기 (기본값: 1)
    int currentPage = 1;
    if (request.getParameter("page") != null) {
        currentPage = Integer.parseInt(request.getParameter("page"));
    }

    // 한 페이지당 고객 수
    int pageSize = 10;

    // 전체 고객 수 및 총 페이지 수 계산
    int totalCustomers = customerDAO.getTotalCustomerCount();
    int totalPages = (int) Math.ceil((double) totalCustomers / pageSize);

    // 현재 페이지의 고객 목록 가져오기
    List<Customer> customerList = customerDAO.getCustomersByPage(currentPage, pageSize);

    // 삭제 요청 처리
    if (request.getParameter("action") != null && request.getParameter("action").equals("delete")) {
        int customerId = Integer.parseInt(request.getParameter("id"));
        customerDAO.deleteCustomerById(customerId);

        // 삭제 후 다시 고객 목록 가져오기
        customerList = customerDAO.getCustomersByPage(currentPage, pageSize);
        totalCustomers = customerDAO.getTotalCustomerCount();
        totalPages = (int) Math.ceil((double) totalCustomers / pageSize);
    }

    // 데이터 전달
    request.setAttribute("customerList", customerList);
    request.setAttribute("currentPage", currentPage);
    request.setAttribute("totalPages", totalPages);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>고객 목록</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">고객 목록</h1>
        <hr>

        <c:if test="${empty customerList}">
            <div class="alert alert-warning text-center" role="alert">
                고객 목록이 없습니다.
            </div>
        </c:if>

        <c:if test="${not empty customerList}">
            <table class="table table-bordered table-striped">
                <thead class="thead-dark">
                    <tr>
                        <th>고객 ID</th>
                        <th>이메일</th>
                        <th>사용자명</th>
                        <th>비밀번호</th>
                        <th>권한</th>
                        <th>가입일</th>
                        <th>작업</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="customer" items="${customerList}">
                        <tr>
                            <td>${customer.id}</td>
                            <td>${customer.email}</td>
                            <td>${customer.username}</td>
                            <td>${customer.password}</td>
                            <td>${customer.role}</td>
                            <td><fmt:formatDate value="${customer.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                            <td>
                                <form action="customer_list.jsp" method="get" style="display:inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${customer.id}">
                                    <button type="submit" class="btn btn-danger btn-sm">삭제</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- 페이징 버튼 -->
            <div class="d-flex justify-content-center">
                <nav>
                    <ul class="pagination">
                        <!-- 이전 페이지 -->
                        <c:if test="${currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="customer_list.jsp?page=${currentPage - 1}">이전</a>
                            </li>
                        </c:if>
                        <c:if test="${currentPage == 1}">
                            <li class="page-item disabled">
                                <span class="page-link">이전</span>
                            </li>
                        </c:if>

                        <!-- 페이지 번호 -->
                        <c:forEach var="page" begin="1" end="${totalPages}">
                            <li class="page-item ${page == currentPage ? 'active' : ''}">
                                <a class="page-link" href="customer_list.jsp?page=${page}">${page}</a>
                            </li>
                        </c:forEach>

                        <!-- 다음 페이지 -->
                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="customer_list.jsp?page=${currentPage + 1}">다음</a>
                            </li>
                        </c:if>
                        <c:if test="${currentPage == totalPages}">
                            <li class="page-item disabled">
                                <span class="page-link">다음</span>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </div>
        </c:if>

        <div class="text-center mt-3">
            <a href="main.jsp" class="btn btn-primary">홈으로</a>
        </div>
    </div>
</body>
</html>
