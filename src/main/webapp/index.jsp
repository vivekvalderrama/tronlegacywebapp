<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>TRON Legacy | Grid 3.0</title>
    
    <!-- Three.js for 3D Effects -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.128.0/examples/js/controls/OrbitControls.min.js"></script>
    
    <style>
        :root {
            --tron-blue: #00ffe4;
            --grid-black: #0f0f0f;
        }
        
        body {
            margin: 0;
            overflow: hidden;
            font-family: 'Orbitron', sans-serif;
            color: var(--tron-blue);
        }
        
        #canvas3d {
            position: fixed;
            top: 0;
            left: 0;
            z-index: -1;
        }
        
        #ui-container {
            position: relative;
            z-index: 10;
            text-align: center;
            padding-top: 5vh;
        }
        
        h1 {
            font-size: 3em;
            text-shadow: 0 0 20px var(--tron-blue);
            animation: pulse 2s infinite alternate;
        }
        
        @keyframes pulse {
            from { text-shadow: 0 0 10px var(--tron-blue); }
            to { text-shadow: 0 0 30px var(--tron-blue); }
        }
        
        .nav-btn {
            display: inline-block;
            margin: 20px;
            padding: 15px 30px;
            border: 2px solid var(--tron-blue);
            color: var(--tron-blue);
            text-decoration: none;
            font-size: 1.2em;
            transition: all 0.3s;
        }
        
        .nav-btn:hover {
            background: rgba(0, 255, 228, 0.2);
            box-shadow: 0 0 25px var(--tron-blue);
            transform: translateY(-5px);
        }
        
        #light-cycle-model {
            position: fixed;
            bottom: 50px;
            left: 50%;
            transform: translateX(-50%);
            width: 300px;
            height: 150px;
            background: url('https://i.imgur.com/JqYe6Zn.png') no-repeat center;
            background-size: contain;
            filter: drop-shadow(0 0 15px var(--tron-blue));
            animation: float 3s ease-in-out infinite;
        }
        
        @keyframes float {
            0%, 100% { transform: translateX(-50%) translateY(0); }
            50% { transform: translateX(-50%) translateY(-20px); }
        }
        
        #identity-disc {
            position: fixed;
            top: 20px;
            right: 20px;
            width: 60px;
            height: 60px;
            background: url('https://i.imgur.com/8mRfzqK.png') no-repeat center;
            background-size: contain;
            cursor: pointer;
            transition: transform 0.3s;
        }
        
        #identity-disc:hover {
            transform: scale(1.2) rotate(30deg);
            filter: drop-shadow(0 0 10px var(--tron-blue));
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>
    <!-- 3D Canvas -->
    <canvas id="canvas3d"></canvas>
    
    <!-- UI Container -->
    <div id="ui-container">
        <h1>TRON GRID 3.0</h1>
        <p>SYSTEM STATUS: <span style="color:#00ff00;">ONLINE</span></p>
        
        <div>
            <a class="nav-btn" href="characters.jsp">PROGRAMS</a>
            <a class="nav-btn" href="vehicles.jsp">LIGHT CYCLES</a>
            <a class="nav-btn" href="map.jsp">GRID MAP</a>
            <a class="nav-btn" href="quotes.jsp">DIRECTIVES</a>
        </div>
        
        <!-- 3D Light Cycle Model -->
        <div id="light-cycle-model"></div>
        
        <!-- Identity Disc -->
        <div id="identity-disc" title="User Identity"></div>
    </div>
    
    <!-- Audio -->
    <audio id="grid-theme" loop>
        <source src="${pageContext.request.contextPath}/assets/sounds/the-grid.mp3" type="audio/mpeg">
    </audio>
    
    <script>
        // ===== 3D GRID RENDER =====
        const scene = new THREE.Scene();
        const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
        const renderer = new THREE.WebGLRenderer({ canvas: document.getElementById('canvas3d'), alpha: true });
        renderer.setSize(window.innerWidth, window.innerHeight);
        
        // Grid Floor
        const grid = new THREE.GridHelper(100, 100, 0x00ffe4, 0x00ffe4);
        grid.material.opacity = 0.2;
        grid.material.transparent = true;
        scene.add(grid);
        
        // Floating Cubes (TRON Buildings)
        for (let i = 0; i < 20; i++) {
            const size = Math.random() * 3 + 1;
            const cube = new THREE.Mesh(
                new THREE.BoxGeometry(size, size * 5, size),
                new THREE.MeshBasicMaterial({ 
                    color: 0x00ffe4,
                    wireframe: true,
                    transparent: true,
                    opacity: 0.7
                })
            );
            cube.position.x = (Math.random() - 0.5) * 100;
            cube.position.z = (Math.random() - 0.5) * 100;
            cube.position.y = size * 2.5;
            scene.add(cube);
        }
        
        camera.position.set(0, 30, 50);
        camera.lookAt(0, 0, 0);
        
        // Animation Loop
        function animate() {
            requestAnimationFrame(animate);
            scene.rotation.y += 0.002;
            renderer.render(scene, camera);
        }
        animate();
        
        // ===== INTERACTIVE ELEMENTS =====
        document.getElementById('identity-disc').addEventListener('click', () => {
            alert("USER IDENTITY VERIFIED\nACCESS LEVEL: ADMIN");
        });
        
        // Audio Controls
        const audio = document.getElementById('grid-theme');
        audio.volume = 0.3;
        
        document.addEventListener('click', () => {
            audio.play().catch(e => console.log("Audio requires interaction"));
        }, { once: true });
        
        // Responsive Resize
        window.addEventListener('resize', () => {
            camera.aspect = window.innerWidth / window.innerHeight;
            camera.updateProjectionMatrix();
            renderer.setSize(window.innerWidth, window.innerHeight);
        });
    </script>
</body>
</html>
