#!/bin/bash

#bof 35 canceled
#if [[ -n "$SERVER_VERSION" ]]; then
#	echo "SERVER_VERSION is set with the value: $SERVER_VERSION"
#  	#35 canceled# service rabbitmq-server start
#  	#35 canceled# celery -A app.celery worker --loglevel=info
#   	flask run --host=0.0.0.0
#else
#  	echo "SERVER_VERSION is not set."
#  	flask run --host=0.0.0.0
#fi

#bof36
service ssh start
#eof36
python3 service.py &
flask run --host=0.0.0.0
