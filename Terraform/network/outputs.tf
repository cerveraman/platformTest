output "vpc_id" {
    value = aws_vpc.main_vpc.id
}

output "public_interface_id" {
    value = aws_network_interface.public_interface.id
}

