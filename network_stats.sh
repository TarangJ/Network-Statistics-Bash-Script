#!/bin/bash

# Network Statistics Bash Script

echo "Network Statistics:"

# Get the default gateway
echo "Default Gateway: $(ip route | grep default | awk '{print $3}')"

# Get the primary DNS server
echo "Primary DNS Server: $(cat /etc/resolv.conf | grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' | head -n 1)"

# Get the external IP address
echo "External IP Address: $(curl -s https://api.ipify.org)"

# Get the network interface information
echo "Network Interfaces:"
ip link show | awk -F': ' '{print $2}' | while read -r iface; do
    echo "- $iface: $(ip addr show $iface | grep 'inet\b' | awk '{print $2}' | head -n 1)"
done

# Get network statistics
echo "Network Statistics:"
echo "- Total Bytes Received: $(cat /sys/class/net/*/statistics/rx_bytes | paste -sd+ | bc)"
echo "- Total Bytes Transmitted: $(cat /sys/class/net/*/statistics/tx_bytes | paste -sd+ | bc)"
echo "- Total Packets Received: $(cat /sys/class/net/*/statistics/rx_packets | paste -sd+ | bc)"
echo "- Total Packets Transmitted: $(cat /sys/class/net/*/statistics/tx_packets | paste -sd+ | bc)"
