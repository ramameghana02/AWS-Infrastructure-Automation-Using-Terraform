
variable "vpc_cidr" {
  type=map(string)
  default = {
    dev     = "10.0.0.0/16"
    staging = "10.1.0.0/16"
    prod    = "10.2.0.0/16"
  }
}



variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}