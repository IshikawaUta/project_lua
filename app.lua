local pegasus = require('pegasus')

-- KONFIGURASI SERVER
PORT = os.getenv("PORT") or 9090
local server = pegasus:new({
    port = PORT,
    location = '',
    debug = true
})

-- CSS THEME: TERMINAL/CODER (Updated with Light Mode & Animations)
local CSS = [[
    body { background-color: #0d1117; color: #c9d1d9; font-family: 'Fira Code', 'Courier New', monospace; margin: 0; padding: 20px; line-height: 1.5; transition: 0.3s; }
    .container { max-width: 900px; margin: auto; border: 1px solid #30363d; padding: 25px; border-radius: 8px; background: #161b22; box-shadow: 0 10px 30px rgba(0,0,0,0.5); }
    .terminal-header { color: #58a6ff; border-bottom: 1px solid #30363d; padding-bottom: 12px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; font-size: 0.9em; }
    
    /* Light Mode Overrides */
    body.light-mode { background-color: #f0f2f5; color: #1c2128; }
    body.light-mode .container { background: #ffffff; border-color: #d0d7de; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
    body.light-mode .terminal-header { border-bottom-color: #d0d7de; color: #0969da; }
    body.light-mode pre { background: #f6f8fa; border-color: #d0d7de; color: #24292f; }
    body.light-mode nav a { color: #57606a; }

    /* Controls & Elements */
    #clock { font-weight: bold; color: #7ee787; margin-right: 15px; }
    .toggle-btn { background: #30363d; color: #c9d1d9; border: 1px solid #8b949e; padding: 4px 10px; border-radius: 4px; cursor: pointer; font-size: 0.75em; }
    .status-dot { color: #7ee787; }
    .prompt { color: #7ee787; font-weight: bold; }
    .path { color: #58a6ff; }
    
    nav { margin-bottom: 20px; font-size: 0.9em; border-bottom: 1px solid #21262d; padding-bottom: 10px; }
    nav a { color: #8b949e; text-decoration: none; margin-right: 15px; transition: color 0.3s; }
    nav a:hover { color: #58a6ff; }
    
    pre { background: #010409; padding: 15px; color: #d2a8ff; border-radius: 4px; border: 1px solid #21262d; overflow-x: auto; }
    .project-card { border-left: 3px solid #58a6ff; padding-left: 15px; margin-bottom: 20px; transition: 0.3s; }
    .project-card:hover { transform: translateX(5px); background: rgba(88, 166, 255, 0.05); }
    .badge { background: #238636; color: white; padding: 2px 8px; border-radius: 12px; font-size: 0.75em; margin-right: 5px; }
    
    input, textarea { background: #010409; border: 1px solid #30363d; color: #7ee787; padding: 10px; width: 100%; box-sizing: border-box; margin-top: 10px; font-family: monospace; border-radius: 4px; }
    button.run-btn { background: #238636; color: white; border: none; padding: 10px 20px; margin-top: 15px; cursor: pointer; border-radius: 4px; font-weight: bold; width: 100%; }
]]

-- LAYOUT WRAPPER
local function wrap_layout(content)
    return string.format([[
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>uta09@Terminal_Dev</title>
    <style>%s</style>
</head>
<body>
    <div class="container">
        <div class="terminal-header">
            <span><strong>SESSION:</strong> uta09@kali-linux</span>
            <div>
                <span id="clock">00:00:00</span>
                <button class="toggle-btn" onclick="toggleTheme()">💡 LIGHT_MODE</button>
            </div>
        </div>
        <nav>
            <a href="/">[ 🏠 Home ]</a>
            <a href="/projects">[ 📁 Projects ]</a>
            <a href="/about">[ 👤 About ]</a>
            <a href="/contact">[ ✉️ Contact ]</a>
        </nav>
        <div class="main-content">%s</div>
    </div>
    <script>
        function updateClock() {
            const now = new Date();
            document.getElementById('clock').innerText = now.toTimeString().split(' ')[0];
        }
        setInterval(updateClock, 1000); updateClock();

        function toggleTheme() {
            document.body.classList.toggle('light-mode');
            const btn = document.querySelector('.toggle-btn');
            btn.innerText = document.body.classList.contains('light-mode') ? "🌙 DARK_MODE" : "💡 LIGHT_MODE";
        }
    </script>
</body>
</html>
    ]], CSS, content)
end

-- ROUTES
local routes = {
    ["/"] = [[
        <h3><span class="prompt">uta09@kali:</span><span class="path">~</span>$ neofetch</h3>
        <div style="display: flex; gap: 20px;">
            <pre style="color: #7ee787; border: none; background: transparent;">
   _     _ 
  | |   | |
  | |   | |  
  | |___| |  
  |_____|_|  </pre>
            <div>
                <p><strong>OS</strong>: Kali Linux x86_64</p>
                <p><strong>HOST</strong>: Lua Pegasus Server</p>
                <p><strong>KERNEL</strong>: 5.4.0-stable</p>
                <p><strong>SHELL</strong>: zsh 5.8</p>
            </div>
        </div>
    ]],
    ["/projects"] = [[
        <h3><span class="prompt">uta09@kali:</span><span class="path">~/projects</span>$ ls -lh</h3>
        <div class="project-card">
            <h4>🚀 Pegasus Web Core</h4>
            <p>Engine web berbasis Lua yang sangat ringan dan modular.</p>
            <span class="badge">Lua</span><span class="badge">Web</span>
        </div>
        <div class="project-card">
            <h4>🛡️ Kali Auto-Installer</h4>
            <p>Automated shell script for environment setup.</p>
            <span class="badge">Bash</span><span class="badge">Security</span>
        </div>
    ]],
    ["/about"] = [[
        <h3><span class="prompt">uta09@kali:</span><span class="path">~</span>$ whoami</h3>
        <p>Saya adalah pengembang backend yang berfokus pada otomasi dan sistem berbasis Unix/Linux.</p>
        <pre>Skills: Lua, Python, Bash, Security Hardening</pre>
    ]],
    ["/contact"] = [[
        <h3><span class="prompt">uta09@kali:</span><span class="path">~</span>$ ./contact.sh</h3>
        <p>Kirim pesan langsung via WhatsApp:</p>
        <textarea id="msg" rows="4" placeholder="Input message here..."></textarea>
        <button class="run-btn" onclick="sendWA()">EXECUTE --send</button>
        <script>
            function sendWA() {
                const msgInput = document.getElementById('msg');
                const msg = msgInput.value;
                if(!msg) return alert('Hmmm... Gk Boleh Kosong Ngab!!');
                window.open("https://wa.me/62895701060973?text=" + encodeURIComponent(msg));
                msgInput.value = '';
            }
        </script>
    ]],
}
routes["/index.html"] = routes["/"]

-- START SERVER
print("\27[32m[OK]\27[0m Server running at http://localhost:" .. PORT)
server:start(function(req, res)
    local path = req:path()
    local content = routes[path] or "<div style='color:#ff7b72'>404: Command Not Found</div>"
    res:write(wrap_layout(content))
end)