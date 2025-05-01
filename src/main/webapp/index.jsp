<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>TRON: Legacy | Neural Interface</title>
    
    <!-- Three.js + GLTF Loader + Postprocessing -->
    <script src="https://cdn.jsdelivr.net/npm/three@0.132.2/build/three.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.132.2/examples/js/loaders/GLTFLoader.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.132.2/examples/js/controls/OrbitControls.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.132.2/examples/js/postprocessing/EffectComposer.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.132.2/examples/js/shaders/CopyShader.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.132.2/examples/js/postprocessing/RenderPass.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.132.2/examples/js/postprocessing/ShaderPass.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.132.2/examples/js/postprocessing/GlitchPass.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.132.2/examples/js/postprocessing/BloomPass.min.js"></script>

    <style>
        :root {
            --tron-blue: #00ffe4;
            --tron-orange: #ff6600;
            --grid-black: #000;
        }
        
        body {
            margin: 0;
            overflow: hidden;
            background: var(--grid-black);
            font-family: 'Orbitron', sans-serif;
            color: var(--tron-blue);
            touch-action: none;
            user-select: none;
        }
        
        #canvas-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            z-index: 0;
        }
        
        #ui-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            z-index: 100;
            pointer-events: none;
        }
        
        .scanline {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(
                rgba(0, 255, 228, 0.03) 50%,
                transparent 50%
            );
            background-size: 100% 4px;
            animation: scan 4s linear infinite;
            z-index: 101;
        }
        
        @keyframes scan {
            0% { transform: translateY(-100%); }
            100% { transform: translateY(100%); }
        }
        
        #main-title {
            position: absolute;
            top: 10%;
            left: 50%;
            transform: translateX(-50%);
            font-size: 5vw;
            text-shadow: 0 0 30px var(--tron-blue);
            animation: titlePulse 3s infinite alternate;
            background: linear-gradient(90deg, var(--tron-blue), var(--tron-orange));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            pointer-events: auto;
        }
        
        @keyframes titlePulse {
            0% { opacity: 0.7; text-shadow: 0 0 20px var(--tron-blue); }
            100% { opacity: 1; text-shadow: 0 0 50px var(--tron-blue), 0 0 20px var(--tron-orange); }
        }
        
        #grid-menu {
            position: absolute;
            bottom: 15%;
            left: 50%;
            transform: translateX(-50%);
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 2vw;
            pointer-events: auto;
        }
        
        .grid-btn {
            padding: 1.5vw 3vw;
            border: 0.3vw solid var(--tron-blue);
            color: var(--tron-blue);
            font-size: 1.5vw;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            background: rgba(0, 0, 0, 0.5);
            clip-path: polygon(
                0% 15%, 15% 15%, 15% 0%, 85% 0%, 
                85% 15%, 100% 15%, 100% 85%, 
                85% 85%, 85% 100%, 15% 100%, 
                15% 85%, 0% 85%
            );
        }
        
        .grid-btn:hover {
            background: rgba(0, 255, 228, 0.2);
            box-shadow: 0 0 30px var(--tron-blue);
            transform: translateY(-1vw);
            border-color: var(--tron-orange);
            color: white;
        }
        
        #identity-disc {
            position: absolute;
            bottom: 5%;
            right: 5%;
            width: 8vw;
            height: 8vw;
            background: url('https://i.imgur.com/8mRfzqK.png') center/contain no-repeat;
            cursor: pointer;
            transition: all 0.5s;
            filter: drop-shadow(0 0 15px var(--tron-blue));
            pointer-events: auto;
            animation: discRotate 20s linear infinite;
        }
        
        @keyframes discRotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        #light-cycle {
            position: absolute;
            bottom: 5%;
            left: 5%;
            width: 20vw;
            height: 10vw;
            background: url('https://i.imgur.com/JqYe6Zn.png') center/contain no-repeat;
            filter: drop-shadow(0 0 20px var(--tron-blue));
            pointer-events: none;
            animation: cycleFloat 3s ease-in-out infinite;
        }
        
        @keyframes cycleFloat {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-1vw); }
        }
        
        #audio-visualizer {
            position: absolute;
            bottom: 20%;
            left: 50%;
            transform: translateX(-50%);
            width: 60vw;
            height: 5vw;
            display: flex;
            justify-content: center;
            gap: 0.5vw;
        }
        
        .audio-bar {
            width: 0.8vw;
            background: linear-gradient(to top, var(--tron-blue), var(--tron-orange));
            border-radius: 0.5vw;
            animation: equalizer 1s infinite alternate;
            transform-origin: bottom;
        }
        
        @keyframes equalizer {
            0% { transform: scaleY(0.3); opacity: 0.5; }
            100% { transform: scaleY(1); opacity: 1; }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>
    <!-- 3D Container -->
    <div id="canvas-container"></div>
    
    <!-- UI Overlay -->
    <div id="ui-overlay">
        <div class="scanline"></div>
        <h1 id="main-title">TRON: LEGACY</h1>
        
        <div id="grid-menu">
            <div class="grid-btn" onclick="window.location.href='map.jsp'">GRID MAP</div>
            <div class="grid-btn" onclick="window.location.href='vehicles.jsp'">LIGHT CYCLES</div>
            <div class="grid-btn" onclick="window.location.href='characters.jsp'">PROGRAMS</div>
            <div class="grid-btn" onclick="window.location.href='quotes.jsp'">DIRECTIVES</div>
        </div>
        
        <div id="audio-visualizer"></div>
        <div id="light-cycle"></div>
        <div id="identity-disc" title="User Identity"></div>
    </div>
    
    <!-- Audio -->
    <audio id="grid-theme" loop>
        <source src="${pageContext.request.contextPath}/assets/sounds/the-grid.mp3" type="audio/mpeg">
    </audio>
    
    <script>
        // ========== 3D WORLD ==========
        const container = document.getElementById('canvas-container');
        const scene = new THREE.Scene();
        scene.background = new THREE.Color(0x000000);
        scene.fog = new THREE.FogExp2(0x000000, 0.002);
        
        const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
        camera.position.set(0, 5, 15);
        
        const renderer = new THREE.WebGLRenderer({ antialias: true });
        renderer.setSize(window.innerWidth, window.innerHeight);
        renderer.setPixelRatio(window.devicePixelRatio);
        renderer.shadowMap.enabled = true;
        container.appendChild(renderer.domElement);
        
        // Postprocessing
        const composer = new THREE.EffectComposer(renderer);
        const renderPass = new THREE.RenderPass(scene, camera);
        composer.addPass(renderPass);
        
        const bloomPass = new THREE.BloomPass(1.5, 25, 5, 512);
        composer.addPass(bloomPass);
        
        // Grid Floor
        const gridSize = 100;
        const gridDivisions = 100;
        const grid = new THREE.GridHelper(gridSize, gridDivisions, 0x00ffe4, 0x00ffe4);
        grid.material.opacity = 0.2;
        grid.material.transparent = true;
        scene.add(grid);
        
        // City Towers
        const towerGeometry = new THREE.BoxGeometry(1, 10, 1);
        const towerMaterial = new THREE.MeshBasicMaterial({ 
            color: 0x00ffe4,
            wireframe: true,
            transparent: true,
            opacity: 0.7
        });
        
        for (let i = 0; i < 50; i++) {
            const tower = new THREE.Mesh(towerGeometry, towerMaterial);
            tower.position.x = (Math.random() - 0.5) * 80;
            tower.position.z = (Math.random() - 0.5) * 80;
            tower.position.y = 5;
            tower.scale.y = Math.random() * 3 + 1;
            scene.add(tower);
        }
        
        // Flying Light Cycle
        const lightCycleGeometry = new THREE.ConeGeometry(0.5, 2, 4);
        const lightCycleMaterial = new THREE.MeshBasicMaterial({ 
            color: 0x00ffe4,
            wireframe: true
        });
        const lightCycle = new THREE.Mesh(lightCycleGeometry, lightCycleMaterial);
        lightCycle.position.set(0, 3, 0);
        lightCycle.rotation.x = Math.PI / 2;
        scene.add(lightCycle);
        
        // Animated Rings
        const ringGeometry = new THREE.TorusGeometry(5, 0.1, 16, 100);
        const ringMaterial = new THREE.MeshBasicMaterial({ 
            color: 0x00ffe4,
            wireframe: true,
            transparent: true,
            opacity: 0.7
        });
        const rings = [];
        
        for (let i = 0; i < 5; i++) {
            const ring = new THREE.Mesh(ringGeometry, ringMaterial);
            ring.position.y = i * 3;
            ring.rotation.x = Math.PI / 2;
            scene.add(ring);
            rings.push(ring);
        }
        
        // ========== UI ELEMENTS ==========
        // Audio Visualizer
        const visualizer = document.getElementById('audio-visualizer');
        for (let i = 0; i < 50; i++) {
            const bar = document.createElement('div');
            bar.className = 'audio-bar';
            bar.style.animationDelay = `${i * 0.02}s`;
            visualizer.appendChild(bar);
        }
        
        // Identity Disc Interaction
        document.getElementById('identity-disc').addEventListener('click', () => {
            const disc = document.getElementById('identity-disc');
            disc.style.filter = 'drop-shadow(0 0 30px var(--tron-orange))';
            setTimeout(() => {
                disc.style.filter = 'drop-shadow(0 0 15px var(--tron-blue))';
            }, 1000);
        });
        
        // ========== ANIMATION LOOP ==========
        function animate() {
            requestAnimationFrame(animate);
            
            // Camera movement
            camera.position.x = Math.sin(Date.now() * 0.0005) * 10;
            camera.position.z = Math.cos(Date.now() * 0.0005) * 10;
            camera.lookAt(0, 0, 0);
            
            // Light Cycle animation
            lightCycle.position.x = Math.sin(Date.now() * 0.001) * 20;
            lightCycle.position.z = Math.cos(Date.now() * 0.001) * 20;
            lightCycle.rotation.z = Date.now() * 0.001;
            
            // Ring animations
            rings.forEach((ring, i) => {
                ring.rotation.z = Date.now() * 0.0005 * (i + 1);
                ring.scale.setScalar(1 + Math.sin(Date.now() * 0.001 + i) * 0.2);
            });
            
            composer.render();
        }
        
        animate();
        
        // ========== AUDIO SYSTEM ==========
        const audio = document.getElementById('grid-theme');
        audio.volume = 0.3;
        
        // Auto-play with interaction
        document.addEventListener('click', () => {
            audio.play().catch(e => console.log("Audio requires interaction"));
        }, { once: true });
        
        // Responsive handling
        window.addEventListener('resize', () => {
            camera.aspect = window.innerWidth / window.innerHeight;
            camera.updateProjectionMatrix();
            renderer.setSize(window.innerWidth, window.innerHeight);
            composer.setSize(window.innerWidth, window.innerHeight);
        });
    </script>
</body>
</html>
