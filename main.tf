 variable "vpc_cidr" {
  description = "CIDR blocks for different environments"
  type        = map(string)
  default = {
    dev     = "10.0.0.0/16"
    staging = "10.1.0.0/16"
    prod    = "10.2.0.0/16"
  }
}
 
 locals {
  # Current workspace environment (e.g., dev, staging, prod)
  environment = terraform.workspace
  
  # Retrieve the CIDR block for the current environment
  cidr_block = var.vpc_cidr[local.environment]
}

locals {
  environment_instance_type = lookup(
    {
      "dev"     = "t2.micro",
      "staging" = "t2.micro",
      "prod"    = "t3.micro"
    },
    local.environment,  # `local.environment` comes from `terraform.workspace`
    "t2.micro"          # Default value
  )
}

locals {
  environment_ami_id = lookup(
    {
      "dev"     = "ami-0c02fb55956c7d316",   # Development AMI
      "staging" = "ami-1234567890abcdef0",   # Staging AMI
      "prod"    = "ami-0987654321abcdef0",   # Production AMI
    },
    local.environment,  # `local.environment` comes from `terraform.workspace`
    "ami-0c02fb55956c7d316"  # Default AMI
  )
}

locals {
  # Generate a dynamic instance name based on the current workspace/environment
  instance_name = "${terraform.workspace}-instance-${local.environment}"
}

terraform{
backend "s3" {
bucket="ramameghanaterraform"
key="terraform/project1/terraform.tfstate"
region="us-east-1"
}
}


module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = local.cidr_block
  environment = local.environment
}

module "EC2" {
  source = "./modules/ec2"
  ami_id=local.environment_ami_id
  environment = local.environment
  subnet_id       = module.vpc.public_subnet_id
  ec2_instance_name = local.instance_name
  
}

