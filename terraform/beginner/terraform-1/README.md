Terraform AWS S3 Bucket

This project provisions an Amazon S3 bucket using Terraform. It’s a simple Infrastructure-as-Code (IaC) example for managing cloud resources in AWS.

Features

Creates an S3 bucket in AWS

Configurable bucket name and region through variables



Tech Stack

Terraform

AWS

Prerequisites

Terraform installed

AWS account with credentials configured (aws configure)

IAM permissions to create S3 buckets

Usage


Initialize Terraform with terraform init

Preview changes with terraform plan

Apply the configuration with terraform apply

Destroy resources with terraform destroy


README.md – Project documentation

Variables

bucket_name – Name of the S3 bucket (default: my-terraform-bucket-12345)

region – AWS region to deploy into (default: us-east-1)
