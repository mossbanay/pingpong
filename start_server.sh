#!/usr/bin/env bash

set -e

cd server && source .venv/bin/activate
pip install -r requirements.txt
flask run
