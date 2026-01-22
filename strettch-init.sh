#!/bin/bash

# A simple deploy script for Strettch Cloud Beta
# Author: Yves Isite
# We check if running as root

if [ "$EUID" -ne 0 ]; then

echo "Error: Please run with sudo"

exit

fi

echo "--- Starting setup ---"

# Standard updates

apt update && apt upgrade -y

# Get Nginx on the box

apt install nginx -y

# We open port 80 and 443, and keep 22 open so we don't get locked out

echo "Configuring firewall rules..."

ufw allow ssh

ufw allow 'Nginx Full'

echo "y" | ufw enable

# do a quick check to see if Nginx is actually up

STATUS=$(systemctl is-active nginx)

if [ "$STATUS" = "active" ]; then

echo "Nginx is running fine."

else

echo "Something went wrong, Nginx is not active. Checking logs..."

journalctl -u nginx --no-pager | tail -n 10

exit 1

fi

# Swap out the default welcome page for a Strettch-specific one

cat <<EOF > /var/www/html/index.html

<!DOCTYPE html>
<html>
<body style="background: #111; color: white; font-family: sans-serif; display: flex; align-items: center; justify-content: center; height: 100vh;">
<div style="border: 1px solid #444; padding: 2rem; border-radius: 8px;">
<h2>Deployment Successful</h2>
<p>This instance is now running on <strong>Strettch Cloud</strong>.</p>
<p>Server Time: $(date)</p>
</div>
</body>
</html>

EOF

echo "Done. Site is live at: $(curl -s ifconfig.me)"
