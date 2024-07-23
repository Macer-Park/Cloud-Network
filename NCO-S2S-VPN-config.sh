#!/bin/sh
printf "Enter CGW Public (or Elastic) IP: "
read word1
printf "Enter External IP of VGW's Tunnel1: "
read word2

cat <<EOF> /etc/ipsec.d/aws.conf
conn Tunnel1
  authby=secret
  auto=start
  left=%defaultroute
  leftid="$word1"
  right="$word2"
  type=tunnel
  ikelifetime=8h
  keylife=1h
  phase2alg=aes128-sha1;modp1024
  ike=aes128-sha1;modp1024
  keyingtries=%forever
  keyexchange=ike
  leftsubnet=10.60.0.0/16
  rightsubnet=10.50.0.0/16
  dpddelay=10
  dpdtimeout=30
  dpdaction=restart_by_peer
EOF

cat <<EOF> /etc/ipsec.d/aws.secrets
$word1 $word2 : PSK "cloudneta"
EOF

printf "Start VPN Service.\n"
systemctl start ipsec
systemctl enable ipsec

printf "VPN Configuration has completed.\n"
printf "Please Check cat /etc/ipsec.d/aws.conf\n"
printf "Please Check cat /etc/ipsec.d/aws.secrets\n"
