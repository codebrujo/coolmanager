# coolmanager

coolmanager RPi OS servise controls external fan via pin 15

## Usefull terminal commands

### bash commands to manage pin manually

pinctrl help
pinctrl set 15 op dh
pinctrl get 15
pinctrl set 15 op dl

### bash command to extract and display temperature manually

cpu=$(</sys/class/thermal/thermal_zone0/temp) && echo "$((cpu/1000))"

### Load CPU

sudo apt-get install sysbench
sysbench --test=cpu --cpu-max-prime=200000000 run

## Service files

coolmanager.sh - management script
monitor.sh - temperature monitor and debug script
coolmanager.service - service configuration

## install service

### Commands to install

chmod -v +x coolmanager.sh
sudo cp coolmanager.sh /usr/bin/
sudo cp coolmanager.service /etc/systemd/system/
sudo systemctl enable coolmanager.service
sudo systemctl start coolmanager

### Commands to verify

systemctl status coolmanager.service

### Service commands

systemctl start coolmanager
systemctl stop coolmanager
systemctl restart coolmanager

### Service run parameters

Write log:
./coolmanager.sh -l

Write output if manually started:
./coolmanager.sh -p
