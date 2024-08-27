FROM debian
COPY . /app
WORKDIR /app
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get -y install curl git gcc make zip rclone vim
# debian packaged Java, will be outdated for new Minecraft
#RUN apt-get -y default-jre

# direct download of Java (hardcoded link!)
RUN curl -O https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb
RUN dpkg -i jdk-21_linux-x64_bin.deb
RUN rm jdk-21_linux-x64_bin.deb

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

# user mode from now
USER minecraft
RUN ./buildtools.sh
RUN ./buildserver.sh
#RUN chown -R minecraft:minecraft .

WORKDIR /home/minecraft/server