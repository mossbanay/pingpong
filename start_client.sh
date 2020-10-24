#!/usr/bin/env bash

set -e

cd client && source .venv/bin/activate
pip install -r requirements.txt
python client.py
