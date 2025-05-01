<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>TRON LEGACY :: GRID ACCESS</title>
    <style>
        :root {
            --tron-blue: #00ffe4;
            --grid-black: #0f0f0f;
            --grid-glow: 0 0 10px #00ffe4;
        }
        
        body {
            background-color: var(--grid-black);
            color: var(--tron-blue);
            font-family: 'Orbitron', sans-serif;
            text-align: center;
            margin: 0;
            padding: 0;
            overflow: hidden;
            height: 100vh;
            cursor: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="%2300ffe4" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/></svg>'), auto;
        }

        /* === GRID LINES === */
        .grid-line {
            position: absolute;
            background: rgba(0, 255, 228, 0.05);
            z-index: -1;
        }
        .horizontal-line {
            width: 100vw;
            height: 1px;
            left: 0;
        }
        .vertical-line {
            width: 1px;
            height: 100vh;
            top: 0;
        }

        /* === MAIN CONTAINER === */
        #grid-container {
            position: relative;
            height: 100vh;
            overflow: hidden;
        }

        /* === LIGHT CYCLE TRAIL === */
        #light-cycle {
            position: absolute;
            width: 20px;
            height: 20px;
            background: var(--tron-blue);
            border-radius: 50%;
            box-shadow: var(--grid-glow);
            z-index: -1;
            opacity: 0;
            transition: opacity 1s;
        }
        .trail {
            position: absolute;
            width: 4px;
            height: 4px;
            background: var(--tron-blue);
            border-radius: 50%;
            box-shadow: var(--grid-glow);
            z-index: -1;
            opacity: 0.7;
        }

        /* === IDENTITY DISC === */
        #identity-disc {
            position: fixed;
            bottom: 20px;
            right: 20px;
            width: 80px;
            height: 80px;
            border: 2px solid var(--tron-blue);
            border-radius: 50%;
            box-shadow: var(--grid-glow);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: transform 0.3s;
        }
        #identity-disc:hover {
            transform: scale(1.1);
        }
        #disc-inner {
            width: 60px;
            height: 60px;
            border: 1px solid var(--tron-blue);
            border-radius: 50%;
            animation: spin 4s linear infinite;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* === MAIN UI === */
        h1 {
            font-size: 3em;
            text-shadow: 0 0 15px var(--tron-blue);
            margin-top: 10vh;
            animation: pulse 2s infinite alternate;
        }
        @keyframes pulse {
            from { text-shadow: 0 0 10px var(--tron-blue); }
            to { text-shadow: 0 0 25px var(--tron-blue); }
        }

        #login-prompt {
            margin: 30px auto;
            font-size: 1.2em;
            text-transform: uppercase;
        }

        #access-btn {
            background: transparent;
            color: var(--tron-blue);
            border: 2px solid var(--tron-blue);
            padding: 15px 40px;
            font-family: 'Orbitron', sans-serif;
            font-size: 1.2em;
            margin: 20px auto;
            cursor: pointer;
            transition: all 0.3s;
            text-transform: uppercase;
            letter-spacing: 2px;
            position: relative;
            overflow: hidden;
        }
        #access-btn:hover {
            background: rgba(0, 255, 228, 0.1);
            box-shadow: 0 0 20px var(--tron-blue);
        }
        #access-btn::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(
                transparent,
                rgba(0, 255, 228, 0.1) 45%,
                transparent 55%
            );
            transform: rotate(30deg);
            animation: shine 3s infinite;
        }
        @keyframes shine {
            0% { transform: rotate(30deg) translate(-30%, -30%); }
            100% { transform: rotate(30deg) translate(30%, 30%); }
        }

        /* === NAVIGATION === */
        .nav-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            max-width: 600px;
            margin: 40px auto;
        }
        .nav-item {
            border: 1px solid var(--tron-blue);
            padding: 15px;
            transition: all 0.3s;
            text-transform: uppercase;
            cursor: pointer;
        }
        .nav-item:hover {
            background: rgba(0, 255, 228, 0.1);
            box-shadow: 0 0 15px var(--tron-blue);
        }

        /* === AUDIO VISUALIZER === */
        #visualizer {
            display: flex;
            justify-content: center;
            gap: 5px;
            margin: 30px auto;
            height: 100px;
            align-items: flex-end;
        }
        .bar {
            width: 8px;
            background: var(--tron-blue);
            border-radius: 2px;
            animation: equalizer 1s infinite alternate;
            opacity: 0.7;
        }
        @keyframes equalizer {
            0% { height: 10%; }
            100% { height: 100%; }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body>
    <!-- === DYNAMIC GRID LINES === -->
    <div id="grid-container">
        <% for(int i=0; i<20; i++) { %>
            <div class="grid-line horizontal-line" style="top:<%= i*5 %>vh;"></div>
            <div class="grid-line vertical-line" style="left:<%= i*5 %>vw;"></div>
        <% } %>
        
        <!-- === LIGHT CYCLE TRAIL === -->
        <div id="light-cycle"></div>
        
        <!-- === MAIN CONTENT === -->
        <h1>TRON GRID INTERFACE</h1>
        <div id="login-prompt">USER: [ANONYMOUS] | ACCESS LEVEL: 0</div>
        
        <button id="access-btn">INITIALIZE SYSTEM</button>
        
        <div class="nav-grid">
            <div class="nav-item" onclick="window.location.href='characters.jsp'">PROGRAMS</div>
            <div class="nav-item" onclick="window.location.href='vehicles.jsp'">LIGHT CYCLES</div>
            <div class="nav-item" onclick="window.location.href='quotes.jsp'">DIRECTIVES</div>
            <div class="nav-item" onclick="window.location.href='map.jsp'">GRID MAP</div>
        </div>
        
        <!-- === AUDIO VISUALIZER === -->
        <div id="visualizer"></div>
        
        <!-- === IDENTITY DISC (BOTTOM RIGHT) === -->
        <div id="identity-disc" title="User Identity Disc">
            <div id="disc-inner"></div>
        </div>
        
        <!-- === HIDDEN AUDIO === -->
        <audio id="grid-theme" preload="auto">
            <source src="${pageContext.request.contextPath}/assets/sounds/the-grid.mp3" type="audio/mpeg">
        </audio>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const audio = document.getElementById('grid-theme');
            const accessBtn = document.getElementById('access-btn');
            const lightCycle = document.getElementById('light-cycle');
            const visualizer = document.getElementById('visualizer');
            
            // === LIGHT CYCLE ANIMATION ===
            let mouseX = 0, mouseY = 0;
            let trail = [];
            
            document.addEventListener('mousemove', (e) => {
                mouseX = e.clientX;
                mouseY = e.clientY;
                
                // Update light cycle position
                lightCycle.style.left = (mouseX - 10) + 'px';
                lightCycle.style.top = (mouseY - 10) + 'px';
                lightCycle.style.opacity = '1';
                
                // Create trail effect
                if (Math.random() > 0.7) {
                    const trailDot = document.createElement('div');
                    trailDot.className = 'trail';
                    trailDot.style.left = (mouseX - 2) + 'px';
                    trailDot.style.top = (mouseY - 2) + 'px';
                    document.body.appendChild(trailDot);
                    
                    trail.push(trailDot);
                    if (trail.length > 50) {
                        const oldDot = trail.shift();
                        if (oldDot) oldDot.remove();
                    }
                    
                    // Fade out trail dots
                    setTimeout(() => {
                        trailDot.style.opacity = '0';
                        setTimeout(() => trailDot.remove(), 1000);
                    }, 500);
                }
            });
            
            // === AUDIO VISUALIZER ===
            for (let i = 0; i < 30; i++) {
                const bar = document.createElement('div');
                bar.className = 'bar';
                bar.style.animationDelay = `${i * 0.05}s`;
                bar.style.height = `${Math.random() * 80 + 10}%`;
                visualizer.appendChild(bar);
            }
            
            // === SYSTEM INITIALIZATION ===
            accessBtn.addEventListener('click', function() {
                audio.volume = 0.5;
                audio.play()
                    .then(() => {
                        accessBtn.textContent = "SYSTEM ONLINE";
                        accessBtn.style.background = "rgba(0, 255, 228, 0.1)";
                        accessBtn.style.boxShadow = "0 0 30px var(--tron-blue)";
                        
                        // Update login prompt
                        document.getElementById('login-prompt').textContent = 
                            "USER: [FLYNN] | ACCESS LEVEL: 99 | GRID STATUS: SECURE";
                        
                        // Enhance visualizer
                        setInterval(() => {
                            document.querySelectorAll('.bar').forEach(bar => {
                                bar.style.height = `${Math.random() * 80 + 10}%`;
                            });
                        }, 200);
                    })
                    .catch(error => {
                        console.error("Audio error:", error);
                        accessBtn.textContent = "ACCESS DENIED - RETRY";
                    });
            });
            
            // === IDENTITY DISC CLICK EFFECT ===
            document.getElementById('identity-disc').addEventListener('click', function() {
                const disc = this;
                disc.style.boxShadow = "0 0 30px var(--tron-blue)";
                setTimeout(() => {
                    disc.style.boxShadow = "var(--grid-glow)";
                }, 500);
            });
            
            // === CONSOLE MESSAGE ===
            console.log("%cTRON INTERFACE ACTIVATED\n%c> SYSTEM READY\n> AUDIO PROTOCOL ENGAGED", 
                "color:#00ffe4; font-family:'Orbitron'; font-size:18px;", 
                "color:#00ffe4;");
        });
    </script>
</body>
</html>
