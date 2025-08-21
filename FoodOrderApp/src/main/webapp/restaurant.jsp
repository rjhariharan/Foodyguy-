<%@ page import="java.util.List" %>
<%@ page import="com.tap.models.Restaurant" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Foodyguy - Restaurants</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(-45deg, #3b0a45, #5a2a80, #d4af37, #b8860b);

            min-height: 100vh;
            padding: 20px;
            background-size: 400% 400%;
            animation: yellowShift 12s ease infinite;
        }
        @keyframes yellowShift {
            0%   { background-position: 0% 50%; }
            50%  { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .header {
            text-align: center;
            margin-bottom: 40px;
            color: white;
            position: relative;
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
    .nav-btn.cart { background: linear-gradient(45deg, #1e88e5, #42a5f5); border-color: transparent; }
.nav-btn.cart:hover { background: linear-gradient(45deg, #1565c0, #2196f3); transform: translateY(-2px) scale(1.05); }
   .nav-btn.orders { background: linear-gradient(45deg, #9c27b0, #673ab7); border-color: transparent; }
        .nav-btn.orders:hover { background: linear-gradient(45deg, #8e24aa, #5e35b1); transform: translateY(-2px) scale(1.05); }
        .nav-btn.login { background: linear-gradient(45deg, #4CAF50, #45a049); border-color: transparent; }
        .nav-btn.login:hover { background: linear-gradient(45deg, #45a049, #3d8b40); }
        .nav-btn.signup { background: linear-gradient(45deg, #2196F3, #1976D2); border-color: transparent; }
        .nav-btn.signup:hover { background: linear-gradient(45deg, #1976D2, #1565C0); }
        .logout-form { display: inline-block; }
        .logout-form .nav-btn { background: linear-gradient(45deg, #f44336, #d32f2f); border: none; }
        .logout-form .nav-btn:hover { background: linear-gradient(45deg, #d32f2f, #c62828); }

        .container { max-width: 1200px; margin: 0 auto; }

        .search-container { max-width: 600px; margin: 0 auto 24px auto; position: relative; }
        .search-box {
            width: 100%; padding: 15px 50px 15px 20px; border: none; border-radius: 25px; font-size: 1.1rem;
            background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(10px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1); transition: all 0.3s ease;
        }
        .search-box:focus {
            outline: none; background: white; box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15); transform: translateY(-2px);
        }
        .search-btn {
            position: absolute; right: 5px; top: 50%; transform: translateY(-50%);
            background: linear-gradient(45deg, #ff6b6b, #ffa500); border: none; border-radius: 50%;
            width: 40px; height: 40px; cursor: pointer; display: flex; align-items: center; justify-content: center;
            color: white; font-size: 1.2rem; transition: all 0.3s ease;
        }
        .search-btn:hover { transform: translateY(-50%) scale(1.1); box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4); }

        .restaurant-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 30px;
            margin-top: 20px;
        }
        .restaurant-card-link { text-decoration: none; color: inherit; display: block; transition: transform 0.3s ease; }
        .restaurant-card-link:hover { transform: translateY(-8px); }

        .restaurant-card {
            background: white; border-radius: 20px; overflow: hidden; box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            transition: all 0.3s ease; position: relative;
        }
        .restaurant-card:hover { box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2); }
        .restaurant-card::before {
            content: ''; position: absolute; top: 0; left: 0; right: 0; height: 4px;
            background: linear-gradient(45deg, #ff6b6b, #ffa500);
        }
        .restaurant-card img { width: 100%; height: 200px; object-fit: cover; transition: transform 0.3s ease; }
        .restaurant-card:hover img { transform: scale(1.05); }

        .restaurant-details { padding: 25px; }
        .restaurant-details h3 { font-size: 1.5rem; color: #333; margin-bottom: 15px; font-weight: 700; }
        .detail-item { display: flex; align-items: center; margin-bottom: 12px; font-size: 0.95rem; color: #666; }
        .detail-icon {
            width: 20px; height: 20px; margin-right: 12px; display: flex; align-items: center; justify-content: center;
            background: #f8f9fa; border-radius: 50%; font-size: 0.8rem;
        }
        .detail-label { font-weight: 600; color: #555; margin-right: 8px; min-width: 60px; }
        .rating { color: #ff9800; font-weight: bold; display: flex; align-items: center; }
        .rating::before { content: '⭐'; margin-right: 5px; }
        .cuisine-type {
            background: linear-gradient(45deg, #ff6b6b, #ffa500); color: white; padding: 6px 12px; border-radius: 20px;
            font-size: 0.85rem; font-weight: 600; display: inline-block; margin-top: 10px;
        }

        .no-restaurants {
            text-align: center; background: white; padding: 60px 40px; border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1); margin: 40px auto; max-width: 500px;
        }
        .no-restaurants-icon { font-size: 4rem; margin-bottom: 20px; opacity: 0.5; }
        .no-restaurants h3 { font-size: 1.8rem; color: #333; margin-bottom: 15px; }
        .no-restaurants p { color: #666; font-size: 1.1rem; line-height: 1.6; }

        @media (max-width: 768px) {
            .restaurant-container { grid-template-columns: 1fr; gap: 20px; }
            .restaurant-card { margin: 0 10px; }
            .top-nav { position: relative; top: auto; right: auto; margin-bottom: 20px; justify-content: center; flex-wrap: wrap; gap: 10px; }
            .user-welcome { position: relative; top: auto; left: auto; margin-bottom: 20px; text-align: center; }
            .nav-btn { padding: 8px 16px; font-size: 0.85rem; }
            body { padding: 10px; }
        }

        .user-welcome {
            position: fixed; top: 20px; left: 20px; z-index: 1000; color: white; font-weight: 600;
            background: rgba(255, 255, 255, 0.1); padding: 8px 15px; border-radius: 20px; backdrop-filter: blur(10px);
        }

        .loading-animation { display: inline-block; animation: spin 1s linear infinite; }
        @keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }

        /* ===== NEW: Compact horizontal hero row (logo left, text right) ===== */
        .hero-row {
            max-width: 1000px;
            margin: 0 auto 18px auto;
            display: flex;
            align-items: center;
            gap: 16px;
            padding: 10px 12px;
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 14px;
            backdrop-filter: blur(6px);
        }
        .hero-logo {
            width: 72px;
            height: 72px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #1cb44e;
            flex: 0 0 auto;
        }
        .hero-text {
            flex: 1 1 auto;
            text-align: left;
            min-width: 0;
        }
        .hero-title {
            margin: 0 0 6px 0;
            font-size: 1.8rem;
            line-height: 1.2;
            font-weight: 800;
            color: #ffffff;
            text-shadow: 0 1px 2px rgba(0,0,0,.25);
        }
        .hero-sub {
            margin: 0;
            font-size: 1rem;
            opacity: 0.9;
            color: #ffffff;
        }
        @media (max-width: 768px) {
            .hero-row { gap: 12px; padding: 10px; }
            .hero-logo { width: 60px; height: 60px; }
            .hero-title { font-size: 1.5rem; }
            .hero-sub { font-size: 0.95rem; }
        }

        /* ===== Optional: “No results” for search ===== */
        .no-results {
            text-align: center;
            background: white;
            padding: 40px 30px;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(255, 140, 0, 0.25);
            max-width: 560px;
            margin: 20px auto 0;
            display: none;
        }
        .no-results-icon { font-size: 3rem; margin-bottom: 10px; opacity: 0.6; }
    </style>
</head>
<body>
    <!-- Main Content -->
    <div class="container">
        <!-- Header -->
        <div class="header">
            <% if (session.getAttribute("user") != null) { %>
                <div class="user-welcome">
                    Welcome, <%= ((com.tap.models.User)session.getAttribute("user")).getName() %>!
                </div>
            <% } %>

            <div class="top-nav">
                <% if (session.getAttribute("user") != null) { %>
                    <a href="CartServlet" class="nav-btn cart">🛒 Cart</a>
                    <a href="OrderHistoryServlet" class="nav-btn orders">📋 Orders</a>
                    <form action="LogoutServlet" method="post" class="logout-form">
                        <button type="submit" class="nav-btn">🚪 Logout</button>
                    </form>
                <% } else { %>
                    <a href="login.jsp" class="nav-btn login">🔑 Login</a>
                    <a href="register.jsp" class="nav-btn signup">📝 Sign Up</a>
                <% } %>
            </div>

            <!-- New compact horizontal hero row -->
            <div class="hero-row">
                <img class="hero-logo" src="images/foodyguylogo.png" alt="Foodyguy logo">
                <div class="hero-text">
                    <h1 class="hero-title">Foodyguy</h1>
                    <p class="hero-sub">Discover amazing restaurants and delicious food near you</p>
                </div>
            </div>
        </div>

        <!-- Search -->
        <div class="search-container">
            <input type="text" class="search-box" id="searchInput" placeholder="Search restaurants by name, cuisine, or location...">
            <button class="search-btn" onclick="searchRestaurants()">🔍</button>
        </div>

        <!-- Restaurants Grid -->
        <div class="restaurant-container" id="restaurantContainer">
            <%
                if (restaurants != null && !restaurants.isEmpty()) {
                    for (Restaurant r : restaurants) {
            %>
                <a class="restaurant-card-link restaurant-item" 
                   href="<%= request.getContextPath() %>/menu?restaurantId=<%= r.getRestaurantId() %>"
                   data-name="<%= r.getName().toLowerCase() %>"
                   data-cuisine="<%= r.getCuisineType().toLowerCase() %>"
                   data-address="<%= r.getAddress().toLowerCase() %>">
                    <div class="restaurant-card">
                        <img src="<%= (r.getImagePath()!=null && r.getImagePath().startsWith("http")) ? r.getImagePath() : request.getContextPath()+"/images/"+r.getImagePath().replace(" ", "%20") %>" 
                             alt="<%= r.getName() %>" 
                             onerror="this.src='https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg?auto=compress&cs=tinysrgb&w=400'">
                        <div class="restaurant-details">
                            <h3><%= r.getName() %></h3>
                            <div class="detail-item">
                                <div class="detail-icon">📍</div>
                                <span class="detail-label">Address:</span>
                                <span><%= r.getAddress() %></span>
                            </div>
                            <div class="detail-item">
                                <div class="detail-icon">📞</div>
                                <span class="detail-label">Phone:</span>
                                <span><%= r.getPhone() %></span>
                            </div>
                            <div class="detail-item">
                                <div class="detail-icon">⭐</div>
                                <span class="detail-label">Rating:</span>
                                <span class="rating"><%= r.getRating() %></span>
                            </div>
                            <div class="cuisine-type"><%= r.getCuisineType() %></div>
                        </div>
                    </div>
                </a>
            <%
                    }
                } else {
            %>
                <div class="no-restaurants">
                    <div class="no-restaurants-icon">🍽️</div>
                    <h3>No Restaurants Found</h3>
                    <p>We're working hard to bring more amazing restaurants to your area. Please check back soon!</p>
                </div>
            <%
                }
            %>
        </div>

        <!-- Optional “no results” for search -->
        <div class="no-results" id="noResults">
            <div class="no-results-icon">🔍</div>
            <h3>No Restaurants Found</h3>
            <p>We couldn't find any restaurants matching your search. Try different keywords or browse all restaurants.</p>
        </div>
    </div>

    <script>
        function searchRestaurants() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase().trim();
            const restaurants = document.querySelectorAll('.restaurant-item');
            const noResults = document.getElementById('noResults');
            let visibleCount = 0;

            restaurants.forEach(restaurant => {
                const name = restaurant.getAttribute('data-name') || '';
                const cuisine = restaurant.getAttribute('data-cuisine') || '';
                const address = restaurant.getAttribute('data-address') || '';

                if (
                    searchTerm === '' ||
                    name.includes(searchTerm) ||
                    cuisine.includes(searchTerm) ||
                    address.includes(searchTerm)
                ) {
                    restaurant.style.display = 'block';
                    visibleCount++;
                } else {
                    restaurant.style.display = 'none';
                }
            });

            // Toggle "no results" message
            if (searchTerm !== '' && visibleCount === 0) {
                noResults.style.display = 'block';
            } else {
                noResults.style.display = 'none';
            }
        }

        // Search on Enter key press
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                searchRestaurants();
            }
        });

        // Real-time search as user types
        document.getElementById('searchInput').addEventListener('input', searchRestaurants);

    </script>
</body>
</html>
