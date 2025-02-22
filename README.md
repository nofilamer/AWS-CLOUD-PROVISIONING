# AWS Cloud Instance Launch & Management Guide

This repository provides instructions for launching and managing AWS EC2 instances using the AWS Management Console and AWS CLI. Additionally, it includes steps for setting up the AWS CLI on a Mac laptop and configuring Vagrant with Parallels instead of VirtualBox.

## Table of Contents

- [AWS Account Setup](#aws-account-setup)
- [Launching an AWS EC2 Instance (Console)](#launching-an-aws-ec2-instance-console)
- [Setting Up AWS CLI on Mac](#setting-up-aws-cli-on-mac)
- [Launching an AWS EC2 Instance (CLI)](#launching-an-aws-ec2-instance-cli)
- [Setting Up Vagrant with Parallels on Mac](#setting-up-vagrant-with-parallels-on-mac)
- [Managing AWS Resources](#managing-aws-resources)

---

## AWS Account Setup

1. **Create an AWS Account**:  
   - Visit [AWS Console](https://console.aws.amazon.com) and sign up.
   - AWS Free Tier provides limited free resources: [AWS Free Tier](https://aws.amazon.com/free/).
   - A credit card is required but will not be charged if Free Tier resources are used.

2. **Create an IAM User** (recommended instead of using root credentials):  
   - Navigate to **IAM** service in AWS Console.
   - Create a new user with **Administrator Access**.
   - Generate and securely store the **Access Key ID** and **Secret Access Key**.

---

## Launching an AWS EC2 Instance (Console)

1. **Login to AWS Console**: [AWS Console](https://console.aws.amazon.com).
2. **Launch a New Instance**:
   - Click **Launch Instance**.
   - Select an Amazon Machine Image (AMI).
   - Choose **t2.micro** (Free Tier eligible).
3. **Configure Security Group**:
   - Create a new security group.
   - Add inbound rules:
     - SSH (port 22)
     - HTTP (port 80)
     - HTTPS (port 443)
   - (Optional) Add additional custom TCP rules.
4. **Create and Download Key Pair**:
   - Name the key (e.g., `mysshkey`).
   - Download the `.pem` file for SSH access.
5. **Launch the Instance**.
6. **Access the Instance via SSH**:
   ```sh
   ssh -i mysshkey.pem ubuntu@your-ec2-instance-public-ip

Setting Up AWS CLI on Mac
Install AWS CLI:
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /

Configure AWS CLI:
aws configure

Verify AWS Authentication:
aws ec2 describe-regions

Launching an AWS EC2 Instance (CLI)
Find the Amazon Machine Image (AMI) ID:
aws ec2 describe-images --owners amazon
aws ec2 run-instances --image-id ami-033a3273401a27142 --instance-type t2.micro --key-name mysshkey --security-groups my-security-group --region us-east-1
aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId,PublicIpAddress]" --output table
ssh -i mysshkey.pem ubuntu@your-ec2-instance-public-ip

Setting Up Vagrant with Parallels on Mac
Install Homebrew (if not already installed):
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install parallels
brew install hashicorp/tap/vagrant
vagrant plugin install vagrant-parallels
mkdir my-vagrant-project && cd my-vagrant-project
vagrant init bento/ubuntu-20.04
vagrant up --provider=parallels
vagrant ssh

Managing AWS Resources
Listing Instances
aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId,PublicIpAddress]" --output table

Stopping an Instance
aws ec2 stop-instances --instance-ids <instance-id>

Terminating an Instance
aws ec2 terminate-instances --instance-ids <instance-id>

Managing S3 Buckets
Create a Bucket:
aws s3api create-bucket --bucket my-unique-bucket-name --region us-east-1

Upload a File:
aws s3 cp myfile.txt s3://my-unique-bucket-name/

List Files in a Bucket:
aws s3 ls s3://my-unique-bucket-name/

Download a File:
aws s3 cp s3://my-unique-bucket-name/myfile.txt .

Cleanup Resources
Terminate Instances
aws ec2 terminate-instances --instance-ids <instance-id>

Delete S3 Bucket
aws s3 rb s3://my-unique-bucket-name --force

License
This repository is licensed under the MIT License.


