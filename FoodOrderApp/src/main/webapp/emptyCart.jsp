<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Empty Cart</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(-45deg, #0f2027, #134e5e, #2c7744, #000000);
            background-size: 400% 400%;
            animation: gradientShift 12s ease infinite;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .container {
            text-align: center;
            background: rgba(255, 255, 255, 0.08);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.4);
            animation: fadeIn 0.8s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .icon {
            font-size: 70px;
            color: #ff6b6b;
            margin-bottom: 20px;
            animation: bounce 2s infinite ease-in-out;
        }

        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-8px); }
        }

        h1 {
            color: #ffffff;
            margin-bottom: 10px;
        }

        p {
            color: #cccccc;
            font-size: 16px;
            margin-bottom: 25px;
        }

        a {
            text-decoration: none;
            background: linear-gradient(135deg, #36d1dc, #5b86e5);
            padding: 12px 28px;
            border-radius: 25px;
            color: #fff;
            font-weight: bold;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        a:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 14px rgba(91, 134, 229, 0.6);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="icon">🛒</div>
        <h1>Your Cart is Empty</h1>
        <p>Looks like you haven't added anything yet.</p>
        <a href="GetAllRestaurantServlet">Browse Restaurants</a>
    </div>
</body>
</html>
