<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Product, dao.ProductDAO, dao.ProductDAOImpl, java.util.List"%>
<%@ page import="java.util.*" %>

<%
    // 세션 및 역할 확인
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || role == null) {
        response.sendRedirect("index.jsp?status=unauthorized");
        return;
    }

    // 현재 페이지 번호를 파라미터로 받기, 기본값은 1
    int pageNumber = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
    int pageSize = 9;  // 한 페이지에 보여줄 상품 개수

    // 상품 리스트 가져오기
    ProductDAO productDAO = new ProductDAOImpl();
    List<Product> productList;
    String keyword = request.getParameter("keyword"); // 검색 키워드

    if (keyword != null && !keyword.trim().isEmpty()) {
        productList = productDAO.searchProducts(keyword.trim()); // 검색된 상품 리스트
    } else {
        productList = productDAO.getAllProducts(pageNumber, pageSize); // 전체 상품 리스트
    }

    // 전체 상품 수 구하기
    int totalProducts = productDAO.getTotalProductCount();
    int totalPages = (int) Math.ceil((double) totalProducts / pageSize);  // 전체 페이지 수
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Used Trade Platform - Main</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        /* 스타일은 그대로 유지 */
        body {
            background-size: cover;
            font-family: 'Arial', sans-serif;
            color: #fff;
        }
        .main-container {
            margin-top: 50px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            padding: 20px 30px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            color: #333;
        }
        .card {
            border: none;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }
        .navbar {
            background: rgba(0, 0, 0, 0.7);
        }
        .navbar .nav-link {
            color: #fff;
            font-weight: bold;
        }
        .navbar .nav-link:hover {
            color: #ffd700;
        }
        .form-inline input {
            flex: 1;
            border-radius: 30px;
            padding: 10px 15px;
        }
        .btn-primary {
            border-radius: 30px;
        }
        .pagination .page-link {
            border-radius: 50%;
        }
        footer {
            background: rgba(0, 0, 0, 0.7);
            color: #fff;
            padding: 20px 0;
            margin-top: 30px;
            text-align: center;
            border-radius: 15px;
        }
        footer a {
            color: #ffd700;
        }
    </style>
</head>
<body>
    <!-- 네비게이션 바 -->
    <nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="main.jsp">UsedTrade</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <span class="nav-link">Welcome, <b><%= username != null ? username : "Guest" %></b></span>
                </li>
                <% if ("admin".equals(role)) { %>
                    <!-- 어드민일 경우 Customer List 표시 -->
                    <li class="nav-item">
                        <a class="nav-link" href="customer_list.jsp">Customer List</a>
                    </li>
                <% } else { %>
                    <!-- 일반 사용자일 경우 My Wishlist와 Add Product 표시 -->
                    <li class="nav-item">
                        <a class="nav-link" href="wishlist.jsp">My Wishlist</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="add_product.jsp">Add Product</a>
                    </li>
                <% } %>
                <li class="nav-item">
                    <a class="nav-link text-danger" href="logout.jsp">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>


    <div class="container main-container">
        <!-- 검색 폼 -->
        <form action="main.jsp" method="get" class="form-inline justify-content-center mb-4">
            <input type="text" name="keyword" value="<%= keyword != null ? keyword : "" %>" class="form-control mr-2" placeholder="Search for products..." required>
            <button type="submit" class="btn btn-primary">Search</button>
        </form>

        <!-- 상품 리스트 -->
        <h1 class="text-center mb-4">Available Products</h1>
        <div class="row">
    <% if (productList != null && !productList.isEmpty()) { 
        for (Product product : productList) { %>
            <div class="col-md-4 mb-4">
                <div class="card">
                    <img src="images/<%= product.getImage() %>" class="card-img-top" alt="<%= product.getTitle() %>" style="height: 200px; object-fit: cover;">
                    <div class="card-body">
                        <h5 class="card-title"><%= product.getTitle() %></h5>
                        <p class="card-text text-truncate" title="<%= product.getDescription() %>"><%= product.getDescription() %></p>
                        <p class="text-primary font-weight-bold">$<%= product.getPrice() %></p>
                        <a href="product_detail.jsp?id=<%= product.getId() %>" class="btn btn-primary btn-block">View Details</a>
                    </div>
                </div>
            </div>
        <% }
    } else { %>
        <div class="col-12">
            <p class="text-center">No products available.</p>
        </div>
    <% } %>
</div>

        <!-- 페이지 네비게이션 -->
        <% if (keyword == null || keyword.trim().isEmpty()) { %>
        <div class="d-flex justify-content-center">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li class="page-item <%= pageNumber == 1 ? "disabled" : "" %>">
                        <a class="page-link" href="main.jsp?page=<%= pageNumber - 1 %>">Previous</a>
                    </li>
                    <% for (int i = 1; i <= totalPages; i++) { %>
                        <li class="page-item <%= pageNumber == i ? "active" : "" %>">
                            <a class="page-link" href="main.jsp?page=<%= i %>"><%= i %></a>
                        </li>
                    <% } %>
                    <li class="page-item <%= pageNumber == totalPages ? "disabled" : "" %>">
                        <a class="page-link" href="main.jsp?page=<%= pageNumber + 1 %>">Next</a>
                    </li>
                </ul>
            </nav>
        </div>
        <% } %>
        
    </div>

    <!-- 푸터 -->
    <footer>
        <p>&copy; 2024 UsedTrade. All rights reserved. <a href="about.jsp">About Us</a></p>
    </footer>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
