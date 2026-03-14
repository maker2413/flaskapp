#!/bin/python3

import datetime
import socket
from flask import Flask, jsonify

app = Flask(__name__)

#'/api/v1/details'
@app.route('/api/v1/details')
def details():
    return jsonify({
        'time': datetime.datetime.now().strftime("%I:%M:%S%p on %d %B, %Y"),
        'hostname': socket.gethostname()
    })

#'/api/v1/healthz'
@app.route('/api/v1/healthz')
def health():
    # Do an actual check here
    return jsonify({'status': 'up'}), 200

#'/'
@app.route('/')
def helloWorld():
    # Do an actual check here
    return jsonify({'health': 'world'}), 200

if __name__ == '__main__':
    app.run(host="0.0.0.0")
