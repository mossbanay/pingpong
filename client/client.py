import json
import time

from collections import namedtuple
from pythonping import ping

import requests
import sys

SERVER_IP = "127.0.0.1"
SERVER_PORT = "9001"

if len(sys.argv) > 1:
    SERVER_IP = sys.argv[-1]

API_ROOT = f"http://{SERVER_IP}:{SERVER_PORT}"

REGION_NAME = "UNKNOWN"
IP = requests.get(f"{API_ROOT}/get_ip").text

Node = namedtuple("Node", "ip region_name")
Event = namedtuple("Event", "timestamp origin_ip dest_ip time")

requests.get(f"{API_ROOT}/register_node?ip={IP}&region_name={REGION_NAME}")


def get_nodes():
    url = f"http://{SERVER_IP}:{SERVER_PORT}/get_nodes"
    resp = requests.get(url)

    raw_nodes = json.loads(resp.text)
    nodes = []

    for raw_node in raw_nodes:
        print(raw_node)
        node = Node(raw_node["ip"], raw_node["region_name"])
        nodes.append(node)

    print(f"Loaded nodes: {nodes}")

    return nodes


def submit_event(event):
    base_url = f"http://{SERVER_IP}:{SERVER_PORT}/register_event"
    query_string = "?" + "&".join(
        list(map(lambda x: f"{x[0]}={x[1]}", dict(event._asdict()).items()))
    )
    url = base_url + query_string

    requests.get(url)


while True:
    nodes = get_nodes()

    for node in nodes:
        resp = ping(node.ip, count=1)
        event = Event(
            timestamp=int(time.time()),
            origin_ip=IP,
            dest_ip=node.ip,
            time=resp.rtt_avg_ms,
        )
        submit_event(event)

    time.sleep(1)
