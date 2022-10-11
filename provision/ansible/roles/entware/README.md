# entware

Install entware `opkg` package manager.

Roles built from [this instructions](https://github.com/Entware/Entware/wiki/Install-on-Synology-NAS)

**Manual step required**

- Goto: DSM > Control Panel > Task Scheduler
- Create > Triggered Task > User Defined Script
  - General
    - Task: Entware
    - User: root
    - Event: Boot-up
    - Pretask: none
  - Task Settings
    - Run Command: (see bellow)

```bash
#!/bin/sh

# Re-mount Entware
mkdir -p /opt
mount -o bind "/volume1/@Entware/opt" /opt

# Autostart
# /opt/etc/init.d/rc.unslung start
```
