#!/bin/bash

python3 -m venv .venv

VENV_ACTIVATE=".venv/bin/activate"
source "$VENV_ACTIVATE"

pip3 install -r requirements.txt 
