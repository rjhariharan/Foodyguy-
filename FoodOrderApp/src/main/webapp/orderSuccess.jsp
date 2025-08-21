<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Success</title>
<style>
    body {
        margin: 0;
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        background: linear-gradient(-45deg, #00b09b, #96c93d, #f7971e, #ffd200);
        background-size: 400% 400%;
        animation: gradientMove 10s ease infinite;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        overflow: hidden;
    }

    @keyframes gradientMove {
        0% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
        100% { background-position: 0% 50%; }
    }

    .success-container {
        text-align: center;
        background: rgba(255, 255, 255, 0.9);
        padding: 40px;
        border-radius: 20px;
        box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.15),
                    0px 0px 20px rgba(255, 215, 0, 0.4);
        animation: fadeInScale 1s ease forwards;
        position: relative;
        z-index: 2;
    }

    @keyframes fadeInScale {
        0% { transform: scale(0.8); opacity: 0; }
        100% { transform: scale(1); opacity: 1; }
    }

    .success-icon {
        font-size: 80px;
        color: #28a745;
        text-shadow: 0px 0px 10px rgba(40, 167, 69, 0.7);
        animation: pop 0.6s ease forwards;
    }

    @keyframes pop {
        0% { transform: scale(0.3); opacity: 0; }
        80% { transform: scale(1.2); opacity: 1; }
        100% { transform: scale(1); }
    }

    h1 {
        font-size: 32px;
        margin: 20px 0 10px;
        color: #333;
        animation: fadeIn 1.2s ease forwards;
    }

    p {
        font-size: 18px;
        color: #555;
        animation: fadeIn 1.5s ease forwards;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    /* Floating celebratory confetti circles */
    .confetti {
        position: absolute;
        width: 12px;
        height: 12px;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.8);
        animation: floatUp 8s linear infinite;
    }

    @keyframes floatUp {
        from { transform: translateY(100vh) scale(0.5); opacity: 1; }
        to { transform: translateY(-20vh) scale(1.2); opacity: 0; }
    }
</style>
</head>
<body>

    <!-- Floating confetti elements -->
    <div class="confetti" style="left: 10%; animation-delay: 0s;"></div>
    <div class="confetti" style="left: 30%; animation-delay: 2s;"></div>
    <div class="confetti" style="left: 50%; animation-delay: 4s;"></div>
    <div class="confetti" style="left: 70%; animation-delay: 1s;"></div>
    <div class="confetti" style="left: 90%; animation-delay: 3s;"></div>

    <div class="success-container">
        <div class="success-icon">✔</div>
        <h1>Order Successful!</h1>
        <p>Your delicious meal is on its way 🎉</p>
    </div>

</body>
</html>
