FROM debian
COPY . /app
WORKDIR /app
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get -y install git make gcc
RUN apt-get clean
RUN useradd minecraft -m
WORKDIR /home/minecraft
RUN git clone https://github.com/botondf/minecraft-server-files.git server

WORKDIR /home/minecraft/server
RUN git clone https://github.com/Tiiffi/mcrcon.git scripts/rcon
RUN make scripts/rcon/mcrcon