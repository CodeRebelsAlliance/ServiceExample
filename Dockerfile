# syntax=docker/dockerfile:1

FROM python:3.8-slim-buster

WORKDIR /app

#VOLUME ["/app/data", "/app/MusicDownloads"]

COPY requirements.txt requirements.txt
COPY run.sh run.sh
RUN apt-get update
RUN apt-get --yes install git
RUN pip3 install --upgrade pip 
RUN pip3 install -r requirements.txt
#71 Downloader broken
#RUN pip3 uninstall -y pytube
#RUN pip3 install git+https://github.com/oncename/pytube.git

RUN apt-get --yes install ffmpeg

USER root
#RUN if id sftpuser; then exit 0; else useradd -m -d /home/sftpuser -s /usr/sbin/nologin sftpuser; fi
#ENV DEBIAN_FRONTEND noninteractive
#RUN apt-get update && apt-get install -y --no-install-recommends openssh-server && \
#    mkdir /var/run/sshd && \
#    echo 'sftpuser:password' | chpasswd
#RUN echo "Match User sftpuser\n\
#          ForceCommand internal-sftp\n\
#          ChrootDirectory /app/MusicDownloads\n\
#          PermitTunnel no\n\
#          AllowAgentForwarding no\n\
#          AllowTcpForwarding no\n\
#          X11Forwarding no" >> /etc/ssh/sshd_config
#RUN chown root:root /home/sftpuser
#RUN chmod 755 /home/sftpuser

#EXPOSE 22

RUN apt-get install curl gnupg apt-transport-https -y

## Team RabbitMQ's main signing key
RUN curl -1sLf "https://keys.openpgp.org/vks/v1/by-fingerprint/0A9AF2115F4687BD29803A206B73A36E6026DFCA" | sudo gpg --dearmor | sudo tee /usr/share/keyrings/com.rabbitmq.team.gpg > /dev/null
## Community mirror of Cloudsmith: modern Erlang repository
RUN curl -1sLf https://ppa1.novemberain.com/gpg.E495BB49CC4BBE5B.key | sudo gpg --dearmor | sudo tee /usr/share/keyrings/rabbitmq.E495BB49CC4BBE5B.gpg > /dev/null
## Community mirror of Cloudsmith: RabbitMQ repository
RUN curl -1sLf https://ppa1.novemberain.com/gpg.9F4587F226208342.key | sudo gpg --dearmor | sudo tee /usr/share/keyrings/rabbitmq.9F4587F226208342.gpg > /dev/null

## Add apt repositories maintained by Team RabbitMQ
RUN tee /etc/apt/sources.list.d/rabbitmq.list <<EOF
## Provides modern Erlang/OTP releases
##
RUN deb [signed-by=/usr/share/keyrings/rabbitmq.E495BB49CC4BBE5B.gpg] https://ppa1.novemberain.com/rabbitmq/rabbitmq-erlang/deb/ubuntu jammy main
RUN deb-src [signed-by=/usr/share/keyrings/rabbitmq.E495BB49CC4BBE5B.gpg] https://ppa1.novemberain.com/rabbitmq/rabbitmq-erlang/deb/ubuntu jammy main

## Provides RabbitMQ
##
RUN deb [signed-by=/usr/share/keyrings/rabbitmq.9F4587F226208342.gpg] https://ppa1.novemberain.com/rabbitmq/rabbitmq-server/deb/ubuntu jammy main
RUN deb-src [signed-by=/usr/share/keyrings/rabbitmq.9F4587F226208342.gpg] https://ppa1.novemberain.com/rabbitmq/rabbitmq-server/deb/ubuntu jammy main

## Update package indices
RUN sudo apt-get update -y

## Install Erlang packages
RUN sudo apt-get install -y erlang-base \
                        erlang-asn1 erlang-crypto erlang-eldap erlang-ftp erlang-inets \
                        erlang-mnesia erlang-os-mon erlang-parsetools erlang-public-key \
                        erlang-runtime-tools erlang-snmp erlang-ssl \
                        erlang-syntax-tools erlang-tftp erlang-tools erlang-xmerl

## Install rabbitmq-server and its dependencies
RUN sudo apt-get install rabbitmq-server -y --fix-missing

COPY . .

CMD ["bash", "run.sh"]
