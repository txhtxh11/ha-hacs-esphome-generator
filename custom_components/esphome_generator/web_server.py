"""Web server for ESPHome YAML Generator."""
import logging
import os
from aiohttp import web

_LOGGER = logging.getLogger(__name__)

class ESPHomeWebServer:
    """Web server for ESPHome YAML Generator UI."""
    
    def __init__(self, hass, port=8099):
        self.hass = hass
        self.port = port
        self.runner = None
        self.site = None
        
    async def start(self):
        """Start the web server."""
        app = web.Application()
        
        # Get www directory path
        www_dir = os.path.join(os.path.dirname(__file__), 'www')
        
        async def handle_index(request):
            """Serve the main HTML page."""
            html_path = os.path.join(www_dir, 'index.html')
            try:
                with open(html_path, 'r', encoding='utf-8') as f:
                    content = f.read()
                return web.Response(text=content, content_type='text/html')
            except FileNotFoundError:
                _LOGGER.error(f"HTML file not found: {html_path}")
                return web.Response(text="File not found", status=404)
        
        # Serve static files if needed
        app.router.add_get('/', handle_index)
        
        # Start server
        self.runner = web.AppRunner(app)
        await self.runner.setup()
        self.site = web.TCPSite(self.runner, '0.0.0.0', self.port)
        await self.site.start()
        
        _LOGGER.info(f"ESPHome YAML Generator Web UI started on port {self.port}")
        return True
        
    async def stop(self):
        """Stop the web server."""
        if self.site:
            await self.site.stop()
        if self.runner:
            await self.runner.cleanup()
        _LOGGER.info("ESPHome YAML Generator Web UI stopped")
