module "network" {
  source            = "./network"
  vpc_cidr          = local.cidr
  access_ip         = var.access_ip
  destination_cidr  = local.destination_cidr
  service_name      = local.service_name
  ingress_from_port = local.ingress_from_port
  ingress_to_port   = local.ingress_to_port
  ingress_protocol  = local.ingress_protocol
  egress_from_port  = local.egress_from_port
  egress_to_port    = local.egress_to_port
  egress_protocol   = local.egress_protocol
  egress_ip         = var.egress_ip
}
module "ec2" {
  source              = "./ec2"
  ami                 = local.ami
  instance_type       = local.instance_type
  public_interface_id = module.network.public_interface_id
  device_index        = local.device_index
}
module "dynamodb" {
  source = "./dynamodb"
}
