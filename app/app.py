# app.py
from flask import Flask, request, jsonify
from datetime import datetime

app = Flask(__name__)

@app.route('/')
def get_time():
    ip = request.headers.get('X-Forwarded-For', request.remote_addr)
    return jsonify({
        "timestamp": datetime.utcnow().isoformat(),
        "ip": ip
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)


