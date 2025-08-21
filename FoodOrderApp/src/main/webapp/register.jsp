<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Foodyguy</title>
    <style>
    
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap');
       *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #0f9b0f, #00b894, #f39c12, #e17055);
            min-height: 100vh;
            display: flex;
            background-size: 400% 400%;
            align-items: center;
            justify-content: center;
            padding: 20px;
            animation: fadeIn 1s ease-in-out;
            animation: gradientBG 12s ease infinite;
        }
        
          @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        

        .register-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%;
            max-width: 1000px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            min-height: 600px;
            transform: scale(0.95);
            opacity: 0;
            animation: popIn 0.8s ease forwards;
        }

        /* left side */
        .register-left {
            background: linear-gradient(135deg, #4CAF50, #2ecc71);
            padding: 60px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            color: white;
            animation: slideInLeft 1s ease;
        }

        .register-left h1 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            font-weight: 700;
        }

        .register-left p {
            font-size: 1.1rem;
            opacity: 0.9;
            line-height: 1.6;
        }

        .food-icon {
            font-size: 4rem;
            margin-bottom: 30px;
            width: 200px;
            height: 200px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid white;
            animation: rotate 6s linear infinite;
        }

        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(-360deg); }
        }

        /* right side */
        .register-right {
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            max-height: 600px;
            overflow-y: auto;
            animation: slideInRight 1s ease;
        }

        .register-form h2 {
            color: #333;
            margin-bottom: 25px;
            font-size: 2rem;
            text-align: center;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-bottom: 5px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-group label {
            display: block;
            margin-bottom: 6px;
            color: #555;
            font-weight: 500;
            font-size: 0.9rem;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: #4CAF50;
            background: white;
            box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
            transform: translateY(-2px);
        }

        .register-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #4CAF50, #2ecc71);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-bottom: 20px;
        }

        .register-btn:hover {
            transform: translateY(-3px) scale(1.02);
            box-shadow: 0 10px 20px rgba(76, 175, 80, 0.3);
        }

        .login-link {
            text-align: center;
            color: #666;
        }

        .login-link a {
            color: #4CAF50;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .login-link a:hover {
            color: #2ecc71;
        }

        .error-message {
            background: #ffebee;
            color: #c62828;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 15px;
            border-left: 4px solid #c62828;
            animation: slideIn 0.3s ease;
            font-size: 0.9rem;
        }

        .success-message {
            background: #e8f5e8;
            color: #2e7d32;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 15px;
            border-left: 4px solid #4CAF50;
            animation: slideIn 0.3s ease;
            font-size: 0.9rem;
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideInLeft {
            from { opacity: 0; transform: translateX(-50px); }
            to { opacity: 1; transform: translateX(0); }
        }

        @keyframes slideInRight {
            from { opacity: 0; transform: translateX(50px); }
            to { opacity: 1; transform: translateX(0); }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes popIn {
            to { transform: scale(1); opacity: 1; }
        }

        @media (max-width: 768px) {
            .register-container {
                grid-template-columns: 1fr;
                max-width: 450px;
            }

            .register-left {
                padding: 30px 25px;
            }

            .register-left h1 {
                font-size: 2rem;
            }

            .register-right {
                padding: 30px 25px;
            }

            .form-row {
                grid-template-columns: 1fr;
                gap: 0;
            }

            .food-icon {
                font-size: 3rem;
                margin-bottom: 20px;
            }
        }

        .required {
            color: #e53e3e;
        }
   </style>
    
</head>
<body>
    <div class="register-container">
        <div class="register-left">
            <div><img class="food-icon" src="images/fglogo.png" alt="foodyguy logo"></div>
            <h1>Join Foodyguy</h1>
            <p>Create your account and discover amazing restaurants near you. Start your food journey today!</p>
        </div>
        
        <div class="register-right">
            <form class="register-form" action="RegisterServlet" method="post">
                <h2>Create Account</h2>
                
                <% String error = (String) request.getAttribute("error"); %>
                <% if (error != null) { %>
                    <div class="error-message">
                        <%= error %>
                    </div>
                <% } %>
                
                <% String success = (String) request.getAttribute("success"); %>
                <% if (success != null) { %>
                    <div class="success-message">
                        <%= success %>
                    </div>
                <% } %>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="name">Full Name <span class="required">*</span></label>
                        <input type="text" id="name" name="name" required 
                               placeholder="Enter your full name"
                               value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>">
                    </div>
                    
                    <div class="form-group">
                        <label for="username">Username <span class="required">*</span></label>
                        <input type="text" id="username" name="username" required 
                               placeholder="Choose a username"
                               value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="email">Email <span class="required">*</span></label>
                        <input type="email" id="email" name="email" required 
                               placeholder="Enter your email"
                               value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
                    </div>
                    
                    <div class="form-group">
                        <label for="phone">Phone Number <span class="required">*</span></label>
                        <input type="tel" id="phone" name="phone" required 
                               placeholder="Enter your phone number"
                               value="<%= request.getParameter("phone") != null ? request.getParameter("phone") : "" %>">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="address">Address <span class="required">*</span></label>
                    <input type="text" id="address" name="address" required 
                           placeholder="Enter your delivery address"
                           value="<%= request.getParameter("address") != null ? request.getParameter("address") : "" %>">
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="password">Password <span class="required">*</span></label>
                        <input type="password" id="password" name="password" required 
                               placeholder="Create a password" minlength="6">
                    </div>
                    
                    <div class="form-group">
                        <label for="confirmPassword">Confirm Password <span class="required">*</span></label>
                        <input type="password" id="confirmPassword" name="confirmPassword" required 
                               placeholder="Confirm your password" minlength="6">
                    </div>
                </div>
                
                <button type="submit" class="register-btn">Create Account</button>
                
                <div class="login-link">
                    Already have an account? <a href="login.jsp">Login here</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Password confirmation validation
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            
            if (password !== confirmPassword) {
                this.setCustomValidity('Passwords do not match');
            } else {
                this.setCustomValidity('');
            }
        });

        // Phone number formatting
        document.getElementById('phone').addEventListener('input', function() {
            let value = this.value.replace(/\D/g, '');
            if (value.length >= 10) {
                value = value.substring(0, 10);
            }
            this.value = value;
        });
    </script>
</body>
</html>
