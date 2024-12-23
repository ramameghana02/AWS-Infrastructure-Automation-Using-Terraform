variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default = "10.1.0.0/16"
}

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}
