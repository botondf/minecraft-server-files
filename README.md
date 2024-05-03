# minecraft-server-files
scripts, systemd units, and config files for a Minecraft Spigot server

## Docker
The included dockerfile at `docker/Dockerfile` lets you build the whole configured and updated server. *rcon* does need to be set up with an SSH tunnel, though.

---
## Dependencies
Minecraft 1.20.5+ [requires](https://minecraft.wiki/w/Java_Edition_1.20.5) Java 21+, which will have long-term support (so won't change for a while, let's hope).
The JDK is available from [OpenJDK](https://openjdk.org/projects/jdk/21/) or directly from [Oracle](https://www.oracle.com/java/technologies/downloads/#java21).
*(note: these links may require an Oracle account in the future. However, for now, this is the [Debian direct download](https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb)).*

- invokes the user: `minecraft`, which needs perms to run the following, along with `/bin` programs and the included
scripts
- `curl` to get public IP with `ip-fetch.sh`
- `rclone`, a CLI remote cloud storage interface, to upload backups to Google Drive with `backup.sh`
  - this requires Google authentication*
  - user specific remote for user: `minecraft`
- `mcrcon` at https://github.com/Tiiffi/mcrcon.git, build with *make*, which calls on a C compiler like *gcc*
- Spigot BuildTools (CLI) at https://www.spigotmc.org/wiki/buildtools
- `zip` file compression

*Manual SSH tunnel with another device with browser right now.
Working on automatic HTTP based solution for Google's OAuth 2.0.

---
## Setup
Working directory of server `~/server`, of user `minecraft`, therefore: `/home/minecraft/server`

Open the following ports to the public in your router:
- 25565 TCP
- 8100 TCP

#### *rcon* setup and SSH tunnel:
*rcon* or *mcrcon* is a remote console program that lets you interface with the Minecraft server console with server owner privleges.
IMPORTANT: As such, NEVER open the rcon port set in `server.properties` to the public.
It requires a password but since it will only work on the localhost its not a huge security concern, just make the file `scripts/etc/rcon-passwd` to read-only by only the `minecraft` user

run the command in `scripts/rclone/tunnel`, then access the browser of another machine other than the headless server, log in to the Google account that Drive backups should go to.

#### *rclone* setup:
rclone is an interface between your local machine and the cloud. A remote has to be made on the local machine during rclone setup, this is like a local representation of your cloud storage.

This can be configured as you wish, see the [rclone wiki](https://rclone.org/drive/) for more info.

---
### scripts

Included:
- `stop.sh` gracefully stop server via *rcon*
- `backup-save.sh` pauses auto-saving until all world files zipped
- `backup-upload.sh` uploads zipped backups to Google Drive via *rclone*
- `update-ip.sh` write public IP to file if it changes, then update configs
- `buildtools.sh` fetch new Spigot BuiltTools jar
- `buildserver.sh` build server jar from BuildTools (NOTE: always makes a `spigot.jar` file for script compatibility)
- `update-server.sh` update BuildTools, build new server, and update the world

---
### systemd
location of unit files can be `/lib/systemd/system` or alternatives

relies on user `minecraft` perms for scripts above

Included systemd units:

| Service                    | Use                           | Timer             | Use                                    |
|----------------------------|-------------------------------|-------------------|----------------------------------------|
| `mc.service`               | run server executable         | `mc.timer`        | (optional) server start time           |
| `mc-backup.service`        | save world & zip              | `mc-backup.timer` | time at which backup made and uploaded |
| `mc-backup-upload.service` | upload zip to Google Drive    | n/a               | n/a                                    |
| `mc-stop.service`          | stop & save server gracefully | `mc-stop.timer`   | (optional) server stop time            |
---
### config
included:
- Minecraft
  - `server.properties`
  - for rcon and other setup
- Bluemap
  - `core.conf`, etc.
- DiscordSRV
  - messages, filtering, all the custom options
