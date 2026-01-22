#!/bin/bash

# Simple deploy script - Container Friendly Version
if [ "$EUID" -ne 0 ]; then 
  echo "Error: Please run with sudo"
  exit
fi

echo "--- Starting setup ---"
apt update && apt install nginx -y

# Use 'service' instead of 'systemctl' for better compatibility
service nginx start

# Check status without systemd
STATUS=$(service nginx status)
if [[ $STATUS == *"is running"* ]]; then
    echo "Nginx is running fine."
else
    echo "Nginx failed to start."
    exit 1
fi

# Create landing page
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<body style="background: #111; color: white; font-family: sans-serif; display: flex; align-items: center; justify-content: center; height: 100vh;">
    <div style="border: 1px solid #444; padding: 2rem; border-radius: 8px;">
        <h2>Deployment Successful</h2>
        <p>Verified on Strettch-compatible architecture.</p>
        <p>Server Time: $(date)</p>
    </div>
</body>
</html>
EOF

echo "Setup complete."
