#!/bin/bash
# Updated script for Amazon Linux 2023

# Update system
sudo dnf update -y

# Install Nginx
sudo dnf install nginx -y

# Start and enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# AWS Security Groups handle the firewall, so no need for firewalld

echo "Web server setup complete! Visit your EC2 public IP to see Nginx."
