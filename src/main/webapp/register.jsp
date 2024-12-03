<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
        .btn-primary:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }
        .btn-secondary {
            background-color: #6c757d;
            border: none;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .input-group-append .btn {
            border: none;
        }
        .form-text {
            color: white;
        }
        .form-text.valid {
            color: green;
        }
        .form-text.invalid {
            color: red;
        }
        .form-text.error {
            color: orange;
        }
        .alert {
            border-radius: 10px;
            font-weight: bold;
        }
       
        
        
    </style>
</head>
<body>
    <div class="welcome-text">
        <h1>Welcome to the Used Trade Platform</h1>
        <p>Join us and start trading your items with ease!</p>
    </div>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        Register
                    </div>
                    <div class="card-body">
                        <form action="RegisterProcess" method="post">
                            <!-- Email Input -->
                            <div class="form-group">
                                <label for="email">Email</label>
                                <div class="input-group">
                                    <input type="email" id="email" name="email" class="form-control" placeholder="Enter Email" required>
                                    <div class="input-group-append">
                                        <button type="button" id="checkEmailButton" class="btn btn-secondary">Check</button>
                                    </div>
                                </div>
                                <small id="emailFeedback" class="form-text"></small>
                            </div>
                            
                            <!-- Username Input -->
                            <div class="form-group">
                                <label for="username">Username</label>
                                <input type="text" name="username" class="form-control" placeholder="Enter Username" required>
                            </div>
                            
                            <!-- Password Input -->
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" name="password" class="form-control" placeholder="Enter Password" required>
                            </div>
                            
                            <!-- Submit Button -->
                            <button type="submit" class="btn btn-primary btn-block" id="registerButton">Register</button>
                            <a href="index.jsp" class="btn btn-primary btn-block">home</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- AJAX Script for Email Validation -->
    <script>
        $(document).ready(function() {
            $("#checkEmailButton").on("click", function() {
                let email = $("#email").val().trim();
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

                if (!emailRegex.test(email)) {
                    $("#emailFeedback").text("Please enter a valid email address.").addClass("invalid").removeClass("valid");
                    return;
                }

                $.ajax({
                    url: "CheckEmailServlet", // Servlet URL
                    method: "POST",
                    data: { email: email },
                    success: function(response) {
                        if (response === "exists") {
                            $("#emailFeedback").html('<i class="fas fa-times-circle"></i> Email is already in use.')
                                .addClass("invalid").removeClass("valid");
                            $("#registerButton").prop("disabled", true); // Disable the button
                        } else {
                            $("#emailFeedback").html('<i class="fas fa-check-circle"></i> Email is available.')
                                .addClass("valid").removeClass("invalid");
                            $("#registerButton").prop("disabled", false); // Enable the button
                        }
                    },
                    error: function() {
                        $("#emailFeedback").text("Error checking email. Please try again.")
                            .addClass("error").removeClass("valid invalid");
                    }
                });
            });
        });
    </script>
</body>
</html>
