import os
import json
from datetime import datetime, timezone
from http.server import SimpleHTTPRequestHandler, HTTPServer

class RequestHandler(SimpleHTTPRequestHandler):
    def do_GET(self):
        # Construct response data
        data = {
            'requested_path': self.path,
            'current_time': datetime.now(timezone.utc).isoformat() + 'Z',
            'env_variables': {k: v for k, v in os.environ.items()},
        }
        response_json = json.dumps(data, indent=2)

        # Send response
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()
        self.wfile.write(response_json.encode())

# Set up the server
if __name__ == '__main__':
    server_address = ('0.0.0.0', 80)
    httpd = HTTPServer(server_address, RequestHandler)
    print(f"Serving on port {server_address[1]}")
    httpd.serve_forever()
