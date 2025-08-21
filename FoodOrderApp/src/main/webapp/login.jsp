<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - FoodyGuy</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap');

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #0f9b0f, #00b894, #f39c12, #e17055);
            background-size: 400% 400%;
            animation: gradientBG 12s ease infinite;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .login-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(18px);
            border-radius: 20px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 850px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            overflow: hidden;
            border: 1px solid rgba(255,255,255,0.2);
        }

        /* Left Side (Brand) */
        .login-left {
            background: linear-gradient(135deg, rgba(39,174,96,0.95), rgba(243,156,18,0.95));
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 50px 30px;
            color: #fff;
        }

        .login-left img {
            width: 170px;
            height: 170px;
            border-radius: 50%;
            border: 4px solid #fff;
            object-fit: cover;
            box-shadow: 0 8px 25px rgba(0,0,0,0.25);
            margin-bottom: 25px;
        }

        .login-left h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 15px;
        }

        .login-left p {
            font-size: 1rem;
            opacity: 0.95;
            line-height: 1.6;
        }

        /* Right Side (Form) */
        .login-right {
            padding: 60px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            background: rgba(255,255,255,0.2);
        }

        .login-form h2 {
            color: #fff;
            text-shadow: 0 2px 8px rgba(0,0,0,0.3);
            margin-bottom: 30px;
            font-size: 2rem;
            text-align: center;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #f1f1f1;
            font-weight: 500;
        }

        .form-group input {
            width: 100%;
            padding: 14px 18px;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            background: rgba(255,255,255,0.9);
            transition: 0.3s ease;
        }

        .form-group input:focus {
            outline: none;
            background: #fff;
            box-shadow: 0 0 10px rgba(39,174,96,0.6);
        }

        .login-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(45deg, #27ae60, #f39c12, #e67e22);
            background-size: 200% auto;
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: 0.4s ease;
            margin-bottom: 20px;
        }

        .login-btn:hover {
            background-position: right center;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(243,156,18,0.4);
        }

        .register-link, .forgot-password {
            text-align: center;
            margin-top: 10px;
        }

        .register-link a, .forgot-password a {
            color: #fff;
            text-decoration: none;
            font-weight: 600;
            transition: 0.3s ease;
        }

        .register-link a:hover, .forgot-password a:hover {
            color: #ffeaa7;
        }

        .error-message {
            background: rgba(231,76,60,0.9);
            color: #fff;
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 18px;
            text-align: center;
            font-size: 0.95rem;
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .login-container {
                grid-template-columns: 1fr;
                max-width: 420px;
            }

            .login-left {
                padding: 40px 25px;
            }

            .login-right {
                padding: 40px 25px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <!-- Left: Branding -->
        <div class="login-left">
            <img src="images/fglogo.png" alt="FoodyGuy Logo">
            <h1>FoodyGuy</h1>
            <p>Fresh. Fast. Delicious. Login and enjoy premium food delivery at your fingertips!</p>
        </div>

        <!-- Right: Form -->
        <div class="login-right">
            <form class="login-form" action="LoginServlet" method="post">
                <h2>Welcome Back!</h2>

                <% String error = (String) request.getAttribute("error"); %>
                <% if (error != null) { %>
                    <div class="error-message">
                        <%= error %>
                    </div>
                <% } %>

                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required 
                           placeholder="Enter your username" 
                           value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required 
                           placeholder="Enter your password">
                </div>

                <button type="submit" class="login-btn">Login</button>

                <div class="register-link">
                    Don't have an account? <a href="register.jsp">Sign up here</a>
                </div>

                <div class="forgot-password">
                    <a href="#">Forgot Password?</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
