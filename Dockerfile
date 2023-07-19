# syntax=docker/dockerfile:1

FROM python:3.8-slim-buster

WORKDIR /app

COPY requirements.txt requirements.txt
COPY run.sh run.sh

RUN apt-get update -y
RUN pip3 install --upgrade pip 
RUN pip3 install -r requirements.txt

RUN .rabbit/install.sh

COPY . .

CMD ["bash", "run.sh"]
