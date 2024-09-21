#!/bin/bash
# Download test.jpg (Ensure URLs are correct)
sudo wget https://raw.githubusercontent.com/Macer-Park/macer.github.io/main/resources/test.jpg -O /home/ec2-user/test.jpg
sudo wget https://raw.githubusercontent.com/Macer-Park/macer.github.io/main/resources/test.jpg -P /usr/share/nginx/html/

# Install Nginx (Install latest available version)
amazon-linux-extras install -y nginx1 > /var/log/nginx_install.log 2>&1

# Create custom index.html
cat <<EOF > /usr/share/nginx/html/index.html
<head>
  <link rel='icon' href='data:;base64,iVBORw0KGgo='>
</head>
<h1>Macer CloudFront Test!!</h1>
<img src='test.jpg'>
EOF

# Start and enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx
