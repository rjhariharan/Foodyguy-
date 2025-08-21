<%@ page import="com.tap.models.Cart" %>
<%@ page import="com.tap.models.CartItem" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Cart cart = (Cart) request.getAttribute("cart");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Cart - Foodyguy</title>
    <style>* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
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


.cart-container {
    max-width: 1000px;
    margin: 0 auto;
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 20px;
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
    overflow: hidden;
}

.cart-header {
    background: linear-gradient(135deg, #232526, #414345);
    color: white;
    padding: 30px;
    text-align: center;
}
.cart-header h2 {
    font-size: 2.2rem;
    font-weight: 700;
}
.cart-subtitle {
    font-size: 1.1rem;
    opacity: 0.9;
    margin-top: 10px;
}

table {
    width: 100%;
    border-collapse: collapse;
    background: white;
    font-size: 0.95rem;
}
th {
    background: linear-gradient(135deg, #f8f9fa, #e9ecef);
    color: #495057;
    font-weight: 600;
    padding: 20px 15px;
    text-align: center;
    border-bottom: 2px solid #ff6b6b;
    text-transform: uppercase;
}
td {
    padding: 20px 15px;
    border-bottom: 1px solid #e9ecef;
    vertical-align: middle;
    text-align: center;
   
}
tr:hover td {
    background-color: #f8f9fa;
}

.item-name {
    font-weight: 600;
    color: #2d3748;
}
.item-price {
    font-weight: 600;
    color: #e57373;   /* soft salmon red */

}

.quantity-controls {
    display: flex;
    align-items: center;
    gap: 8px;
    justify-content: center;
}
.qty-btn {
    width: 35px;
    height: 35px;
    background: white;
    color: #f44336;   /* vivid but not harsh red */
    border: 2px solid #f44336;
    border-radius: 50%;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
}
.qty-btn:hover:not(:disabled) {
    background: #ff6b6b;
    color: white;
    transform: scale(1.1);
}
.qty-btn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
}

.quantity-display {
    min-width: 40px;
    text-align: center;
    font-weight: 600;
}

.remove-btn {
    background: linear-gradient(135deg, #8e0e00, #b91313);
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 25px;
    cursor: pointer;
}
.remove-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(255, 71, 87, 0.4);
}

.total-row {
    background: linear-gradient(135deg, #f8f9fa, #e9ecef);
    font-weight: 700;
    font-size: 1.1rem;
}
.total-amount {
    color: #ff6b6b;
    font-size: 1.3rem;
    text-align: right;
}

.cart-actions {
    padding: 30px;
    background: #f8f9fa;
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
    gap: 20px;
}
.action-group {
    display: flex;
    gap: 15px;
    align-items: center;
}

.clear-cart-btn {
    background: linear-gradient(135deg, #6c757d, #495057);
    color: white;
    border: none;
    padding: 12px 25px;
    border-radius: 25px;
    cursor: pointer;
}
.place-order-btn {
    background: linear-gradient(135deg, #28a745, #20c997);
    color: white;
    border: none;
    padding: 15px 40px;
    border-radius: 30px;
    font-weight: 700;
    text-transform: uppercase;
}
.place-order-btn:hover {
    transform: translateY(-3px);
}

.add-more-link {
    color: #667eea;
    padding: 12px 25px;
    border: 2px solid #667eea;
    border-radius: 25px;
    text-decoration: none;
}
.add-more-link:hover {
    background: #667eea;
    color: white;
}

/* Empty cart styling */
.empty-cart {
    text-align: center;
    padding: 80px 30px;
    color: #6c757d;
}
.empty-cart h3 {
    font-size: 1.5rem;
    margin-bottom: 10px;
}
.empty-cart-icon {
    font-size: 4rem;
    margin-bottom: 20px;
    opacity: 0.3;
}

/* Responsive */
@media (max-width: 768px) {
    table { font-size: 0.85rem; }
    th, td { padding: 12px 8px; }
    .place-order-btn { width: 100%; }
}
    </style>
    <!-- ...existing styles here... (leave your table, color, button, etc. definitions) -->
</head>
<body>
    <div class="cart-container">
        <div class="cart-header">
            <h2>
                <!-- SVG Cart Icon -->
                <svg width="28" height="28" viewBox="0 0 24 24" fill="none"
                     stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="vertical-align:middle;">
                     <circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h5l2 13h11l3-9H6"/>
                </svg>
                Your Cart
            </h2>
            <div class="cart-subtitle">Review your delicious selections</div>
        </div>

        <%
        if (cart != null && !cart.getItems().isEmpty()) {
        %>
        <table>
            <tr>
                <th>S.No</th>
                <th>Item</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Subtotal</th>
                <th>Action</th>
            </tr>
            <%
            int sn = 1;
            for (CartItem item : cart.getItems().values()) {
            %>
            <tr>
                <td><%= sn++ %></td>
                <td class="item-name"><%= item.getName() %></td>
                <td class="item-price">&#8377;<%= String.format("%.2f", item.getPrice()) %></td>
                <td>
                    <form action="CartServlet" method="post" style="display:inline;">
                        <input type="hidden" name="menuId" value="<%= item.getMenuid() %>" />
                        <input type="hidden" name="restaurantId" value="<%= item.getRestaurantid() %>" />
                        <input type="hidden" name="action" value="update" />
                        <div class="quantity-controls">
                            <button type="submit" class="qty-btn" name="quantity" value="<%= item.getQuantity()-1 %>" <%= (item.getQuantity()<=1 ? "disabled" : "") %>>&nbsp;&#8722;&nbsp;</button>
                            <span class="quantity-display"><%= item.getQuantity() %></span>
                            <button type="submit" class="qty-btn" name="quantity" value="<%= item.getQuantity()+1 %>">&nbsp;&#43;&nbsp;</button>
                        </div>
                    </form>
                </td>
                <td class="item-price">&#8377;<%= String.format("%.2f", item.getPrice() * item.getQuantity()) %></td>
                <td>
                    <form action="CartServlet" method="post">
                        <input type="hidden" name="menuId" value="<%= item.getMenuid() %>" />
                        <input type="hidden" name="restaurantId" value="<%= item.getRestaurantid() %>" />
                        <input type="hidden" name="action" value="remove" />
                        <input type="submit" class="remove-btn" value="Remove" />
                    </form>
                </td>
            </tr>
            <% } %>
            <tr class="total-row">
                <td colspan="4" style="text-align:right; font-size:1.1rem;">Total Amount</td>
                <td style="font-size:1.2rem; text-align:right; color:#ff6b6b;">
                    &#8377;<%= String.format("%.2f", cart.getTotal()) %>
                </td>
                <td></td>
            </tr>
        </table>
        <div class="cart-actions">
            <div class="action-group">
                <form action="CartServlet" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="clear" />
                    <input type="submit" value="Clear Cart" class="clear-cart-btn" onclick="return confirm('Are you sure you want to clear all items from your cart?');" />
                </form>
                <%
                String restId = (String) session.getAttribute("restaurantId");
                if (restId != null) {
                %>
                <a href="menu?restaurantId=<%= restId %>" class="add-more-link">
                    <!-- SVG Plus Icon or simple text -->
                    &#43; Add More Items
                </a>
                <%
                }
                %>
            </div>
                       <div class="action-group">
                 <form action="CheckoutServlet" method="post" style="display:inline;">
                     <input type="hidden" name="action" value="placeOrder" />
                 <form action="CheckoutServlet" method="post" style="display:inline;">
                    <input type="submit" value="Checkout" class="place-order-btn" />
                </form>
            </div>
        </div>
        <%
        } else {
        %>
        <div class="empty-cart">
            <div class="empty-cart-icon">
                <!-- Use SVG or &#128722; (cart) -->
                <svg width="48" height="48" viewBox="0 0 24 24" fill="none"
                     stroke="#667eea" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                     <circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h5l2 13h11l3-9H6"/>
                </svg>
            </div>
            <h3>Your cart is empty</h3>
            <p>Looks like you haven't added any delicious items to your cart yet.</p>
            <%
            String restId = (String) session.getAttribute("restaurantId");
            if (restId != null) {
            %>
            <a href="menu?restaurantId=<%= restId %>" class="add-more-link">&#43; Browse Menu</a>
            <%
            } else {
            %>
            <a href="restaurants.jsp" class="add-more-link">&#43; Browse Restaurants</a>
            <%
            }
            %>
        </div>
        <%
        }
        %>
    </div>
</body>
</html>
