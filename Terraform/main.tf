module "network" {
  source   = "./network"
  vpc_cidr = local.cidr
  access_ip = var.access_ip
  destination_cidr = local.destination_cidr
  service_name = local.service_name
}
module "ec2" {
  source              = "./ec2"
  ami                 = local.ami
  instance_type       = local.instance_type
  public_interface_id = module.network.public_interface_id
}
module "dynamodb" {
  source = "./dynamodb"
}
