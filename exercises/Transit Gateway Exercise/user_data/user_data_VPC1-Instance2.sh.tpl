#!/bin/bash
(
echo "qwe123"
echo "qwe123"
) | passwd --stdin root
sed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sed -i "s/^#PermitRootLogin yes/PermitRootLogin yes/g" /etc/ssh/sshd_config
service sshd restart
hostnamectl --static set-hostname VPC1Instance2
cat <<EOT>> /etc/bashrc
export http_proxy=http://10.0.1.10:3128
export https_proxy=http://10.0.1.10:3128
no_proxy=127.0.0.1,localhost,169.254.169.254,10.0.0.0/8,.internal
EOT