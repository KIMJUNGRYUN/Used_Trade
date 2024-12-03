<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.Product, dao.ProductDAOImpl, java.util.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    // 상품 ID 가져오기
    String productId = request.getParameter("id");
    if (productId == null || productId.isEmpty()) {
        response.sendRedirect("main.jsp?status=invalid_product");
        return;
    }

    // 상품 정보 가져오기
    ProductDAOImpl productDAO = new ProductDAOImpl();
    Product product = productDAO.getProductById(Integer.parseInt(productId));

    if (product == null) {
        response.sendRedirect("main.jsp?status=product_not_found");
        return;
    }

    // 세션 객체 가져오기
    HttpSession userSession = request.getSession(false);
    if (userSession == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 세션에서 로그인 사용자 정보 가져오기
    String username = (String) userSession.getAttribute("username");
    String role = (String) userSession.getAttribute("role");
    int userId = (Integer) userSession.getAttribute("userId");

    // 작성자거나 관리자가 수정 가능하도록 처리
    boolean canEdit = false;
    if (username != null && role != null) {
        if (role.equals("admin") || (product.getSellerId() == userId)) {
            canEdit = true;
        }
    }

    // 날짜 포맷 지정
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }
        .container {
            margin-top: 50px;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
            overflow: hidden;
        }
        .card img {
            width: 100%;
            height: 450px;
            object-fit: cover;
        }
        .card-body {
            padding: 30px;
        }
        .card-title {
            font-size: 2rem;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
        }
        .card-text {
            color: #555;
            line-height: 1.6;
        }
        .btn {
            border-radius: 50px;
            font-weight: bold;
            padding: 12px 24px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-center mb-4">Product Details</h1>
        <div class="card mx-auto" style="max-width: 700px;">
            <img src="images/<%= product.getImage() %>" class="card-img-top" alt="<%= product.getTitle() %>">
            <div class="card-body">
                <h2 class="card-title text-center"><%= product.getTitle() %></h2>
                <p class="card-text"><strong>Description:</strong> <%= product.getDescription() %></p>
                <p class="card-text"><strong>Price:</strong> $<%= product.getPrice() %></p>
                <p class="card-text"><strong>Category:</strong> <%= product.getCategoryId() %></p>
                <p class="card-text"><strong>Status:</strong> <%= product.getStatus() %></p>
                <p class="card-text"><strong>Posted On:</strong> <%= sdf.format(product.getCreatedAt()) %></p> <!-- 상품 올린 날짜 -->

                <!-- 버튼 섹션 -->
                <div class="d-flex justify-content-between mt-4">
                    <a href="main.jsp" class="btn btn-secondary">Back to Main</a>
                    
                    <% if (canEdit) { %>
                        <a href="edit_product.jsp?id=<%= product.getId() %>" class="btn btn-primary">Edit Product</a>
                        <form action="DeleteProductController" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="<%= product.getId() %>">
                            <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this product?')">Delete Product</button>
                        </form>
                    <% } %>

                    <!-- 찜하기 버튼 -->
                    <form action="WishlistController" method="post" style="display:inline;">
                        <input type="hidden" name="product_id" value="<%= product.getId() %>">
                        <button type="submit" class="btn btn-warning">Add to Wishlist</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
