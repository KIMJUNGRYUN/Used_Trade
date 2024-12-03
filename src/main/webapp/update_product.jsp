<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Product, dao.ProductDAOImpl" %>
<%@ page import="jakarta.servlet.http.Part" %>

<%
    String productIdStr = request.getParameter("id");
    if (productIdStr == null || productIdStr.isEmpty()) {
        response.sendRedirect("edit_product.jsp?status=missing_id");
        return;
    }

    int productId = Integer.parseInt(productIdStr);
    String title = request.getParameter("title");
    String description = request.getParameter("description");
    double price = Double.parseDouble(request.getParameter("price"));
    String categoryId = request.getParameter("categoryId");
    String status = request.getParameter("status");

    ProductDAOImpl productDAO = new ProductDAOImpl();
    Product product = productDAO.getProductById(productId);

    if (product == null) {
        response.sendRedirect("main.jsp?status=product_not_found");
        return;
    }

    product.setTitle(title);
    product.setDescription(description);
    product.setPrice(price);
    product.setCategoryId(categoryId);
    product.setStatus(status);

    Part imagePart = request.getPart("image");
    if (imagePart != null && imagePart.getSize() > 0) {
        String fileName = "images/" + imagePart.getSubmittedFileName();
        imagePart.write(getServletContext().getRealPath("/") + fileName);
        product.setImage(fileName);
    }

    if (productDAO.updateProduct(product)) {
        response.sendRedirect("product_detail.jsp?id=" + product.getId() + "&status=update_success");
    } else {
        response.sendRedirect("edit_product.jsp?id=" + product.getId() + "&status=update_failed");
    }
%>
