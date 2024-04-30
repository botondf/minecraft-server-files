FROM debian
COPY . /app
WORKDIR /app
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get -y install curl git gcc make zip rclone vim default-jre
RUN apt-get clean
RUN useradd minecraft -m
WORKDIR /home/minecraft
RUN git clone https://github.com/botondf/minecraft-server-files.git server

WORKDIR /home/minecraft/server
RUN git clone https://github.com/Tiiffi/mcrcon.git scripts/rcon
RUN make scripts/rcon/mcrcon

WORKDIR /home/minecraft
RUN chown -R minecraft:minecraft .

WORKDIR /home/minecraft/server/scripts
RUN chmod u+x *.sh

USER minecraft
RUN ./buildtools.sh
RUN ./buildserver.sh
#RUN chown -R minecraft:minecraft .

WORKDIR /home/minecraft/server