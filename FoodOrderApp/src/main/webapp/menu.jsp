<%@ page import="java.util.List" %>
<%@ page import="com.tap.models.Menu" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    List<Menu> menus = (List<Menu>) request.getAttribute("menus");
    Integer restaurantId = (Integer) request.getAttribute("restaurantId");
    String restaurantName = (String) request.getAttribute("restaurantName");
    String restaurantPhone= (String) request.getAttribute("restaurantPhone");
    String restaurantAddress = (String) request.getAttribute("restaurantAddress");
    if (restaurantName == null) restaurantName = "Restaurant";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= restaurantName %> - Menu</title>
    <style>
       /* Your existing orange-themed CSS here (unchanged from your previous working code) */
       /* ...for brevity, see your supplied CSS from earlier... */
       * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
background: linear-gradient(-45deg, #0f2027, #203a43, #2c5364, #000000);
															
    min-height: 100vh;
    padding: 20px;
    color: #333;
}

.container {
    max-width: 1400px;
    margin: 0 auto;
}

.header {
    text-align: center;
    margin-bottom: 40px;
    color: white;
    position: relative;
}

.back-link {
    position: fixed;
    top: 20px;
    left: 20px;
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(15px);
    padding: 10px 18px;
    border-radius: 30px;
    text-decoration: none;
    color: #333;
    font-weight: 600;
    transition: all 0.3s ease;
    border: 2px solid rgba(255, 255, 255, 0.8);
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    z-index: 1000;
}

.back-link:hover {
    background: white;
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
}

.cart-link {
    position: fixed;
    top: 30px;
    right: 30px;
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(15px);
    width: 60px;
    height: 60px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    text-decoration: none;
    font-size: 1.5rem;
    transition: all 0.3s ease;
    border: 2px solid rgba(255, 255, 255, 0.8);
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    z-index: 1000;
}

.cart-link:hover {
    background: white;
    transform: translateY(-3px) scale(1.05);
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
}

.menu-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 20px;
    margin-top: 20px;
}

.menu-card {
    background: white;
    border-radius: 25px;
    overflow: hidden;
    box-shadow: 0 8px 25px rgba(255, 165, 0, 0.25);
    transition: all 0.3s ease;
    position: relative;
    display: flex;
    flex-direction: column;
    border: 1px solid rgba(255, 255, 255, 0.8);
}

.menu-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 5px;
    background: linear-gradient(90deg, #fcb045, #fd1d1d, #ff8008);
}

.menu-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 15px 35px rgba(255, 140, 0, 0.4);
}

.menu-media img {
    width: 100%;
    height: 160px;
    object-fit: cover;
    transition: transform 0.3s ease;
}

.menu-card:hover img {
    transform: scale(1.05);
}

.menu-body {
    padding: 18px;
    flex: 1;
}

.item-name {
    font-size: 1.2rem;
    font-weight: 700;
    color: #333;
    margin-bottom: 8px;
}

.desc {
    font-size: 0.9rem;
    color: #666;
    line-height: 1.5;
    margin-bottom: 12px;
}

.meta-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
}

.price {
    font-size: 1.1rem;
    font-weight: 700;
    color: #ff5722;
}

