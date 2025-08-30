# Linux Automation for AWS EC2

This repository contains scripts to automate Linux setup on AWS EC2 instances.  
The included script installs and configures a basic web server (Nginx) and sets up the firewall.

## Usage

1. Launch an Amazon Linux 2 EC2 instance.
2. Connect via SSH:
   ```bash
   ssh -i your-key.pem ec2-user@your-ec2-ip
