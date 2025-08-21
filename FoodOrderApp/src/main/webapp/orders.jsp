<%@ page import="java.util.List" %>
<%@ page import="com.tap.models.Orders" %>
<%@ page import="com.tap.models.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    List<Orders> ordersList = (List<Orders>) request.getAttribute("ordersList");
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History - FoodExpress</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(-45deg, #0f2027, #134e5e, #2c7744, #000000);


            min-height: 100vh;
            padding: 20px;
 			background-size: 400% 400%;
			animation: gradientBG 15s ease infinite;
		}

@keyframes gradientBG {
  0% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
  100% { background-position: 0% 50%; }
}
 			

        .header {
            text-align: center;
            margin-bottom: 40px;
            color: white;
            position: relative;
        }

        .header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .header p {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        .top-nav {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1000;
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }

        .user-welcome {
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1000;
            color: white;
            font-weight: 600;
            background: rgba(255, 255, 255, 0.1);
            padding: 8px 15px;
            border-radius: 20px;
            backdrop-filter: blur(10px);
        }

        .nav-btn {
            background: rgba(255, 255, 255, 0.2);
            border: 2px solid rgba(255, 255, 255, 0.3);
            color: white;
            padding: 10px 20px;
            border-radius: 25px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 0.9rem;
            white-space: nowrap;
        }

        .nav-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            border-color: rgba(255, 255, 255, 0.5);
            transform: translateY(-2px);
            color: white;
            text-decoration: none;
        }
      
      .nav-btn.cart { 
      background: linear-gradient(45deg, #1e88e5, #42a5f5); 
      border-color: transparent; 
      }
    
      .nav-btn.cart:hover {
       background: linear-gradient(45deg, #1565c0, #2196f3); 
       transform: translateY(-2px) scale(1.05); 
       }
        .logout-form {
            display: inline-block;
        }

        .logout-form .nav-btn {
            background: linear-gradient(45deg, #f44336, #d32f2f);
            border: none;
        }

        .logout-form .nav-btn:hover {
            background: linear-gradient(45deg, #d32f2f, #c62828);
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            text-decoration: none;
            padding: 12px 20px;
            border-radius: 25px;
            margin-bottom: 30px;
            transition: all 0.3s ease;
            font-weight: 600;
        }

        .back-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
            color: white;
            text-decoration: none;
        }

        .orders-container {
            display: grid;
            gap: 25px;
        }

        .order-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            transition: all 0.3s ease;
        }

        .order-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
        }

        .order-header {
           background: linear-gradient(135deg, #1d976c, #93f9b9);

            color: white;
            padding: 20px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 10px;
        }

        .order-id {
            font-size: 1.2rem;
            font-weight: 700;
        }

        .order-date {
            font-size: 0.9rem;
            opacity: 0.9;
        }

        .order-details {
            padding: 25px;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #f0f0f0;
        }

        .detail-row:last-child {
            border-bottom: none;
            font-weight: 700;
            font-size: 1.1rem;
            color: #ff6b6b;
        }

        .detail-label {
            color: #666;
            font-weight: 500;
        }

        .detail-value {
            color: #333;
            font-weight: 600;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-placed {
            background: #e3f2fd;
            color: #1976d2;
        }

        .status-preparing {
            background: #fff3e0;
            color: #f57c00;
        }

        .status-delivered {
            background: #e8f5e8;
            color: #388e3c;
        }

        .status-cancelled {
            background: #ffebee;
            color: #d32f2f;
        }

        .payment-method {
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .no-orders {
            text-align: center;
            background: white;
            padding: 60px 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin: 40px auto;
            max-width: 500px;
        }

        .no-orders-icon {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.5;
        }

        .no-orders h3 {
            font-size: 1.8rem;
            color: #333;
            margin-bottom: 15px;
        }

        .no-orders p {
            color: #666;
            font-size: 1.1rem;
            line-height: 1.6;
            margin-bottom: 25px;
        }

        .browse-btn {
            background: linear-gradient(45deg, #ff6b6b, #ffa500);
            color: white;
            padding: 12px 25px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .browse-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255, 107, 107, 0.3);
            color: white;
            text-decoration: none;
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 2rem;
            }

            .top-nav {
                position: relative;
                top: auto;
                right: auto;
                margin-bottom: 20px;
                justify-content: center;
                flex-wrap: wrap;
                gap: 10px;
            }

            .user-welcome {
                position: relative;
                top: auto;
                left: auto;
                margin-bottom: 20px;
                text-align: center;
            }

            .order-header {
                flex-direction: column;
                text-align: center;
            }

            .detail-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 5px;
            }

            body {
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- User Welcome (Top Left) -->
        <% if (user != null) { %>
            <div class="user-welcome">
                Welcome, <%= user.getName() %>!
            </div>
        <% } %>

        <!-- Top Navigation (Top Right) -->
        <div class="top-nav">
            <% if (user != null) { %>
                <a href="CartServlet" class="nav-btn cart">
                    🛒 Cart
                </a>
                <form action="LogoutServlet" method="post" class="logout-form">
                    <button type="submit" class="nav-btn">
                        🚪 Logout
                    </button>
                </form>
            <% } %>
        </div>

        <!-- Header Section -->
        <div class="header">
            <h1>📋 Order History</h1>
            <p>Track all your delicious food orders</p>
        </div>

        <!-- Back Button -->
        <a href="GetAllRestaurantServlet" class="back-btn">
            ← Back to Restaurants
        </a>

        <!-- Orders Container -->
        <div class="orders-container">
            <%
                if (ordersList != null && !ordersList.isEmpty()) {
                    for (Orders order : ordersList) {
                        String statusClass = "status-" + order.getStatus().toLowerCase().replace(" ", "-");
            %>
                <div class="order-card">
                    <div class="order-header">
                        <div>
                        	
                            <div class="order-id">Order #<%= order.getOrderId() %></div>
                            <div class="order-date"><%= order.getOrderDate() %></div>
                        </div>
                        <div class="status-badge <%= statusClass %>">
                            <%= order.getStatus() %>
                        </div>
                    </div>
                    
                    <div class="order-details">
                        <div class="detail-row">
                            <span class="detail-label">Restaurant ID:</span>
                            <span class="detail-value">#<%= order.getRestaurantId() %></span>
                        </div>
                        
                        <div class="detail-row">
                            <span class="detail-label">Payment Method:</span>
                            <span class="detail-value payment-method">
                                <% 
                                    String paymentIcon = "💳";
                                    String paymentMethod = order.getPaymentMode();
                                    if ("cod".equalsIgnoreCase(paymentMethod) || "cash".equalsIgnoreCase(paymentMethod)) {
                                        paymentIcon = "💵";
                                        paymentMethod = "Cash on Delivery";
                                    } else if ("upi".equalsIgnoreCase(paymentMethod)) {
                                        paymentIcon = "📱";
                                        paymentMethod = "UPI Payment";
                                    } else if ("wallet".equalsIgnoreCase(paymentMethod)) {
                                        paymentIcon = "👛";
                                        paymentMethod = "Digital Wallet";
                                    } else if ("card".equalsIgnoreCase(paymentMethod)) {
                                        paymentIcon = "💳";
                                        paymentMethod = "Credit/Debit Card";
                                    }
                                %>
                                <%= paymentIcon %> <%= paymentMethod %>
                            </span>
                        </div>
                        
                        <div class="detail-row">
                            <span class="detail-label">Delivery Address:</span>
                            <span class="detail-value"><%= order.getAddress() %></span>
                        </div>
                        
                        <div class="detail-row">
                            <span class="detail-label">Total Amount:</span>
                            <span class="detail-value">₹<%= String.format("%.2f", order.getTotalAmount()) %></span>
                        </div>
                    </div>
                </div>
            <%
                    }
                } else {
            %>
                <div class="no-orders">
                    <div class="no-orders-icon">📦</div>
                    <h3>No Orders Yet</h3>
                    <p>You haven't placed any orders yet. Start exploring our amazing restaurants and place your first order!</p>
                    <a href="GetAllRestaurantServlet" class="browse-btn">Browse Restaurants</a>
                </div>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>