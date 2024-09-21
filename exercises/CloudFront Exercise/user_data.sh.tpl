# user_data.sh.tpl

#!/bin/bash
# Set root password
echo "root:qwe123" | chpasswd

# Enable Password Authentication and Permit Root Login
sed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/" /etc/ssh/sshd_config
sed -i "s/^#PermitRootLogin yes/PermitRootLogin yes/" /etc/ssh/sshd_config

# Restart SSH service
systemctl restart sshd

# Download test.jpg
wget https://raw.githubusercontent.com/Macer-Park/macer.github.io/main/test.jpg -O /home/ec2-user/test.jpg
wget https://raw.githubusercontent.com/Macer-Park/macer.github.io/main/test.jpg -P /usr/share/nginx/html/

# Install Nginx
amazon-linux-extras install -y nginx1.12

# Create custom index.html
cat <<EOF > /usr/share/nginx/html/index.html
<head>
  <link rel='icon' href='data:;base64,iVBORw0KGgo='>
</head>
<h1>Macer CloudFront Test!!</h1>
<img src='test.jpg'>
EOF

# Start and enable Nginx
systemctl start nginx
systemctl enable nginx
