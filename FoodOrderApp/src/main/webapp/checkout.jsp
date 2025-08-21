<%@ page import="com.tap.models.Cart" %>
<%@ page import="com.tap.models.CartItem" %>
<%@ page import="com.tap.models.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Cart cart = (Cart) request.getAttribute("cart");
    User user = (User) request.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Foodyguy</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(-45deg, #001f29, #003344, #005f73, #000000);

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

        .checkout-container {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: 1fr 400px;
            gap: 30px;
        }

        .checkout-section {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .section-header {
            background:linear-gradient(135deg, #3a1c1a, #ba181b);

            color: white;
            padding: 25px 30px;
            font-size: 1.5rem;
            font-weight: 700;
        }

        .section-content {
            padding: 30px;
        }

        /* Delivery Address Section */
        .address-info {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            border-left: 4px solid #ff6b6b;
        }

        .address-info h4 {
            color: #333;
            margin-bottom: 10px;
            font-size: 1.1rem;
        }

        .address-details {
            color: #666;
            line-height: 1.6;
        }

        .address-details p {
            margin-bottom: 5px;
        }

        /* Payment Methods */
        .payment-methods {
            display: grid;
            gap: 15px;
        }

        .payment-option {
            border: 2px solid #e1e5e9;
            border-radius: 12px;
            padding: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
        }

        .payment-option:hover {
            border-color: #ff6b6b;
            background: #fff5f5;
        }

        .payment-option.selected {
            border-color: #ff6b6b;
            background: #fff5f5;
        }

        .payment-option input[type="radio"] {
            position: absolute;
            opacity: 0;
        }

        .payment-header {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .payment-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #ff6b6b, #ffa500);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 1.2rem;
            color: white;
        }

        .payment-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #333;
        }

        .payment-description {
            color: #666;
            font-size: 0.9rem;
            margin-left: 55px;
        }

        /* Order Summary */
        .order-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #e9ecef;
        }

        .item-details h4 {
            color: #333;
            margin-bottom: 5px;
        }

        .item-meta {
            color: #666;
            font-size: 0.9rem;
        }

        .item-price {
            font-weight: 600;
            color: #ff6b6b;
        }

        .order-total {
            background: #f8f9fa;
            padding: 20px;
            margin: 20px -30px -30px -30px;
            border-top: 2px solid #e9ecef;
        }

        .total-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .total-row.final {
            font-size: 1.2rem;
            font-weight: 700;
            color: #ff6b6b;
            border-top: 2px solid #e9ecef;
            padding-top: 15px;
            margin-top: 15px;
        }

        /* Place Order Button */
        .place-order-btn {
            width: 100%;
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            border: none;
            padding: 18px;
            border-radius: 12px;
            font-size: 1.2rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 25px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .place-order-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(40, 167, 69, 0.3);
        }

        .place-order-btn:disabled {
            background: #6c757d;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        /* Back to Cart */
        .back-to-cart {
            display: inline-flex;
            align-items: center;
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            margin-bottom: 20px;
            transition: color 0.3s ease;
        }

        .back-to-cart:hover {
            color: #5a67d8;
        }

        .back-to-cart::before {
            content: '←';
            margin-right: 8px;
            font-size: 1.2rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .checkout-container {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .section-content {
                padding: 20px;
            }

            .payment-option {
                padding: 15px;
            }

            .order-total {
                margin: 20px -20px -20px -20px;
            }
        }

        /* Loading Animation */
        .loading {
            display: none;
            text-align: center;
            padding: 20px;
        }

        .loading.show {
            display: block;
        }

        .spinner {
            border: 3px solid #f3f3f3;
            border-top: 3px solid #ff6b6b;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            animation: spin 1s linear infinite;
            margin: 0 auto 10px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="checkout-container">
        <!-- Main Checkout Section -->
        <div class="checkout-section">
            <div class="section-header">
                🛒 Checkout
            </div>
            <div class="section-content">
                <a href="CartServlet" class="back-to-cart">Back to Cart</a>
                
                <!-- Delivery Address -->
                <div class="address-info">
                    <h4>📍 Delivery Address</h4>
                    <div class="address-details">
                        <p><strong><%= user.getName() %></strong></p>
                        <p><%= user.getAddress() %></p>
                        <p>📞 <%= user.getPhone() %></p>
                        <p>✉️ <%= user.getEmail() %></p>
                    </div>
                </div>

                <!-- Payment Methods -->
                <h3 style="margin-bottom: 20px; color: #333;">💳 Choose Payment Method</h3>
                
                <form id="checkoutForm" action="CheckoutServlet" method="post">
                    <div class="payment-methods">
                        <label class="payment-option" for="cod">
                            <input type="radio" id="cod" name="paymentMethod" value="cod" checked>
                            <div class="payment-header">
                                <div class="payment-icon">💵</div>
                                <div class="payment-title">Cash on Delivery</div>
                            </div>
                            <div class="payment-description">
                                Pay with cash when your order arrives. No advance payment required.
                            </div>
                        </label>

                        <label class="payment-option" for="card">
                            <input type="radio" id="card" name="paymentMethod" value="card">
                            <div class="payment-header">
                                <div class="payment-icon">💳</div>
                                <div class="payment-title">Credit/Debit Card</div>
                            </div>
                            <div class="payment-description">
                                Pay securely with your credit or debit card. All major cards accepted.
                            </div>
                        </label>

                        <label class="payment-option" for="upi">
                            <input type="radio" id="upi" name="paymentMethod" value="upi">
                            <div class="payment-header">
                                <div class="payment-icon">📱</div>
                                <div class="payment-title">UPI Payment</div>
                            </div>
                            <div class="payment-description">
                                Pay instantly using UPI apps like PhonePe, Google Pay, Paytm, etc.
                            </div>
                        </label>

                        <label class="payment-option" for="wallet">
                            <input type="radio" id="wallet" name="paymentMethod" value="wallet">
                            <div class="payment-header">
                                <div class="payment-icon">👛</div>
                                <div class="payment-title">Digital Wallet</div>
                            </div>
                            <div class="payment-description">
                                Pay using your digital wallet balance. Quick and secure.
                            </div>
                        </label>
                    </div>

                    <button type="submit" class="place-order-btn" id="placeOrderBtn">
                        Place Order
                    </button>
                </form>

                <div class="loading" id="loadingDiv">
                    <div class="spinner"></div>
                    <p>Processing your order...</p>
                </div>
            </div>
        </div>

        <!-- Order Summary Section -->
        <div class="checkout-section">
            <div class="section-header">
                📋 Order Summary
            </div>
            <div class="section-content">
                <%
                if (cart != null && !cart.getItems().isEmpty()) {
                    for (CartItem item : cart.getItems().values()) {
                %>
                <div class="order-item">
                    <div class="item-details">
                        <h4><%= item.getName() %></h4>
                        <div class="item-meta">
                            Qty: <%= item.getQuantity() %> × ₹<%= String.format("%.2f", item.getPrice()) %>
                        </div>
                    </div>
                    <div class="item-price">
                        ₹<%= String.format("%.2f", item.getPrice() * item.getQuantity()) %>
                    </div>
                </div>
                <%
                    }
                %>
                
                <div class="order-total">
                    <div class="total-row">
                        <span>Subtotal:</span>
                        <span>₹<%= String.format("%.2f", cart.getTotal()) %></span>
                    </div>
                    <div class="total-row">
                        <span>Delivery Fee:</span>
                        <span>₹30.00</span>
                    </div>
                    <div class="total-row">
                        <span>Taxes & Fees:</span>
                        <span>₹<%= String.format("%.2f", cart.getTotal() * 0.05) %></span>
                    </div>
                    <div class="total-row final">
                        <span>Total Amount:</span>
                        <span>₹<%= String.format("%.2f", cart.getTotal() + 30 + (cart.getTotal() * 0.05)) %></span>
                    </div>
                </div>
                <%
                }
                %>
            </div>
        </div>
    </div>

    <script>
        // Payment method selection
        document.querySelectorAll('input[name="paymentMethod"]').forEach(radio => {
            radio.addEventListener('change', function() {
                document.querySelectorAll('.payment-option').forEach(option => {
                    option.classList.remove('selected');
                });
                this.closest('.payment-option').classList.add('selected');
            });
        });

        // Set initial selection
        document.querySelector('.payment-option').classList.add('selected');

        // Form submission with loading
        document.getElementById('checkoutForm').addEventListener('submit', function(e) {
            const btn = document.getElementById('placeOrderBtn');
            const loading = document.getElementById('loadingDiv');
            
            btn.disabled = true;
            btn.textContent = 'Processing...';
            loading.classList.add('show');
        });

        // Prevent double submission
        let isSubmitting = false;
        document.getElementById('checkoutForm').addEventListener('submit', function(e) {
            if (isSubmitting) {
                e.preventDefault();
                return false;
            }
            isSubmitting = true;
        });
    </script>
</body>
</html>