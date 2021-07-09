resource "aws_instance" "app" {
  ami = var.ami
  instance_type = var.instance_type
  network_interface {
    network_interface_id = var.public_interface_id
    device_index         = 0
  }
}