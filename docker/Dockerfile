FROM debian
COPY . /app

WORKDIR /app
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get -y install curl git gcc make zip rclone vim
# (optional but breakes for MC 1.20.5+) debian packaged Java. Lags behind Oracle releases.
#RUN apt-get -y default-jre
# direct download of Java (hardcoded link for ver 21!)
RUN curl -O https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb
RUN dpkg -i jdk-21_linux-x64_bin.deb
RUN rm jdk-21_linux-x64_bin.deb
RUN apt-get clean

# generate server user
RUN useradd minecraft -m
WORKDIR /home/minecraft

# clone build files
RUN git clone https://github.com/botondf/minecraft-server-files.git server

WORKDIR /home/minecraft/server
# clone and build mcrcon files
RUN git clone https://github.com/Tiiffi/mcrcon.git scripts/rcon
RUN make scripts/rcon/mcrcon


WORKDIR /home/minecraft
# set perms for server folders
RUN chown -R minecraft:minecraft .

WORKDIR /home/minecraft/server/scripts
# set minecraft user-only exec perms for server scripts
RUN chmod u+x *.sh

# user mode building
WORKDIR /home/minecraft/server
USER minecraft
RUN ./buildtools.sh
RUN ./buildserver.sh
#RUN chown -R minecraft:minecraft .

# systemd config as root
USER root
WORKDIR /home/minecraft/server/systemd/services
RUN echo "Configuring systemd to start the server automatically..."
RUN systemctl enable mc.service mc-backup.service mc-backup-upload.service mc-ip.service mc-stop.service
RUN systemctl enable mc.timer mc-backup.timer mc-ip.timer mc-stop.timer
RUN systemctl daemon-reload
RUN systemctl start mc.service mc-backup.service mc-backup-upload.service mc-ip.service
RUN systemctl start mc.timer mc-backup.timer mc-ip.timer mc-stop.timer
RUN systemctl daemon-reload

# return to user mode
WORKDIR /home/minecraft/server
USER minecraft
RUN echo "Server build and configuration is complete. Ready to play!"
