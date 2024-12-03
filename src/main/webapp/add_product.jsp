<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product</title>
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
        select.form-control {
            background: rgba(255, 255, 255, 0.2);
            color: #ffffff;
        }
        select.form-control option {
            background: #333333; /* Dark background for dropdown options */
            color: #ffffff;
        }
    </style>
</head>
<body>
    <div class="welcome-text">
        <h1>Add a New Product</h1>
        <p>Fill in the details below to list your product for sale!</p>
    </div>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        Add Product
                    </div>
                    <div class="card-body">
                        <!-- Form for adding a new product -->
                        <form action="AddProductController" method="post" enctype="multipart/form-data">
                            <!-- Product Title -->
                            <div class="form-group">
                                <label for="title">Product Title</label>
                                <input type="text" name="title" id="title" class="form-control" placeholder="Enter product title" required>
                            </div>

                            <!-- Product Description -->
                            <div class="form-group">
                                <label for="description">Description</label>
                                <textarea name="description" id="description" rows="4" class="form-control" placeholder="Enter product description" required></textarea>
                            </div>

                            <!-- Product Price -->
                            <div class="form-group">
                                <label for="price">Price ($)</label>
                                <input type="number" step="0.01" name="price" id="price" class="form-control" placeholder="Enter product price" required>
                            </div>

                            <!-- Product Category -->
                            <div class="form-group">
                                <label for="category">Category</label>
                                <select name="category" id="category" class="form-control" required>
                                    <option value="" disabled selected>Select a Category</option>
                                    <option value="Electronics">Electronics</option>
                                    <option value="Furniture">Furniture</option>
                                    <option value="Books">Books</option>
                                    <option value="Clothing">Clothing</option>
                                </select>
                            </div>

                            <!-- Product Image -->
                            <div class="form-group">
                                <label for="image">Product Image</label>
                                <input type="file" name="image" id="image" class="form-control-file" accept="image/*" required>
                            </div>
                            <!-- Submit Button -->
                            <button type="submit" class="btn btn-primary btn-block">Add Product</button>
                            <a href="main.jsp" class="btn btn-primary btn-block">Home</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
