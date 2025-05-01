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
            margin-bottom: 30px;
        }
        .nav-container {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 20px;
            margin: 40px 0;
        }
        .nav-link {
            display: block;
            color: #00ffe4;
            text-decoration: none;
            font-size: 1.2em;
            width: 200px;
            padding: 15px;
            border: 1px solid #00ffe4;
            border-radius: 4px;
            transition: all 0.3s ease;
        }
        .nav-link:hover {
            background-color: rgba(0, 255, 228, 0.1);
            box-shadow: 0 0 15px #00ffe4;
            transform: scale(1.05);
        }
        #audio-container {
            margin: 40px auto;
            max-width: 300px;
        }
        #start-experience {
            background-color: #00ffe4;
            color: #0f0f0f;
            border: none;
            padding: 12px 25px;
            font-family: 'Orbitron', sans-serif;
            font-size: 1.1em;
            cursor: pointer;
            margin: 20px auto;
            display: block;
            transition: all 0.3s ease;
        }
        #start-experience:hover {
            box-shadow: 0 0 20px #00ffe4;
            transform: scale(1.05);
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body>
    <h1>Welcome to the TRON Legacy Web Interface</h1>
    <p>The Grid... A digital frontier...</p>
    
    <button id="start-experience">ACTIVATE GRID AUDIO</button>
    
    <div class="nav-container">
        <a class="nav-link" href="characters.jsp">Characters</a>
        <a class="nav-link" href="vehicles.jsp">Vehicles</a>
        <a class="nav-link" href="quotes.jsp">Quotes</a>
    </div>

    <div id="audio-container">
        <audio id="grid-theme" preload="auto">
            <source src="${pageContext.request.contextPath}/sounds/the-grid.mp3" type="audio/mpeg">
            Your browser does not support the audio element.
        </audio>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const gridAudio = document.getElementById("grid-theme");
            const startButton = document.getElementById("start-experience");
            
            // Set initial volume
            gridAudio.volume = 0.5;
            
            // Handle audio playback when button is clicked
            startButton.addEventListener('click', function() {
                gridAudio.play()
                    .then(() => {
                        startButton.style.display = 'none';
                        // Create volume control
                        const volumeControl = document.createElement('input');
                        volumeControl.type = 'range';
                        volumeControl.min = '0';
                        volumeControl.max = '1';
                        volumeControl.step = '0.01';
                        volumeControl.value = '0.5';
                        volumeControl.style.marginTop = '20px';
                        volumeControl.style.width = '200px';
                        volumeControl.addEventListener('input', function() {
                            gridAudio.volume = this.value;
                        });
                        document.getElementById('audio-container').appendChild(volumeControl);
                    })
                    .catch(error => {
                        console.error("Audio playback failed:", error);
                        startButton.textContent = "Audio Error - Click to Retry";
                    });
            });
            
            // Enable audio on any page interaction (as fallback)
            document.body.addEventListener('click', function audioEnable() {
                gridAudio.play().catch(e => {});
                document.body.removeEventListener('click', audioEnable);
            }, { once: true });
        });
    </script>
</body>
</html>
