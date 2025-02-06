# log_cpu_ram

```
systemctl enable cron
```

```
systemctl start cron
```

```
mkdir -p ~/logs
```

```
mv log_cpu_ram.sh ~/logs/log_cpu_ram.sh
```

```
chmod +x ~/logs/log_cpu_ram.sh
```

```
crontab -e
```

```
* * * * * ~/logs/log_cpu_ram.sh
```



# or system timer for every second

```
mkdir -p ~/logs
```

```
mv logs/log_cpu_ram.sh ~/logs/log_cpu_ram.sh
```

```
chmod +x ~/logs/log_cpu_ram.sh
```

```
mkdir -p ~/.config/systemd/user
```

```
nano ~/.config/systemd/user/log_cpu_ram.service
```

paste inside:
```
[Unit]
Description=Log CPU, RAM, and Network Usage
After=network.target

[Service]
ExecStart=/bin/bash %h/logs/log_cpu_ram.sh
Restart=always
```

Create a Systemd Timer
```
nano ~/.config/systemd/user/log_cpu_ram.timer
```

```
[Unit]
Description=Run log_cpu_ram.sh every second

[Timer]
OnBootSec=1s
OnUnitActiveSec=1s
AccuracySec=100ms
Unit=log_cpu_ram.service

[Install]
WantedBy=timers.target
```

enable and start timer

```
systemctl --user daemon-reload
```

```
systemctl --user enable log_cpu_ram.service
```

```
systemctl --user enable log_cpu_ram.timer
```

```
systemctl --user start log_cpu_ram.timer
```

```
systemctl --user list-timers --all
```


Verify Logs Are Updating Every Second
```
tail -f ~/logs/$(date +"%Y-%m-%d").txt
```


Start the Timer on Boot for All Users
```
sudo loginctl enable-linger $(whoami)
```

Rebooting check
```
systemctl --user list-timers --all
tail -f ~/logs/$(date +"%Y-%m-%d").txt
```


