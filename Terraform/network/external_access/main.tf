resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id

  tags = {
    Name = "public_route"
  }
}
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = var.vpc_id
  tags = {
    Name = "internet_gateway"
  }
}
resource "aws_route" "default_route" {
  route_table_id = aws_route_table.public_route_table.id
  destination_cidr_block = var.destination_cidr
  gateway_id = aws_internet_gateway.internet_gateway.id
}

resource "aws_default_route_table" "private_rt" {
  default_route_table_id = var.default_route_table_id
  tags = {
    Name = "mtc_private"
  }
}
#PLUGGIN ERROR, NOT FIXED
#resource "aws_route_table_association" "public_association" {
#  subnet_id      = var.subnet_id
#  route_table_id = var.route_table_id
#}
resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id = var.vpc_id
  service_name = var.service_name
  subnet_ids = [var.private_subnet_id]
  tags = {
    Environment = "dev"
  }
}

resource "aws_security_group" "public_access_sg" {
  name = "public_security_group"
  description = "Security group for public access"
  vpc_id = var.vpc_id
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