.rating {
    background: linear-gradient(45deg, #ffd54f, #ff9800);
    color: white;
    padding: 6px 12px;
    border-radius: 25px;
    font-size: 0.85rem;
    font-weight: 600;
    display: flex;
    align-items: center;
}

.card-footer {
    padding: 18px;
    background: linear-gradient(135deg, #fff8f0 0%, #fff1e0 100%);
    border-top: none;
}

.qty-selector {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 9px;
}

.qty-btn {
    background: linear-gradient(135deg, #ffb75e, #ed8f03);
    border: none;
    border-radius: 50%;
    width: 30px;
    height: 30px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    color: white;
    box-shadow: 0 2px 8px rgba(255, 140, 0, 0.18);
    transition: all 0.2s;
    display: flex;
    align-items: center;
    justify-content: center;
    outline: none;
}

.qty-btn:hover {
    background: linear-gradient(135deg, #ffae42, #ff8008);
    transform: scale(1.07);
}

.qty-input {
    width: 26px;
    height: 26px;
    text-align: center;
    font-weight: 700;
    font-size: 14px;
    border: 2px solid #ffb75e;
    border-radius: 10px;
    background: #fff3e0;
    color: #ed8f03;
    box-shadow: 0 1.5px 6px rgba(255, 179, 94, 0.10);
    padding: 0;
}

.add-cart-btn {
    background: linear-gradient(135deg, #ff8008, #ffc837);
    border: none;
    color: white;
    padding: 14px 20px;
    border-radius: 25px;
    cursor: pointer;
    font-weight: 700;
    font-size: 0.9rem;
    width: 100%;
    margin-top: 12px;
    box-shadow: 0 4px 15px rgba(255, 165, 0, 0.3);
}

.add-cart-btn:hover {
    background: linear-gradient(45deg, #ff7f00, #ffb347);
    transform: translateY(-2px);
}

.no-menu {
    text-align: center;
    background: white;
    padding: 60px 40px;
    border-radius: 20px;
    box-shadow: 0 10px 30px rgba(255, 140, 0, 0.25);
}
.no-menu-icon {
    font-size: 4rem;
    margin-bottom: 20px;
    opacity: 0.5;
}

.search-container {
    max-width: 600px;
    margin: 0 auto 40px auto;
    position: relative;
}

.search-box {
    width: 100%;
    padding: 15px 50px 15px 20px;
    border: none;
    border-radius: 25px;
    font-size: 1.1rem;
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    box-shadow: 0 10px 30px rgba(255, 140, 0, 0.2);
    transition: all 0.3s ease;
    color: #333;
}

.search-box:focus {
    outline: none;
    background: white;
    box-shadow: 0 15px 40px rgba(255, 140, 0, 0.3);
    transform: translateY(-2px);
}

.search-box::placeholder {
    color: #999;
}

.search-btn {
    position: absolute;
    right: 5px;
    top: 50%;
    transform: translateY(-50%);
    background: linear-gradient(45deg, #ff8008, #ffc837);
    border: none;
    border-radius: 50%;
    width: 40px;
    height: 40px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 1.2rem;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(255, 140, 0, 0.3);
}

.search-btn:hover {
    transform: translateY(-50%) scale(1.1);
    box-shadow: 0 6px 20px rgba(255, 140, 0, 0.4);
    background: linear-gradient(45deg, #ff7f00, #ffb347);
}

.no-results {
    display: none;
    text-align: center;
    background: white;
    padding: 60px 40px;
    border-radius: 20px;
    box-shadow: 0 10px 30px rgba(255, 140, 0, 0.25);
    margin: 40px auto;
    max-width: 500px;
}

.no-results-icon {
    font-size: 4rem;
    margin-bottom: 20px;
    opacity: 0.5;
}

.no-results h3 {
    font-size: 1.8rem;
    color: #333;
    margin-bottom: 15px;
}

.no-results p {
    color: #666;
    font-size: 1.1rem;
    line-height: 1.6;
}
.food-icon {
            width: 200px;         
            height: 200px;        
            border-radius: 50%;   
            object-fit: cover;    
            border: 3px solid green;
        }
    </style>
</head>
<body>
    <div class="container">
     

        <!-- Navigation Links -->
        <a class="back-link" href="<%= request.getContextPath()%>/GetAllRestaurantServlet">← Back to Restaurants</a>
        <a class="cart-link" href="<%= request.getContextPath()%>/CartServlet" title="Go to Cart">🛒</a>

        <!-- Restaurant Info Section (new) -->
        <% if (restaurantAddress != null) { %>
        <div class="restaurant-info" style="background:white; border-radius:20px; padding:30px; margin-bottom:40px; box-shadow:0 10px 30px rgba(0,0,0,0.10); text-align:center;">
            <h2 style="color:#333; font-size:2rem; margin-bottom:15px;"><%= restaurantName %></h2>
            <div style="display:flex;justify-content:center;gap:30px;flex-wrap:wrap;margin-top:20px;">
                <div style="display:flex;align-items:center;color:#666;font-size:0.95rem;">
                    <span style="margin-right:8px;font-size:1.1rem;">📍</span>
                    <span><%= restaurantAddress %></span>
                </div>
                <div style="display:flex;align-items:center;color:#666;font-size:0.95rem;">
                    <span style="margin-right:8px;font-size:1.1rem;">📞</span>
                    <span><%= restaurantPhone %></span>
                </div>
            </div>
        </div>
        <% } %>

        <!-- Search Bar -->
        <div class="search-container">
            <input type="text" class="search-box" id="searchInput" placeholder="Search menu items by name or description...">
            <button class="search-btn" onclick="searchMenuItems()">🔍</button>
        </div>

        <!-- Menu Container -->
        <div class="menu-container">
            <%
            if (menus != null && !menus.isEmpty()) {
                for (Menu m : menus) {
                    String img = m.getImagePath();
                    String src = (img != null && img.toLowerCase().startsWith("http"))
                                 ? img
                                 : (request.getContextPath() + "/images/" + (img == null ? "placeholder.jpg" : img.replace(" ", "%20")));
            %>
            <div class="menu-card"
                data-name="<%= m.getItemName().toLowerCase() %>"
                data-description="<%= (m.getDescription() != null ? m.getDescription().toLowerCase() : "") %>">
                <div class="menu-media">
                    <img src="<%= src %>" alt="<%= m.getItemName() %>" 
                         onerror="this.src='https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?auto=compress&cs=tinysrgb&w=400'">
                </div>
                <div class="menu-body">
                    <div class="item-name"><%= m.getItemName() %></div>
                    <div class="desc"><%= m.getDescription() != null ? m.getDescription() : "Delicious food item prepared with care and quality ingredients." %></div>
                    <div class="meta-row">
                        <div class="price">₹ <%= String.format("%.2f", m.getPrice()) %></div>
                        <div class="rating"><%= String.format("%.1f", m.getRatings()) %></div>
                    </div>
                </div>
                <div class="card-footer">
                    <form method="post" action="<%= request.getContextPath() %>/CartServlet" class="cart-form">
                        <input type="hidden" name="menuId" value="<%= m.getMenuId() %>"/>
                        <input type="hidden" name="restaurantId" value="<%= restaurantId %>"/>
                        <input type="hidden" name="action" value="add"/>
                        <div class="qty-selector">
                            <button type="button" class="qty-btn" onclick="changeQty(this, -1)">&#8722;</button>
                            <input type="text" name="quantity" value="1" class="qty-input" readonly/>
                            <button type="button" class="qty-btn" onclick="changeQty(this, 1)">&#43;</button>
                        </div>
                        <button type="submit" class="add-cart-btn">
                            Add to Cart
                        </button>
                    </form>
                </div>
            </div>
            <%
                }
            } else {
            %>
            <div class="no-menu">
                <div><img class="food-icon" src="images/fglogo.png" alt="foodyguy logo"></div>
                <h3>No Menu Items Available</h3>
                <p>This restaurant is currently updating their menu. Please check back soon for delicious food options!</p>
            </div>
            <%
            }
            %>
        </div>

        <!-- No Results Message -->
        <div class="no-results" id="noResults">
            <div class="no-results-icon">🔍</div>
            <h3>No Menu Items Found</h3>
            <p>We couldn't find any menu items matching your search. Try different keywords or browse all items.</p>
        </div>
    </div>
    <script>
    // Search JS
    function searchMenuItems() {
        const searchTerm = document.getElementById('searchInput').value.toLowerCase();
        const menuCards = document.querySelectorAll('.menu-card');
        const noResults = document.getElementById('noResults');
        let visibleCount = 0;
        
        menuCards.forEach(card => {
            const name = card.getAttribute('data-name');
            const desc = card.getAttribute('data-description');
            if (name.includes(searchTerm) || desc.includes(searchTerm) || searchTerm === '') {
                card.style.display = 'block';
                visibleCount++;
            } else {
                card.style.display = 'none';
            }
        });

        // Show/hide no results message
        if (visibleCount === 0 && searchTerm !== '') {
            noResults.style.display = 'block';
        } else {
            noResults.style.display = 'none';
        }
    }
    

    // Search on Enter key press
    document.getElementById('searchInput').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
        	searchMenuItems();
        }
    });

    // Real-time search as user types
    document.getElementById('searchInput').addEventListener('input', searchMenuItems);
    
    
    // Quantity buttons JS
    function changeQty(btn, amount) {
        var input = btn.parentNode.querySelector('.qty-input');
        var value = parseInt(input.value, 10) || 1;
        value += amount;
        if (value < 1) value = 1;
        if (value > 10) value = 10; // Maximum quantity limit
        input.value = value;
    }
    </script>
</body>
</html>
