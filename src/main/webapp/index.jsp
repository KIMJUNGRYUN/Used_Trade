<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        body {
            background: url('<%= request.getContextPath() %>/images/background.jpg') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Arial', sans-serif;
            color: #ffffff;
        }
        .welcome-text {
            text-align: center;
            color: #ffffff;
            text-shadow: 2px 2px 6px rgba(0, 0, 0, 0.8);
            margin-top: 40px;
            font-family: 'Arial', sans-serif;
        }
        .welcome-text h1 {
            font-size: 3.5rem;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .welcome-text p {
            font-size: 1.3rem;
            margin-bottom: 30px;
        }
        .card {
            background: rgba(255, 255, 255, 0.15);
            border: none;
            border-radius: 15px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(10px);
            padding: 20px;
            color: #ffffff;
        }
        .card-header {
            text-align: center;
            font-size: 1.8rem;
            font-weight: bold;
            text-shadow: 1px 1px 4px rgba(0, 0, 0, 0.7);
            border-bottom: none;
        }
        .form-control {
            background: rgba(255, 255, 255, 0.2);
            border: none;
            color: #ffffff;
        }
        .form-control:focus {
            background: rgba(255, 255, 255, 0.3);
            border: none;
            box-shadow: none;
            color: #ffffff;
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
            font-weight: bold;
            box-shadow: 0 4px 10px rgba(0, 123, 255, 0.5);
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .link-register a {
            color: #007bff; /* 파란색 */
            font-weight: bold;
            text-decoration: none;
        }
        .link-register a:hover {
            color: #0056b3; /* 더 밝은 파란색 */
            text-decoration: underline;
        }
        .alert {
            border-radius: 10px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <!-- 환영 메시지 -->
    <div class="welcome-text">
        <h1>Welcome to the Used Trade Platform</h1>
        <p>Discover amazing deals or sell your items here. Log in to explore more!</p>
    </div>

    <!-- 로그인 카드 -->
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card">
                    <div class="card-header">
                        Login
                    </div>
                    <div class="card-body">
                        <!-- 메시지 표시 -->
                        <%
                            String status = request.getParameter("status");
                            if ("registered".equals(status)) { 
                        %>
                            <div class="alert alert-success text-center" role="alert">
                                Registration successful! You can now log in.
                            </div>
                        <% } else if ("false".equals(status)) { %>
                            <div class="alert alert-danger text-center" role="alert">
                                Incorrect email or password. Please try again.
                            </div>
                        <% } else if ("error".equals(status)) { %>
                            <div class="alert alert-danger text-center" role="alert">
                                An error occurred. Please try again later.
                            </div>
                        <% } else if ("unauthorized".equals(status)) { %>
                            <div class="alert alert-warning text-center" role="alert">
                                Unauthorized access. Please log in first.
                            </div>
                        <% } %>

                        <!-- 로그인 폼 -->
                        <form action="Loginprocess" method="post">
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" name="email" id="email" class="form-control" placeholder="Enter your email" required>
                            </div>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" name="password" id="password" class="form-control" placeholder="Enter your password" required>
                            </div>
                            <button type="submit" class="btn btn-primary btn-block">Login</button>
                        </form>

                        <!-- 회원가입 링크 -->
                        <div class="text-center mt-3 link-register">
                            <p>Don't have an account? <a href="register.jsp">Register here</a>.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
