Terraform AWS EC2 Instances (Ubuntu)

This project provisions two Ubuntu-based Amazon EC2 instances using Terraform. It demonstrates my work in deploying compute resources in AWS with Infrastructure-as-Code.

Adapted from the YouTube tutorial "Terraform Tutorial on AWS - Getting Started".

Features

Provisioned two EC2 instances on AWS

Configurable instance type, region, and Ubuntu AMI

Prerequisites

Terraform installed (v1.0+)

AWS credentials configured (aws configure)

Valid Ubuntu AMI ID for your region

What I Did

Defined Terraform configuration to create EC2 instances

Configured variables for instance type, Ubuntu AMI, and region

Tested deployment using terraform plan and terraform apply

Cleaned up resources with terraform destroy

Usage

Clone the repository

Update the variables file with Ubuntu AMI ID and region

Initialize Terraform: terraform init

Preview changes: terraform plan

Apply configuration: terraform apply

Destroy resources: terraform destroy


README.md – Documentation