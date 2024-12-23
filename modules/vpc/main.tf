resource "aws_vpc" "myvpc" {
    cidr_block=var.vpc_cidr
    enable_dns_hostnames=true
    enable_dns_support =true
    tags={
        name="${var.environment}-vpc"
    }
}

resource "aws_internet_gateway" "myigw" {
    vpc_id=aws_vpc.myvpc.id
    tags={
        name="${var.environment}-igw"
    }
}
resource "aws_subnet" "public" {
    cidr_block=cidrsubnet("${var.vpc_cidr}",8,1)
    vpc_id=aws_vpc.myvpc.id
    map_public_ip_on_launch = true
    tags = {
      name="${var.environment}-public_subnet"
    }
}

resource "aws_subnet" "private" {
     cidr_block=cidrsubnet("${var.vpc_cidr}",8,2)
    vpc_id=aws_vpc.myvpc.id
    tags = {
      name="${var.environment}-private_subnet"
    }
}

resource "aws_eip" "nat" {
  domain="vpc"
  tags = {
    Name = "${var.environment}-nat-eip"
  }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }

  tags = {
    Name = "${var.environment}-public-route-table"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${var.environment}-private-route-table"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id
  tags = {
    Name = "${var.environment}-nat"
  }
}

resource "aws_security_group" "allow_traffic" {
    vpc_id = aws_vpc.myvpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol="tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
    tags={
        name="${var.environment}-sg"
    }
  
}