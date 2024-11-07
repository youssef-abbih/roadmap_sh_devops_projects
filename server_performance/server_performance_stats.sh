#!/bin/bash
top -bn1 | grep "Cpu(s)" | awk '{print "Total CPU Usage: " $2 + $4 "%\n"}'

# Memory in Gi
free -h | awk 'NR==2 {print "Free Memory: " $4, "\nUsed Memory: " $3, "\nTotal Memory: " $2 "\n"}'

# Memory Percent
free | awk 'NR==2 {printf "Percent Used Memory: %.2f%%\nPercent Free Memory: %.2f%%\n", $3/$2*100, $4/$2*100}'
echo
# Disk Percent
df | awk '/\/dev\/(nvme|sd)/ {printf "Percent Used Disk %s: %.2f%%\nPercent Available Disk %s: %.2f%%\n", $1, $3/$2*100, $1, $4/$2*100}'
echo
# Disk in Gi
df -h | awk '/\/dev\/(nvme|sd)/ {print "Used Disk " $1 ": " $3, "\nAvailable Disk " $1 ": " $4, "\nTotal Disk " $1 ": " $2 "\n"}'


echo -e "Top 5 Processes by CPU usage:\n"
ps -eF --sort=-c |awk '{print $2,$11}'| head -n 6 | column -t
echo

echo -e "Top 5 Processes by Memory usage:\n"
ps -eF --sort=-rss |awk '{print $2,$11}'| head -n 6 | column -t
echo

grep -E '^NAME=|^VERSION=' /etc/os-release
echo "Uptime: $(uptime)"

