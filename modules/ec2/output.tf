output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.server.id
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.server.public_ip
}

output "instance_private_ip" {
  description = "Private IP of the EC2 instance"
  value       = aws_instance.server.private_ip
}
output "instance_name" {
  description = "The name of the EC2 instance"
  value       = aws_instance.server.tags["name"]
}