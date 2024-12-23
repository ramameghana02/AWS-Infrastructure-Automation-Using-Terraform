# AWS Infrastructure Automation Using Terraform
1. Project Overview

The goal of this project is to automate the deployment of an AWS cloud infrastructure for multiple environments (Development, Staging, and Production) using Terraform. The setup includes networking, compute resources, storage, and application load balancing. This automation ensures consistency, scalability, and reduced manual errors.

Key Components

Networking:

Virtual Private Cloud (VPC) with public and private subnets.

Internet Gateway (IGW) and NAT Gateway for internet access.

Security Groups to control traffic flow.

Compute:

EC2 instances for running applications.

Instances are tagged for easy identification and management.

Storage:

EBS volumes attached to EC2 instances for persistent storage.

Automated formatting and mounting of volumes.

Load Balancing:

Application Load Balancers (ALBs) for distributing traffic across EC2 instances in Staging and Production environments.

State Management:

Remote state storage using S3 for collaboration.

State locking using DynamoDB to prevent conflicts.

2. Why Each Component Was Implemented

Networking

A VPC creates an isolated network for resources, ensuring security and efficient communication. Subnets are divided into public (internet-facing) and private (internal) to control access levels.

Why include an Internet Gateway?
To allow resources in the public subnet to access the internet.

Why include a NAT Gateway?
To enable private subnet resources to access the internet securely.

Compute

EC2 instances host applications. Using Terraform ensures consistency in configurations across environments.

Why tag resources?
Tags (like Name, Environment) make it easy to manage and identify resources in the AWS Console.

Storage

EBS volumes provide persistent storage that remains even if the instance is terminated.

Why use user_data?
To automatically format and mount the EBS volume during instance startup.

Load Balancing

Load balancers distribute traffic across multiple instances to ensure reliability and scalability.

Why only for Staging and Production?
Development environments usually don’t handle high traffic and don’t need load balancing.

State Management

Remote state in S3 allows multiple team members to collaborate, while DynamoDB prevents simultaneous updates.

What happens if state management isn’t configured?
Team members might overwrite each other’s changes, causing resource conflicts.
 
