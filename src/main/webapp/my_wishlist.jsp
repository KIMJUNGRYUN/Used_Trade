<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Product, dao.ProductDAOImpl, dao.WishlistDAOImpl, model.Wishlist" %>
<%@ page import="java.util.List" %>

<%
    HttpSession usersession = request.getSession(false);
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int userId = (Integer) session.getAttribute("userId");

    WishlistDAOImpl wishlistDAO = new WishlistDAOImpl();
    ProductDAOImpl productDAO = new ProductDAOImpl();
    List<Wishlist> wishlistItems = wishlistDAO.getWishlistByUserId(userId);
    //이 페이지가 무슨 일을 하는지 모르겠다. 솔직히 근데 지우면 망할것같다. 그냥 내버려 두자
    //I don't know why the error occurred. First of all, the program runs well.
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Wishlist</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">My Wishlist</h1>
        <div class="row mt-4">
            <% if (!wishlistItems.isEmpty()) {
                for (Wishlist item : wishlistItems) {
                    Product product = productDAO.getProductById(item.getProductId());
                    if (product != null) { %>
                        <div class="col-md-4 mb-4">
                            <div class="card">
                                <img src="images/<%= product.getImage() %>" class="card-img-top" alt="<%= product.getTitle() %>" style="height: 200px; object-fit: cover;">
                                <div class="card-body">
                                    <h5 class="card-title"><%= product.getTitle() %></h5>
                                    <p class="card-text"><%= product.getDescription() %></p>
                                    <p class="text-primary">$<%= product.getPrice() %></p>
                                </div>
                            </div>
                        </div>
            <%      }
                }
            } else { %>
                <p class="text-center">No products in your wishlist.</p>
            <% } %>
        </div>
    </div>
</body>
</html>
