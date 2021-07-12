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
module "external_access" {
  source = "./external_access"
  vpc_id = aws_vpc.main_vpc.id
  default_route_table_id = aws_vpc.main_vpc.default_route_table_id
  subnet_id      = aws_subnet.public_subnet.id
  service_name = var.service_name
  private_subnet_id = aws_subnet.private_subnet.id
  access_ip =  var.access_ip
  destination_cidr = var.destination_cidr
  ingress_from_port = var.ingress_from_port
  ingress_to_port = var.ingress_to_port
  ingress_protocol = var.ingress_protocol
  egress_from_port = var.egress_from_port
  egress_to_port = var.egress_to_port
  egress_protocol = var.egress_protocol
  egress_ip = var.egress_ip
}



