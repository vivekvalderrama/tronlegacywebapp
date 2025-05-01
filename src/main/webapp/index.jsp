<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>TRON Legacy | Grid Online</title>
    <style>
        :root {
            --tron-blue: #00ffe4;
            --grid-black: #0f0f0f;
        }
        body {
            background-color: var(--grid-black);
            color: var(--tron-blue);
            font-family: 'Orbitron', sans-serif;
            text-align: center;
            padding: 50px 20px;
            margin: 0;
            min-height: 100vh;
            overflow-x: hidden;
        }
        h1 {
            font-size: 3em;
            text-shadow: 0 0 15px var(--tron-blue);
            margin-bottom: 20px;
            animation: pulse 2s infinite alternate;
        }
        @keyframes pulse {
            from { text-shadow: 0 0 10px var(--tron-blue); }
            to { text-shadow: 0 0 25px var(--tron-blue); }
        }
        #audio-init {
            background: var(--tron-blue);
            color: var(--grid-black);
            border: none;
            padding: 15px 30px;
            font-family: inherit;
            font-size: 1.2em;
            margin: 30px auto;
            cursor: pointer;
            display: block;
            border-radius: 4px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        #audio-init:hover {
            box-shadow: 0 0 20px var(--tron-blue);
            transform: scale(1.05);
        }
        .nav-container {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 20px;
            margin: 40px auto;
            max-width: 800px;
        }
        .nav-link {
            display: block;
            color: var(--tron-blue);
            text-decoration: none;
            border: 1px solid var(--tron-blue);
            padding: 15px;
            margin: 0;
            width: 180px;
            transition: all 0.3s ease;
            position: relative;
        }
        .nav-link:hover {
            background: rgba(0, 255, 228, 0.1);
            box-shadow: 0 0 15px var(--tron-blue);
        }
        .nav-link::before {
            content: '>';
            position: absolute;
            left: 10px;
            opacity: 0;
            transition: all 0.3s ease;
        }
        .nav-link:hover::before {
            opacity: 1;
            left: 15px;
        }
        #volume-container {
            margin: 40px auto;
            width: 200px;
        }
        #volume-control {
            width: 100%;
            accent-color: var(--tron-blue);
        }
        .grid-line {
            position: fixed;
            background: rgba(0, 255, 228, 0.05);
            height: 1px;
            width: 100vw;
            left: 0;
            z-index: -1;
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body>
    <!-- Animated grid lines -->
    <% for(int i=0; i<20; i++) { %>
        <div class="grid-line" style="top:<%= i*5 %>vh;"></div>
    <% } %>
    
    <h1>GRID ONLINE</h1>
    <p>YOUR SYSTEM IS OPERATIONAL</p>
    
    <button id="audio-init">ENGAGE AUDIO PROTOCOL</button>
    
    <div class="nav-container">
        <a class="nav-link" href="characters.jsp">
            <span>USER PROGRAMS</span>
        </a>
        <a class="nav-link" href="vehicles.jsp">
            <span>LIGHT CYCLE GARAGE</span>
        </a>
        <a class="nav-link" href="quotes.jsp">
            <span>SYSLOG ARCHIVES</span>
        </a>
        <a class="nav-link" href="map.jsp">
            <span>GRID TOPOGRAPHY</span>
        </a>
    </div>
    
    <div id="volume-container">
        <input type="range" id="volume-control" min="0" max="1" step="0.01" value="0.5">
        <div>AUDIO MODULATION</div>
    </div>
    
    <audio id="grid-theme" preload="auto">
        <source src="${pageContext.request.contextPath}/assets/sounds/the-grid.mp3" type="audio/mpeg">
    </audio>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const audio = document.getElementById('grid-theme');
            const initBtn = document.getElementById('audio-init');
            const volumeControl = document.getElementById('volume-control');
            
            // Set initial volume
            audio.volume = 0.5;
            
            // Audio initialization
            initBtn.addEventListener('click', function() {
                audio.play()
                    .then(() => {
                        initBtn.innerHTML = "AUDIO ONLINE <span style='display:block;font-size:0.6em;'>PULSE: 128kbps</span>";
                        initBtn.style.background = "var(--grid-black)";
                        initBtn.style.color = "var(--tron-blue)";
                        initBtn.style.border = "1px solid var(--tron-blue)";
                        initBtn.style.padding = "10px 30px";
                        initBtn.style.cursor = "default";
                        initBtn.style.transform = "none";
                        initBtn.style.boxShadow = "0 0 10px var(--tron-blue)";
                        initBtn.onmouseenter = null;
                        initBtn.onmouseleave = null;
                        initBtn.removeAttribute('id');
                    })
                    .catch(error => {
                        initBtn.textContent = "CLICK TO RETRY";
                        console.error("Audio error:", error);
                    });
            });
            
            // Volume control
            volumeControl.addEventListener('input', function() {
                audio.volume = this.value;
            });
            
            // Fallback: Enable audio on any click
            document.body.addEventListener('click', function() {
                audio.play().catch(e => {});
            }, { once: true });
        });
    </script>
</body>
</html>
