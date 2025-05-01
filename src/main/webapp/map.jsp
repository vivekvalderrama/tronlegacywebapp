<%@ page contentType="text/html; charset=UTF-8" %>
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
            transition: transform 0.3s;
        }
        .location:hover {
            transform: scale(1.5);
            cursor: pointer;
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
            position: absolute;
            top: 20px;
            left: 20px;
            font-size: 1.5em;
        }
        #back-btn {
            position: absolute;
            bottom: 20px;
            right: 20px;
            padding: 10px 20px;
            background: transparent;
            color: #00ffe4;
            border: 1px solid #00ffe4;
            font-family: 'Orbitron';
            cursor: pointer;
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron&display=swap" rel="stylesheet">
</head>
<body>
    <div id="grid-map">
        <div id="map-title">TRON GRID NAVIGATION SYSTEM</div>
        
        <!-- Static locations -->
        <div class="location" style="top:30%; left:20%;"></div>
        <div class="location" style="top:50%; left:40%;"></div>
        <div class="location" style="top:70%; left:60%;"></div>
        
        <div id="light-cycle"></div>
        <button id="back-btn" onclick="window.location.href='index.jsp'">RETURN</button>
    </div>

    <script>
        // Simplified light cycle animation
        const cycle = document.getElementById('light-cycle');
        let x = 0, y = 0;
        function animate() {
            x = (x + 0.5) % 100;
            y = (y + 0.3) % 100;
            cycle.style.left = x + '%';
            cycle.style.top = y + '%';
            requestAnimationFrame(animate);
        }
        animate();
    </script>
</body>
</html>
