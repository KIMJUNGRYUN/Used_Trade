<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Product, dao.WishlistDAO, dao.WishlistDAOImpl, java.util.List" %>

<%
    // 세션 확인
    Integer userId = (Integer) session.getAttribute("userId");
    String username = (String) session.getAttribute("username");

    if (userId == null || username == null) {
        response.sendRedirect("index.jsp?status=unauthorized");
        return;
    }

    // WishlistDAO 초기화
    WishlistDAO wishlistDAO = new WishlistDAOImpl();
    List<Product> wishlist = wishlistDAO.getWishlistByUserId(userId); // 현재 사용자의 찜한 상품 가져오기
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Wishlist</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        body {
            background: url('<%= request.getContextPath() %>/images/background.jpg') no-repeat center center fixed;
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
        .btn {
            border-radius: 30px;
        }
        .home-btn {
            display: block;
            margin: 20px auto;
            background-color: #007bff;
            color: white;
            border: none;
            font-weight: bold;
            padding: 10px 20px; /* 상하, 좌우 여백 */
            text-align: center;
            border-radius: 30px;
            font-size: 1rem;
            width: 150px; /* 버튼의 너비를 설정 */
            box-shadow: 0 4px 10px rgba(0, 123, 255, 0.5);
            transition: background-color 0.3s, box-shadow 0.3s;
        }
        .home-btn:hover {
            background-color: #0056b3;
            box-shadow: 0 6px 15px rgba(0, 86, 179, 0.5);
        }
    </style>
</head>
<body>
    <div class="container main-container">
        <h1 class="text-center mb-4">My Wishlist</h1>
        <div class="row">
            <% if (wishlist != null && !wishlist.isEmpty()) { 
                for (Product product : wishlist) { %>
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
                    <p class="text-center">You haven't added any products to your wishlist yet.</p>
                </div>
            <% } %>
        </div>

        <!-- 홈 버튼 -->
        <a href="main.jsp" class="home-btn">Home</a>
    </div>
</body>
</html>