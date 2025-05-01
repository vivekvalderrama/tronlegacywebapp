<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>TRON: Legacy | Neural Nexus</title>
    
    <!-- Three.js + Advanced Libraries -->
    <script src="https://cdn.jsdelivr.net/npm/three@0.132.2/build/three.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.132.2/examples/js/controls/OrbitControls.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.132.2/examples/js/loaders/GLTFLoader.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.132.2/examples/js/postprocessing/EffectComposer.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.132.2/examples/js/postprocessing/RenderPass.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.132.2/examples/js/postprocessing/ShaderPass.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.132.2/examples/js/postprocessing/BloomPass.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.132.2/examples/js/shaders/CopyShader.min.js"></script>
    
    <style>
        :root {
            --tron-blue: #00ffe4;
            --tron-orange: #ff6600;
            --grid-black: #000000;
        }
        
        body {
            margin: 0;
            overflow: hidden;
            background: var(--grid-black);
            font-family: 'Orbitron', sans-serif;
            color: var(--tron-blue);
            touch-action: none;
        }
        
        #world {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            z-index: 0;
        }
        
        #ui {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            z-index: 100;
            pointer-events: none;
        }
        
        #main-title {
            position: absolute;
            top: 15vh;
            left: 50%;
            transform: translateX(-50%);
            font-size: 5rem;
            text-shadow: 0 0 2rem var(--tron-blue);
            background: linear-gradient(90deg, var(--tron-blue), var(--tron-orange));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: titleGlow 3s infinite alternate;
            pointer-events: auto;
        }
        
        @keyframes titleGlow {
            0% { opacity: 0.8; text-shadow: 0 0 1rem var(--tron-blue); }
            100% { opacity: 1; text-shadow: 0 0 3rem var(--tron-blue), 0 0 1rem var(--tron-orange); }
        }
        
        .grid-menu {
            position: absolute;
            bottom: 20vh;
            left: 50%;
            transform: translateX(-50%);
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 2rem;
            pointer-events: auto;
        }
        
        .grid-btn {
            padding: 1.5rem 3rem;
            border: 0.3rem solid var(--tron-blue);
            color: var(--tron-blue);
            font-size: 1.5rem;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            background: rgba(0, 0, 0, 0.7);
            clip-path: polygon(
                0% 15%, 15% 15%, 15% 0%, 85% 0%, 
                85% 15%, 100% 15%, 100% 85%, 
                85% 85%, 85% 100%, 15% 100%, 
                15% 85%, 0% 85%
            );
        }
        
        .grid-btn:hover {
            background: rgba(0, 255, 228, 0.3);
            box-shadow: 0 0 3rem var(--tron-blue);
            transform: translateY(-0.5rem);
            border-color: var(--tron-orange);
            color: white;
        }
        
        #identity-disc {
            position: absolute;
            bottom: 5vh;
            right: 5vw;
            width: 8rem;
            height: 8rem;
            background: url('${pageContext.request.contextPath}/assets/images/disc.png') center/contain no-repeat;
            cursor: pointer;
            transition: all 0.5s;
            filter: drop-shadow(0 0 1.5rem var(--tron-blue));
            pointer-events: auto;
            animation: discRotate 20s linear infinite;
        }
        
        @keyframes discRotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        #light-cycle {
            position: absolute;
            bottom: 5vh;
            left: 5vw;
            width: 20rem;
            height: 10rem;
            background: url('${pageContext.request.contextPath}/assets/images/cycle.png') center/contain no-repeat;
            filter: drop-shadow(0 0 2rem var(--tron-blue));
            pointer-events: none;
            animation: cycleFloat 3s ease-in-out infinite;
        }
        
        @keyframes cycleFloat {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-1rem); }
        }
        
        .scanlines {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: repeating-linear-gradient(
                0deg,
                rgba(0, 255, 228, 0.05),
                rgba(0, 255, 228, 0.05) 1px,
                transparent 1px,
                transparent 3px
            );
            pointer-events: none;
            z-index: 101;
        }
        
        #voice-status {
            position: absolute;
            top: 2rem;
            right: 2rem;
            font-size: 1rem;
            color: var(--tron-orange);
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>
    <!-- 3D World Container -->
    <div id="world"></div>
    
    <!-- UI Overlay -->
    <div id="ui">
        <div class="scanlines"></div>
        <h1 id="main-title">TRON: LEGACY</h1>
        <div id="voice-status">VOICE: DISABLED</div>
        
        <div class="grid-menu">
            <div class="grid-btn" onclick="navigate('map.jsp')">GRID MAP</div>
            <div class="grid-btn" onclick="navigate('vehicles.jsp')">LIGHT CYCLES</div>
            <div class="grid-btn" onclick="navigate('characters.jsp')">PROGRAMS</div>
            <div class="grid-btn" onclick="navigate('quotes.jsp')">DIRECTIVES</div>
        </div>
        
        <div id="light-cycle"></div>
        <div id="identity-disc" title="User Identity"></div>
    </div>
    
    <!-- Audio -->
    <audio id="grid-theme" loop>
        <source src="${pageContext.request.contextPath}/assets/sounds/the-grid.mp3" type="audio/mpeg">
    </audio>
    
    <script>
        // ========== 3D WORLD INIT ==========
        const scene = new THREE.Scene();
        scene.background = new THREE.Color(0x000000);
        scene.fog = new THREE.FogExp2(0x000000, 0.002);
        
        const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
        camera.position.set(0, 5, 15);
        
        const renderer = new THREE.WebGLRenderer({ antialias: true });
        renderer.setSize(window.innerWidth, window.innerHeight);
        renderer.setPixelRatio(window.devicePixelRatio);
        renderer.shadowMap.enabled = true;
        document.getElementById('world').appendChild(renderer.domElement);
        
        // Postprocessing
        const composer = new THREE.EffectComposer(renderer);
        const renderPass = new THREE.RenderPass(scene, camera);
        composer.addPass(renderPass);
        
        const bloomPass = new THREE.BloomPass(1.5, 25, 5, 512);
        composer.addPass(bloomPass);
        
        // Grid Floor
        const grid = new THREE.GridHelper(100, 100, 0x00ffe4, 0x00ffe4);
        grid.material.opacity = 0.2;
        grid.material.transparent = true;
        scene.add(grid);
        
        // Cityscape
        const geometry = new THREE.BoxGeometry(1, 1, 1);
        const material = new THREE.MeshBasicMaterial({ 
            color: 0x00ffe4,
            wireframe: true,
            transparent: true,
            opacity: 0.7
        });
        
        for (let i = 0; i < 100; i++) {
            const cube = new THREE.Mesh(geometry, material);
            cube.position.x = (Math.random() - 0.5) * 200;
            cube.position.z = (Math.random() - 0.5) * 200;
            cube.position.y = Math.random() * 10;
            cube.scale.set(
                Math.random() * 3 + 1,
                Math.random() * 10 + 5,
                Math.random() * 3 + 1
            );
            scene.add(cube);
        }
        
        // Light Cycle Model
        const lightCycle = new THREE.Mesh(
            new THREE.ConeGeometry(0.5, 2, 4),
            new THREE.MeshBasicMaterial({ 
                color: 0x00ffe4,
                wireframe: true
            })
        );
        lightCycle.position.set(0, 3, 0);
        lightCycle.rotation.x = Math.PI / 2;
        scene.add(lightCycle);
        
        // ========== INTERACTIVE ELEMENTS ==========
        // Voice Recognition
        function initVoiceControl() {
            if ('webkitSpeechRecognition' in window) {
                const recognition = new webkitSpeechRecognition();
                recognition.continuous = true;
                recognition.interimResults = true;
                
                recognition.onstart = () => {
                    document.getElementById('voice-status').textContent = "VOICE: ACTIVE";
                    document.getElementById('voice-status').style.color = "#00ff00";
                };
                
                recognition.onresult = (event) => {
                    const transcript = Array.from(event.results)
                        .map(result => result[0].transcript)
                        .join('');
                    
                    if (transcript.includes("map")) navigate('map.jsp');
                    if (transcript.includes("light cycle")) navigate('vehicles.jsp');
                    if (transcript.includes("program")) navigate('characters.jsp');
                    if (transcript.includes("directive")) navigate('quotes.jsp');
                };
                
                recognition.onerror = () => {
                    document.getElementById('voice-status').textContent = "VOICE: ERROR";
                    document.getElementById('voice-status').style.color = "#ff0000";
                };
                
                recognition.start();
            }
        }
        
        // Navigation with Haptic Feedback
        function navigate(page) {
            if ('vibrate' in navigator) {
                navigator.vibrate([100, 50, 100]);
            }
            window.location.href = page;
        }
        
        // Identity Disc Interaction
        document.getElementById('identity-disc').addEventListener('click', () => {
            const disc = document.getElementById('identity-disc');
            disc.style.filter = 'drop-shadow(0 0 3rem var(--tron-orange))';
            setTimeout(() => {
                disc.style.filter = 'drop-shadow(0 0 1.5rem var(--tron-blue))';
            }, 1000);
            
            // Toggle voice control
            if (document.getElementById('voice-status').textContent.includes("DISABLED")) {
                initVoiceControl();
            }
        });
        
        // ========== ANIMATION LOOP ==========
        function animate() {
            requestAnimationFrame(animate);
            
            // Camera movement
            camera.position.x = Math.sin(Date.now() * 0.0005) * 20;
            camera.position.z = Math.cos(Date.now() * 0.0005) * 20;
            camera.lookAt(0, 0, 0);
            
            // Light Cycle animation
            lightCycle.position.x = Math.sin(Date.now() * 0.001) * 30;
            lightCycle.position.z = Math.cos(Date.now() * 0.0015) * 30;
            lightCycle.rotation.z = Date.now() * 0.001;
            
            composer.render();
        }
        
        animate();
        
        // ========== SYSTEM INIT ==========
        // Auto-play audio on interaction
        document.addEventListener('click', () => {
            const audio = document.getElementById('grid-theme');
            audio.volume = 0.3;
            audio.play().catch(e => console.log("Audio requires interaction"));
        }, { once: true });
        
        // Handle window resize
        window.addEventListener('resize', () => {
            camera.aspect = window.innerWidth / window.innerHeight;
            camera.updateProjectionMatrix();
            renderer.setSize(window.innerWidth, window.innerHeight);
            composer.setSize(window.innerWidth, window.innerHeight);
        });
    </script>
</body>
</html>
