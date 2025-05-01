<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>TRON GRID MAP</title>
    <style>
        body {
            background-color: #0f0f0f;
            color: #00ffe4;
            font-family: 'Orbitron', sans-serif;
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
        
        #grid-map {
            width: 100vw;
            height: 100vh;
            position: relative;
            background: 
                linear-gradient(rgba(15, 15, 15, 0.9), rgba(15, 15, 15, 0.9)),
                url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"><rect x="0" y="0" width="100" height="100" fill="none" stroke="%2300ffe4" stroke-width="0.5"/></svg>');
            background-size: 50px 50px;
        }
        
        .location {
            position: absolute;
            width: 20px;
            height: 20px;
            background: #00ffe4;
            border-radius: 50%;
            box-shadow: 0 0 10px #00ffe4;
            transform: scale(0);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .location:hover {
            transform: scale(1.5);
            box-shadow: 0 0 20px #00ffe4;
            cursor: pointer;
        }
        .location::after {
            content: attr(data-name);
            position: absolute;
            top: 25px;
            left: 50%;
            transform: translateX(-50%);
            white-space: nowrap;
            font-size: 0.8em;
            opacity: 0;
            transition: opacity 0.3s;
        }
        .location:hover::after {
            opacity: 1;
        }
        
        #light-cycle {
            position: absolute;
            width: 30px;
            height: 30px;
            background: #00ffe4;
            clip-path: polygon(50% 0%, 100% 50%, 50% 100%, 0% 50%);
            animation: pulse 2s infinite;
            z-index: 10;
        }
        @keyframes pulse {
            0% { opacity: 0.7; }
            50% { opacity: 1; }
            100% { opacity: 0.7; }
        }
        
        #map-title {
            position: fixed;
            top: 20px;
            left: 20px;
            font-size: 1.5em;
            text-shadow: 0 0 10px #00ffe4;
        }
        
        #back-btn {
            position: fixed;
            bottom: 20px;
            right: 20px;
            padding: 10px 20px;
            background: transparent;
            color: #00ffe4;
            border: 1px solid #00ffe4;
            font-family: 'Orbitron';
            cursor: pointer;
        }
        #back-btn:hover {
            background: rgba(0, 255, 228, 0.1);
            box-shadow: 0 0 10px #00ffe4;
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>
    <div id="grid-map">
        <div id="map-title">TRON GRID NAVIGATION SYSTEM</div>
        
        <!-- Key Locations -->
        <div class="location" data-name="LIGHT CYCLE GARAGE" style="top:30%; left:20%;"></div>
        <div class="location" data-name="IDENTITY DISC ARMORY" style="top:50%; left:40%;"></div>
        <div class="location" data-name="END OF LINE CLUB" style="top:70%; left:60%;"></div>
        <div class="location" data-name="FLYNN'S SAFEHOUSE" style="top:20%; left:80%;"></div>
        <div class="location" data-name="GAME ARENA" style="top:60%; left:30%;"></div>
        
        <!-- Moving Light Cycle -->
        <div id="light-cycle"></div>
        
        <button id="back-btn" onclick="window.location.href='index.jsp'">RETURN TO MAINFRAME</button>
    </div>

    <script>
        // Animate Light Cycle
        const lightCycle = document.getElementById('light-cycle');
        let posX = 0, posY = 0;
        let speedX = 2, speedY = 1;
        
        function animateCycle() {
            posX += speedX;
            posY += speedY;
            
            if (posX > 95 || posX < 5) speedX *= -1;
            if (posY > 95 || posY < 5) speedY *= -1;
            
            lightCycle.style.left = `${posX}%`;
            lightCycle.style.top = `${posY}%`;
            
            requestAnimationFrame(animateCycle);
        }
        
        // Start animation
        setTimeout(() => {
            animateCycle();
        }, 1000);
        
        // Click effects on locations
        document.querySelectorAll('.location').forEach(loc => {
            loc.addEventListener('click', function() {
                alert(`ACCESSING: ${this.getAttribute('data-name')}`);
            });
        });
    </script>
</body>
</html>
