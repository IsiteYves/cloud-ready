# Strettch Cloud - Quick Deploy Script

I created this simple bash script that automates the initial setup of a web server on a Strettch Cloud compute instance. It takes care of system updates, installs Nginx, configures a basic firewall, and sets up a custom landing page to confirm that the deployment is live. I tested this on a linux environment I already have, and `stretcch cloud` also offers Linux 24.04 that you can use in the same way!

## Features
- Updates and upgrades system packages.
- Installs and enables Nginx.
- Configures UFW firewall to allow SSH and Nginx traffic.
- Includes a service health check to verify Nginx status.
- Replaces the default welcome page with a custom Strettch-branded template.

## Usage

1. SSH into your Strettch Compute instance:
   ssh root@your_instance_ip

2. Download the script:
   curl -O https://raw.githubusercontent.com

3. Make it executable:
   chmod +x strettch-init.sh

4. Run with sudo:
   sudo ./strettch-init.sh

## Why this exists
Setting up a new VM usually requires the same manual steps. This script cuts the "time-to-hello-world" on Strettch Cloud to under 60 seconds and ensures the instance is secure and functional right after creation.

## Next Steps
- Add SSL support using Certbot.
- Integrate with a Node.js or Python backend deployment.