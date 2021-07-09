resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "main_vpc"
  }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = cidrsubnet(var.vpc_cidr, 1, 0)
    map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = cidrsubnet(var.vpc_cidr, 1, 1)
    map_public_ip_on_launch = true
}

resource "aws_network_interface" "public_interface" {
  subnet_id   = aws_subnet.public_subnet.id

  tags = {
    Name = "public_network_interface"
  }
}

resource "aws_network_interface" "private_interface" {
  subnet_id   = aws_subnet.private_subnet.id

  tags = {
    Name = "private_network_interface"
  }
}
