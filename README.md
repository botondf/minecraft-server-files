# minecraft-server-files
scripts, systemd units and config files for minecraft servers

---
## Dependencies
- invokes the user: `minecraft`, which needs perms to run the following, along with `/bin` programs and the included
scripts 
- `curl` to get public IP with `ip-fetch.sh`
- `rclone`, a CLI remote cloud storage interface, to upload backups to Google Drive with `backup.sh`
  - this requires Google authentication*
  - user: `minecraft`

*Manual SSH tunnel with another device with browser right now.
Working on automatic HTTP based solution.
---
## Setup
working directory of server: `/home/botond/servers/minecraft/survival-2022`

---
### scripts

included:
- `rcon.sh`
- `start.sh`
- `stop.sh`
- `backup.sh`
- `fetch-ip.sh`

---
### systemd
location of unit files can be `/lib/systemd/system` or alternatives

relies on user `minecraft` perms for scripts above

included:
- `backup.sh`
---
### config
included:
- Minecraft
  - `server.properties`
- Bluemap
  - `core.conf`, etc.
- DiscordSRV
  - messages, filtering, all the custom options