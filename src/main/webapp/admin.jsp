<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Page</title>
    <script>
        // 1초 후 main.jsp로 이동
        setTimeout(function() {
            window.location.href = "main.jsp";
        }, 1000);
    </script>
</head>
<body>
    <h1>Welcome, Admin!</h1>
    <p>You will be redirected to the main page shortly...</p>
</body>
</html>
