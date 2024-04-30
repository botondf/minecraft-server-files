FROM debian
COPY . /app
WORKDIR /app
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get -y install curl git gcc make default zip rclone vim default-jre
RUN apt-get clean
#ENV container docker
#STOPSIGNAL SIGRTMIN+3
RUN useradd minecraft -m
WORKDIR /home/minecraft
RUN git clone https://github.com/botondf/minecraft-server-files.git server
WORKDIR /home/minecraft/server/scripts
RUN git clone https://github.com/Tiiffi/mcrcon.git rcon
WORKDIR /home/minecraft/server/scripts/rcon/
RUN make
WORKDIR /home/minecraft/scripts
RUN ./buildtools.sh
RUN ./buildserver.sh
WORKDIR /home/minecraft/
RUN date > finished_time.txt
CMD [ "/bin/bash", "echo Hello"]