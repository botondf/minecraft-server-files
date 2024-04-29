# minecraft-server-files
scripts, systemd units, and config files for a Minecraft Spigot server

---
## Dependencies
- invokes the user: `minecraft`, which needs perms to run the following, along with `/bin` programs and the included
scripts 
- `curl` to get public IP with `ip-fetch.sh`
- `rclone`, a CLI remote cloud storage interface, to upload backups to Google Drive with `backup.sh`
  - this requires Google authentication*
  - user: `minecraft`
- `mcrcon` at https://github.com/Tiiffi/mcrcon.git, build with *gcc*
- Spigot BuildTools (CLI) at https://www.spigotmc.org/wiki/buildtools
- `zip` file compression

*Manual SSH tunnel with another device with browser right now.
Working on automatic HTTP based solution for Google's OAuth 2.0.

---
## Setup
Working directory of server: `/home/botond/servers/minecraft/survival-2022`
to `/home/minecraft/survival`
Open the following ports:
- 25565 TCP
- 8100 TCP

---
### scripts

Included:
- `stop.sh` gracefully stop server via *rcon*
- `backup-save.sh` pauses auto-saving until all world files zipped
- `backup-upload.sh` uploads zipped backups to Google Drive via *rclone*
- `update-ip.sh` write public IP to file if it changes then update configs
- `buildtools.sh` fetch new Spigot BuiltTools jar
- `buildserver.sh` build server jar from BuildTools (NOTE: always makes a `spigot.jar` file for script compatibility)
- `update-server.sh` fetch new BuildTools and build new server (runs above two sequentially,
`buildtools.sh` then `buildserver.sh`)

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
- Bluemap
  - `core.conf`, etc.
- DiscordSRV
  - messages, filtering, all the custom options