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
            padding-top: 100px;
            cursor: pointer;
            margin: 0;
        }
        h1 {
            font-size: 3em;
            text-shadow: 0 0 15px #00ffe4;
            margin-bottom: 30px;
        }
        .nav-link {
            display: inline-block;
            margin: 20px;
            color: #00ffe4;
            text-decoration: none;
            font-size: 1.2em;
            width: 200px;
            padding: 12px;
            border: 1px solid #00ffe4;
            border-radius: 4px;
            transition: all 0.3s ease;
        }
        .nav-link:hover {
            background-color: rgba(0, 255, 228, 0.1);
            box-shadow: 0 0 15px #00ffe4;
            transform: scale(1.05);
        }
        #playPrompt {
            margin-top: 40px;
            font-size: 0.9em;
            opacity: 0.7;
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0% { opacity: 0.7; }
            50% { opacity: 1; }
            100% { opacity: 0.7; }
        }
        .audio-control {
            margin-top: 30px;
            background: rgba(0, 0, 0, 0.3);
            padding: 10px;
            border-radius: 20px;
            display: inline-block;
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body onclick="activateAudio()">
    <h1>Welcome to the TRON Legacy Web Interface</h1>
    <p>The Grid... A digital frontier...</p>
    
    <div>
        <a class="nav-link" href="characters.jsp">Characters</a>
        <a class="nav-link" href="vehicles.jsp">Vehicles</a>
        <a class="nav-link" href="quotes.jsp">Quotes</a>
    </div>

    <div id="playPrompt">Click anywhere to activate Grid audio</div>
    
    <!-- Audio element with controls as fallback -->
    <div class="audio-control">
        <audio id="grid-theme" controls>
            <source src="${pageContext.request.contextPath}/sounds/the-grid.mp3" type="audio/mpeg">
            Your browser does not support the audio element.
        </audio>
    </div>

    <script>
        // Hide native controls initially
        document.getElementById('grid-theme').controls = false;
        
        function activateAudio() {
            const gridAudio = document.getElementById("grid-theme");
            const prompt = document.getElementById("playPrompt");
            
            try {
                gridAudio.volume = 0.5;
                gridAudio.play().then(() => {
                    prompt.style.display = 'none';
                    // Hide native controls if autoplay succeeds
                    gridAudio.controls = false;
                }).catch(e => {
                    // Show native controls if play fails
                    gridAudio.controls = true;
                });
                
                document.body.onclick = null;
                document.body.style.cursor = 'default';
            } catch (error) {
                console.error("Audio error:", error);
                prompt.textContent = "Audio error - use controls below";
                gridAudio.controls = true;
            }
        }
        
        // Try autoplay on load (will fail in most browsers without prior interaction)
        window.addEventListener('load', () => {
            const gridAudio = document.getElementById("grid-theme");
            gridAudio.volume = 0.5;
            gridAudio.play().catch(() => {
                // Expected to fail - this is normal
            });
        });
    </script>
</body>
</html>
