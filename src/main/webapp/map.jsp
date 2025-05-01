<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>TRON Grid Map | System Navigation</title>
    
    <!-- Three.js + Controls -->
    <script src="https://cdn.jsdelivr.net/npm/three@0.132.2/build/three.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.132.2/examples/js/controls/OrbitControls.min.js"></script>
    
    <style>
        body {
            margin: 0;
            overflow: hidden;
            background: #000;
            font-family: 'Orbitron', sans-serif;
        }
        
        #map-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
        }
        
        #map-ui {
            position: fixed;
            top: 20px;
            left: 20px;
            color: #00ffe4;
            text-shadow: 0 0 10px #00ffe4;
            z-index: 100;
        }
        
        .location-marker {
            position: absolute;
            width: 20px;
            height: 20px;
            background: #00ffe4;
            border-radius: 50%;
            box-shadow: 0 0 15px #00ffe4;
            transform: translate(-50%, -50%);
            cursor: pointer;
            transition: all 0.3s;
            z-index: 10;
        }
        
        .location-marker:hover {
            transform: translate(-50%, -50%) scale(1.5);
            box-shadow: 0 0 30px #00ffe4;
        }
        
        .location-label {
            position: absolute;
            color: #00ffe4;
            font-size: 1.2em;
            white-space: nowrap;
            text-shadow: 0 0 5px #00ffe4;
            pointer-events: none;
            opacity: 0;
            transition: opacity 0.3s;
        }
        
        .location-marker:hover + .location-label {
            opacity: 1;
        }
        
        #back-btn {
            position: fixed;
            bottom: 20px;
            right: 20px;
            padding: 10px 20px;
            background: rgba(0, 0, 0, 0.5);
            border: 1px solid #00ffe4;
            color: #00ffe4;
            font-family: 'Orbitron';
            cursor: pointer;
            z-index: 100;
        }
        
        #back-btn:hover {
            background: rgba(0, 255, 228, 0.2);
            box-shadow: 0 0 15px #00ffe4;
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>
    <!-- 3D Map Container -->
    <div id="map-container"></div>
    
    <!-- UI Overlay -->
    <div id="map-ui">
        <h1>GRID TOPOGRAPHY</h1>
        <p>COORDINATES: <span id="coords">0,0,0</span></p>
    </div>
    
    <!-- Location Markers -->
    <div class="location-marker" style="top:30%; left:25%;" data-name="LIGHT CYCLE GARAGE"></div>
    <div class="location-label" style="top:30%; left:25%; padding-left:25px;">LIGHT CYCLE GARAGE</div>
    
    <div class="location-marker" style="top:50%; left:50%;" data-name="END OF LINE CLUB"></div>
    <div class="location-label" style="top:50%; left:50%; padding-left:25px;">END OF LINE CLUB</div>
    
    <div class="location-marker" style="top:70%; left:75%;" data-name="FLYNN'S SAFEHOUSE"></div>
    <div class="location-label" style="top:70%; left:75%; padding-left:25px;">FLYNN'S SAFEHOUSE</div>
    
    <button id="back-btn" onclick="window.location.href='index.jsp'">RETURN TO MAINFRAME</button>
    
    <script>
        // ========== 3D MAP INIT ==========
        const scene = new THREE.Scene();
        scene.background = new THREE.Color(0x000000);
        
        const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
        camera.position.set(0, 50, 100);
        
        const renderer = new THREE.WebGLRenderer({ antialias: true });
        renderer.setSize(window.innerWidth, window.innerHeight);
        document.getElementById('map-container').appendChild(renderer.domElement);
        
        // Controls
        const controls = new THREE.OrbitControls(camera, renderer.domElement);
        controls.enableDamping = true;
        controls.dampingFactor = 0.05;
        
        // Grid Floor
        const gridSize = 200;
        const gridDivisions = 50;
        const grid = new THREE.GridHelper(gridSize, gridDivisions, 0x00ffe4, 0x00ffe4);
        grid.material.opacity = 0.3;
        grid.material.transparent = true;
        scene.add(grid);
        
        // TRON Landmarks
        const landmarks = [
            { name: "LIGHT CYCLE GARAGE", x: -50, z: -50, color: 0x00ffe4 },
            { name: "END OF LINE CLUB", x: 0, z: 0, color: 0xff6600 },
            { name: "FLYNN'S SAFEHOUSE", x: 50, z: 50, color: 0x00ffe4 }
        ];
        
        landmarks.forEach(landmark => {
            // Tower
            const geometry = new THREE.CylinderGeometry(3, 3, 20, 6);
            const material = new THREE.MeshBasicMaterial({ 
                color: landmark.color,
                wireframe: true,
                transparent: true,
                opacity: 0.8
            });
            const tower = new THREE.Mesh(geometry, material);
            tower.position.set(landmark.x, 10, landmark.z);
            tower.rotation.x = Math.PI / 2;
            scene.add(tower);
            
            // Base
            const baseGeometry = new THREE.CircleGeometry(5, 6);
            const baseMaterial = new THREE.MeshBasicMaterial({
                color: landmark.color,
                side: THREE.DoubleSide,
                transparent: true,
                opacity: 0.3
            });
            const base = new THREE.Mesh(baseGeometry, baseMaterial);
            base.position.set(landmark.x, 0.1, landmark.z);
            base.rotation.x = -Math.PI / 2;
            scene.add(base);
        });
        
        // Animated Light Cycle
        const cycleGeometry = new THREE.ConeGeometry(2, 5, 4);
        const cycleMaterial = new THREE.MeshBasicMaterial({ 
            color: 0x00ffe4,
            wireframe: true
        });
        const lightCycle = new THREE.Mesh(cycleGeometry, cycleMaterial);
        lightCycle.position.set(0, 3, 0);
        lightCycle.rotation.x = Math.PI / 2;
        scene.add(lightCycle);
        
        // Location Marker Interaction
        document.querySelectorAll('.location-marker').forEach(marker => {
            marker.addEventListener('click', () => {
                const name = marker.getAttribute('data-name');
                alert(`NAVIGATING TO: ${name}`);
                
                // Fly camera to location
                const landmark = landmarks.find(l => l.name === name);
                if (landmark) {
                    gsap.to(camera.position, {
                        x: landmark.x,
                        y: 30,
                        z: landmark.z + 30,
                        duration: 2
                    });
                }
            });
        });
        
        // Update Coordinates Display
        function updateCoords() {
            document.getElementById('coords').textContent = 
                `${Math.round(camera.position.x)}, ${Math.round(camera.position.y)}, ${Math.round(camera.position.z)}`;
        }
        
        // Animation Loop
        function animate() {
            requestAnimationFrame(animate);
            
            // Animate light cycle
            lightCycle.position.x = Math.sin(Date.now() * 0.001) * 40;
            lightCycle.position.z = Math.cos(Date.now() * 0.001) * 40;
            lightCycle.rotation.z += 0.02;
            
            controls.update();
            updateCoords();
            renderer.render(scene, camera);
        }
        
        animate();
        
        // Handle Resize
        window.addEventListener('resize', () => {
            camera.aspect = window.innerWidth / window.innerHeight;
            camera.updateProjectionMatrix();
            renderer.setSize(window.innerWidth, window.innerHeight);
        });
    </script>
</body>
</html>
