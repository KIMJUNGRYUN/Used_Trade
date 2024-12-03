<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Product, dao.ProductDAOImpl" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    // 기존 세션 가져오기 (새로 선언하지 않음)
    if (session == null) {
        response.sendRedirect("login.jsp");
        return;
    }

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

    // 세션에서 로그인 사용자 정보 가져오기
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    Integer userId = (Integer) session.getAttribute("userId");

    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 작성자거나 관리자가 아닌 경우 리디렉션
    if (!(role.equals("admin") || product.getSellerId() == userId)) {
        response.sendRedirect("main.jsp?status=access_denied");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Edit Product</h1>
        <form action="EditProductController" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="<%= product.getId() %>">
            <div class="form-group">
                <label for="title">Product Title</label>
                <input type="text" class="form-control" id="title" name="title" value="<%= product.getTitle() %>" required>
            </div>
            <div class="form-group">
                <label for="description">Product Description</label>
                <textarea class="form-control" id="description" name="description" rows="4" required><%= product.getDescription() %></textarea>
            </div>
            <div class="form-group">
                <label for="price">Price</label>
                <input type="number" class="form-control" id="price" name="price" value="<%= product.getPrice() %>" required>
            </div>
            <div class="form-group">
                <label for="categoryId">Category</label>
                <input type="text" class="form-control" id="categoryId" name="categoryId" value="<%= product.getCategoryId() %>" required>
            </div>
            <div class="form-group">
                <label for="status">Status</label>
                <select class="form-control" id="status" name="status" required>
                    <option value="available" <%= "available".equals(product.getStatus()) ? "selected" : "" %>>Available</option>
                    <option value="sold" <%= "sold".equals(product.getStatus()) ? "selected" : "" %>>Sold</option>
                </select>
            </div>
            <div class="form-group">
                <label for="image">Image</label>
                <input type="file" class="form-control" id="image" name="image">
                <small class="form-text text-muted">Leave blank if you don't want to change the image.</small>
            </div>
            <button type="submit" class="btn btn-primary">Update Product</button>
        </form>
        <a href="product_detail.jsp?id=<%= product.getId() %>" class="btn btn-secondary mt-3">Cancel</a>
    </div>
</body>
</html>
