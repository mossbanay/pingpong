import json

from collections import namedtuple

from app import app
from flask import request, abort

Node = namedtuple("Node", "ip region_name")
NODES = []

Event = namedtuple("Event", "timestamp origin_ip dest_ip time")
EVENTS = []


@app.route("/")
def index():
    return "index"


@app.route("/get_ip")
def get_ip():
    return request.remote_addr


@app.route("/get_nodes")
def get_nodes():
    return json.dumps(list(map(lambda x: dict(x._asdict()), NODES)))


@app.route("/get_events")
def get_events():
    return json.dumps(list(map(lambda x: dict(x._asdict()), EVENTS)))


@app.route("/register_node")
def register_node():
    args = request.args

    if "ip" not in args or "region_name" not in args:
        abort(400)

    node = Node(args["ip"], args["region_name"])
    NODES.append(node)

    return ""


@app.route("/register_event")
def register_event():
    args = request.args

    if (
        "timestamp" not in args
        or "origin_ip" not in args
        or "dest_ip" not in args
        or "time" not in args
    ):
        abort(400)

    event = Event(args["timestamp"], args["origin_ip"], args["dest_ip"], args["time"])
    EVENTS.append(event)

    return ""


@app.errorhandler(400)
def bad_request(_):
    return "400 error", 400
