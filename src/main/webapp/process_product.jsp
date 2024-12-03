<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Product, dao.ProductDAOImpl" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.List" %>

<%
    String productId = request.getParameter("id");
    if (productId == null || productId.isEmpty()) {
        response.sendRedirect("main.jsp?status=invalid_product");
        return;
    }

    // 상품 정보 업데이트
    ProductDAOImpl productDAO = new ProductDAOImpl();
    Product product = productDAO.getProductById(Integer.parseInt(productId));

    if (product == null) {
        response.sendRedirect("main.jsp?status=product_not_found");
        return;
    }

    // 폼에서 전달된 값 가져오기
    String title = request.getParameter("title");
    String description = request.getParameter("description");
    double price = Double.parseDouble(request.getParameter("price"));
    String categoryId = request.getParameter("categoryId");
    String status = request.getParameter("status");
    Part imagePart = request.getPart("image");  // 파일 처리

    // 상품 객체 업데이트
    product.setTitle(title);
    product.setDescription(description);
    product.setPrice(price);
    product.setCategoryId(categoryId);
    product.setStatus(status);

    // 이미지 파일이 존재하는 경우 파일 경로 업데이트
    if (imagePart != null && imagePart.getSize() > 0) {
        String imagePath = "images/" + imagePart.getSubmittedFileName();
        imagePart.write(getServletContext().getRealPath("/") + imagePath);
        product.setImage(imagePath);  // 이미지 경로 업데이트
    }

    // 상품 정보 업데이트
    boolean isUpdated = productDAO.updateProduct(product);
    if (isUpdated) {
        response.sendRedirect("product_detail.jsp?id=" + product.getId() + "&status=success");
    } else {
        response.sendRedirect("update_product.jsp?id=" + product.getId() + "&status=failed");
    }
%>
