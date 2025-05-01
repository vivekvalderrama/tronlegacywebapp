<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>TRON Legacy Interface</title>
    <style>
        body {
            background-color: #0f0f0f;
            color: #00ffe4;
            font-family: 'Orbitron', sans-serif;
            text-align: center;
            padding-top: 50px;
            margin: 0;
            min-height: 100vh;
        }
        h1 {
            font-size: 3em;
            text-shadow: 0 0 15px #00ffe4;
            margin-bottom: 20px;
        }
        #audio-init {
            background: #00ffe4;
            color: #0f0f0f;
            border: none;
            padding: 15px 30px;
            font-family: inherit;
            font-size: 1.2em;
            margin: 30px auto;
            cursor: pointer;
            display: block;
            border-radius: 4px;
            transition: all 0.3s ease;
        }
        #audio-init:hover {
            box-shadow: 0 0 20px #00ffe4;
            transform: scale(1.05);
        }
        .nav-link {
            display: inline-block;
            color: #00ffe4;
            text-decoration: none;
            border: 1px solid #00ffe4;
            padding: 12px 25px;
            margin: 15px;
            width: 150px;
            transition: all 0.3s ease;
        }
        .nav-link:hover {
            background: rgba(0, 255, 228, 0.1);
            box-shadow: 0 0 15px #00ffe4;
        }
        #volume-control {
            margin-top: 30px;
            width: 200px;
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body>
    <h1>TRON LEGACY INTERFACE</h1>
    <p>A digital frontier...</p>
    
    <button id="audio-init">ACTIVATE GRID AUDIO</button>
    
    <div>
        <a class="nav-link" href="characters.jsp">PROGRAMS</a>
        <a class="nav-link" href="vehicles.jsp">LIGHT CYCLES</a>
        <a class="nav-link" href="quotes.jsp">DIRECTIVES</a>
    </div>
    
    <input type="range" id="volume-control" min="0" max="1" step="0.01" value="0.5">
    
    <audio id="grid-theme">
        <source src="${pageContext.request.contextPath}/assets/sounds/the-grid.mp3" type="audio/mpeg">
        Your browser doesn't support the audio element.
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
                        initBtn.textContent = "GRID ONLINE";
                        initBtn.style.background = "#0f0f0f";
                        initBtn.style.color = "#00ffe4";
                        initBtn.style.border = "1px solid #00ffe4";
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
