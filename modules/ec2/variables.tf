variable "instance_type" {
    description = "Type of Ec2 instance"
    default = "t2.micro"
}

variable "ami_id" {
    description = "Enter AMI image id"
    default = "ami-0c02fb55956c7d316"
}

variable "subnet_id" {
    description = "subnet_id (if u want to use already existing one)"
    type = string
  
}

variable "environment" {
    description = "ENter the environment DEV, PROD, STAGE"
    type = string
  
}
variable "ec2_instance_name"{
    description = "Enter the name you want to give the instance"
    type = string
    
}
variable "aws_region" {
    description = "enter aws_region"
    type = string
    default = "us-east-1"
  
}