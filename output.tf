output "vpc_id" {
  value = module.vpc.vpc_id
}

output "ec2_instance_public_ip" {
  value = module.EC2.instance_public_ip
}

output "ec2_instance_private_ip" {
  value = module.EC2.instance_private_ip
}

output "ec2_instance_name" {
  value = module.EC2.instance_name
}

