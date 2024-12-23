resource "aws_instance" "server" {
    ami=var.ami_id
    instance_type = var.instance_type
    subnet_id=var.subnet_id
    

  


tags={
    name=var.ec2_instance_name
    environment=var.environment

}
}