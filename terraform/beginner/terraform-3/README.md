AWS EC2 Instance with Security Group (via Terraform)

This project sets up an Ubuntu EC2 instance on AWS using Terraform, including a security group and outputs for the instance details.
I followed “Terraform on AWS: The Ultimate Beginner’s Guide (2025)” on YouTube and adapted it for my own setup:
https://www.youtube.com/watch?v=RiBSzAgt2Hw&list=WL&index=4

What I Did

Configured AWS locally with aws configure

Created an SSH key pair for connecting to the instance

Wrote Terraform code to:

Launch an Ubuntu EC2 instance

Create a security group to allow inbound traffic

Configured Terraform to output:

The public IP address of the web server

The instance ID of the EC2 instance

How to Run

Initialize Terraform:

terraform init


Apply the configuration:

terraform apply


After deployment, check the outputs to get the public IP and instance ID