#!/bin/bash -v
hostnamectl --static set-hostname ${host}-EC2-${instance_number}
yum install httpd -y
service httpd start
chkconfig httpd on
echo "<h1>Macer-Park ${host} Web Server_${instance_number}</h1>" > /var/www/html/index.html
