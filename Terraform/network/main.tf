resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "main_vpc"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = cidrsubnet(var.vpc_cidr, 1, 0)
    map_public_ip_on_launch = true
    tags = {
      Name = "public_subnet" 
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = cidrsubnet(var.vpc_cidr, 1, 1)
    map_public_ip_on_launch = false
    tags = {
      Name = "private_subnet" 
    }
}

resource "aws_network_interface" "public_interface" {
  subnet_id   = aws_subnet.public_subnet.id
  tags = {
    Name = "public_network_interface"
  }
}
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "public_route"
  }
}
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "internet_gateway"
  }
}
resource "aws_route" "default_route" {
  route_table_id = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.internet_gateway.id
}

resource "aws_default_route_table" "private_rt" {
  default_route_table_id = aws_vpc.main_vpc.default_route_table_id
  tags = {
    Name = "mtc_private"
  }
}
#PLUGGIN ERROR, NOT FIXED
#resource "aws_route_table_association" "public_association" {
#  subnet_id      = aws_subnet.public_subnet.id
#  route_table_id = aws_route_table.public_route_table.id
#}
resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id = aws_vpc.main_vpc.id
  service_name = local.service_name
  subnet_ids = [aws_subnet.private_subnet.id]
  depends_on = [
    aws_vpc.main_vpc,
  ]
  tags = {
    Environment = "dev"
  }
}

resource "aws_security_group" "public_access_sg" {
  name = "public_security_group"
  description = "Security group for public access"
  vpc_id = aws_vpc.main_vpc.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.access_ip]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}



