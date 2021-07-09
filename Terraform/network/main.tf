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

resource "aws_route_table_association" "public_association" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "public_route"
  }
}
 resource "aws_route" "default_route" {
   route_table_id = aws_route_table.public_route_table.id
   destination_cidr_block = "0.0.0.0/0" #accessible from any IP addres - NOT RECOMENDED
   gateway_id = aws_internet_gateway.internet_gateway.id
 }

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "internet_gateway"
  }
}

