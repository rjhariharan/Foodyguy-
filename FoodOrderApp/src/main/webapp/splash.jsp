<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Foodyguy - Loading...</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            overflow: hidden;
        }
        
        /* ===== SPLASH SCREEN STYLES ===== */
        .splash-screen {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(-45deg, #2d5016, #4a7c59, #ff8c00, #ffa500);
            background-size: 400% 400%;
            animation: gradientShift 4s ease infinite;
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 9999;
            overflow: hidden;
        }
        
        /* Animated delivery route background */
        .splash-screen::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: 
                radial-gradient(circle at 20% 30%, rgba(255, 140, 0, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 80% 70%, rgba(45, 80, 22, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 40% 80%, rgba(255, 165, 0, 0.08) 0%, transparent 50%);
            animation: backgroundFloat 6s ease-in-out infinite;
        }
        
        @keyframes backgroundFloat {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            33% { transform: translateY(-10px) rotate(1deg); }
            66% { transform: translateY(5px) rotate(-1deg); }
        }
        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        
        .splash-content {
            text-align: center;
            color: white;
            animation: fadeInUp 1.2s ease-out;
            position: relative;
            z-index: 2;
        }
        
        .splash-logo-container {
            position: relative;
            margin-bottom: 40px;
            display: inline-block;
        }
        
        /* Multiple glow layers for more depth */
        .splash-logo-glow {
            position: absolute;
            inset: -20px;
            background: radial-gradient(circle, rgba(255, 140, 0, 0.4) 0%, rgba(45, 80, 22, 0.2) 50%, transparent 70%);
            border-radius: 20px;
            filter: blur(25px);
            animation: logoGlow 3s ease-in-out infinite;
        }
        
        .splash-logo-glow::before {
            content: '';
            position: absolute;
            inset: 10px;
            background: radial-gradient(circle, rgba(255, 165, 0, 0.6) 0%, transparent 60%);
            border-radius: 15px;
            filter: blur(15px);
            animation: logoGlow 2s ease-in-out infinite reverse;
        }
        
        .splash-logo-wrapper {
            position: relative;
            background: linear-gradient(145deg, #ffffff, #f8f9fa);
            border-radius: 20px;
            padding: 25px;
            box-shadow: 
                0 25px 50px rgba(0, 0, 0, 0.3),
                0 10px 20px rgba(45, 80, 22, 0.2),
                inset 0 1px 0 rgba(255, 255, 255, 0.8);
            animation: logoFloat 4s ease-in-out infinite;
            border: 3px solid rgba(255, 140, 0, 0.3);
            transform-style: preserve-3d;
        }
        
        .splash-logo {
            width: 140px;
            height: 140px;
            object-fit: contain;
            border-radius: 12px;
            filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.1));
        }
        
        .splash-fallback-icon {
            width: 140px;
            height: 140px;
            color: #2d5016;
            display: none;
            font-size: 80px;
            line-height: 140px;
        }
        
        .splash-title {
            font-size: 4.5rem;
            font-weight: 900;
            margin-bottom: 20px;
            background: linear-gradient(45deg, #ffffff, #ff8c00, #ffffff);
            background-size: 200% 200%;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-shadow: 0 6px 12px rgba(0, 0, 0, 0.4);
            animation: titleShine 2s ease-in-out infinite, slideInLeft 1.2s ease-out 0.6s both;
            letter-spacing: -2px;
        }
        
        .splash-subtitle {
            font-size: 1.6rem;
            font-weight: 300;
            opacity: 0.95;
            animation: slideInRight 1.2s ease-out 1s both;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
            margin-bottom: 10px;
        }
        
        .splash-loading {
            margin-top: 50px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 60px;
            animation: fadeIn 1.2s ease-out 1.4s both;
            position: relative;
            overflow: hidden;
        }
        
        .scooter-container {
            position: relative;
            width: 100%;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .animated-scooter {
            font-size: 2.5rem;
            animation: scooterMove 2s ease-in-out infinite;
            filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.3));
        }
        
        .delivery-trail {
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 2px;
            background: linear-gradient(90deg, 
                transparent 0%, 
                rgba(255, 140, 0, 0.3) 20%, 
                rgba(255, 140, 0, 0.6) 50%, 
                rgba(255, 140, 0, 0.3) 80%, 
                transparent 100%);
            animation: trailPulse 2s ease-in-out infinite;
        }
        
        .loading-text {
            margin-top: 15px;
            color: rgba(255, 255, 255, 0.9);
            font-size: 0.9rem;
            font-weight: 500;
            animation: textPulse 1.5s ease-in-out infinite;
        }
        
        /* Enhanced animations */
        @keyframes logoGlow {
            0%, 100% { opacity: 0.4; transform: scale(1); }
            50% { opacity: 0.8; transform: scale(1.05); }
        }
        
        @keyframes logoFloat {
            0%, 100% { transform: translateY(0px) rotateX(0deg) rotateY(0deg); }
            25% { transform: translateY(-8px) rotateX(2deg) rotateY(-1deg); }
            50% { transform: translateY(-12px) rotateX(0deg) rotateY(2deg); }
            75% { transform: translateY(-6px) rotateX(-1deg) rotateY(-1deg); }
        }
        
        @keyframes titleShine {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }
        
        @keyframes scooterMove {
            0% { 
                transform: translateX(-60px) scale(1); 
                opacity: 0.7; 
            }
            25% { 
                transform: translateX(-20px) scale(1.1) rotate(-2deg); 
                opacity: 1; 
            }
            50% { 
                transform: translateX(0px) scale(1.2) rotate(0deg); 
                opacity: 1; 
            }
            75% { 
                transform: translateX(20px) scale(1.1) rotate(2deg); 
                opacity: 1; 
            }
            100% { 
                transform: translateX(60px) scale(1); 
                opacity: 0.7; 
            }
        }
        
        @keyframes trailPulse {
            0%, 100% { 
                opacity: 0.3; 
                transform: scaleX(0.8); 
            }
            50% { 
                opacity: 0.8; 
                transform: scaleX(1.2); 
            }
        }
        
        @keyframes textPulse {
            0%, 100% { opacity: 0.7; }
            50% { opacity: 1; }
        }
        
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(40px) scale(0.9); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        @keyframes slideInLeft {
            from { opacity: 0; transform: translateX(-60px) scale(0.8); }
            to { opacity: 1; transform: translateX(0); }
        }
        
        @keyframes slideInRight {
            from { opacity: 0; transform: translateX(60px) scale(0.8); }
            to { opacity: 1; transform: translateX(0); }
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; }
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .splash-title { font-size: 3rem; letter-spacing: -1px; }
            .splash-subtitle { font-size: 1.3rem; }
            .splash-logo, .splash-fallback-icon { width: 120px; height: 120px; }
            .splash-logo-wrapper { padding: 20px; }
            .splash-fallback-icon { font-size: 60px; line-height: 120px; }
        }
    </style>
</head>
<body>
    <!-- Splash Screen -->
    <div class="splash-screen" id="splashScreen">
        <div class="splash-content">
            <div class="splash-logo-container">
                <div class="splash-logo-glow"></div>
                <div class="splash-logo-wrapper">
                    <img class="splash-logo" 
                         src="images/foodyguylogo.png" 
                         alt="Foodyguy Logo"
                         onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">
                    <div class="splash-fallback-icon">🛵</div>
                </div>
            </div>
            <h1 class="splash-title">Foodyguy</h1>
            <p class="splash-subtitle">Delicious Food, Delivered Fresh</p>
            <div class="splash-loading">
                <div class="scooter-container">
                    <div class="delivery-trail"></div>
                    <div class="animated-scooter">&#128640</div>
                </div>
                <div class="loading-text">Preparing your delivery...</div>
            </div>
        </div>
    </div>

    <script>
        // Splash Screen Logic - Redirect after 3 seconds
        window.addEventListener('load', function() {
            setTimeout(function() {
                // Redirect to the restaurant page
                window.location.href = 'GetAllRestaurantServlet';
            }, 3000);
        });
    </script>
</body>
</html>