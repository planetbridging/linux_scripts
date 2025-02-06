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
mv ~/log_cpu_ram.sh ~/logs/log_cpu_ram.sh
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
