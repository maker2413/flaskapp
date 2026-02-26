#!/bin/python3

from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def home():
    return "The app works! Please git the '<ip>/hello/<your name>' endpoint to see it in action!\n"

@app.route('/hello/<user>')
def hello(user):
    return jsonify(response= "Hello there, %s" % user)
