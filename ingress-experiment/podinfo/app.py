from flask import Flask, Response
import os
from datetime import datetime, timezone
import json

app = Flask(__name__)

def info(subpath):
    data = {
        'requested_path': subpath,
        'current_time': datetime.now(timezone.utc).isoformat() + 'Z',
        'env_variables': {k: v for k, v in os.environ.items()},
    }
    response_json = json.dumps(data, indent=2)
    return Response(response_json, mimetype='application/json')

@app.route('/', methods=['GET'])
def root():
    return info('/')

@app.route('/<path:subpath>', methods=['GET'])
def catch_all(subpath):
    return info(subpath)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
