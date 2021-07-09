module "network" {
  source   = "./network"
  vpc_cidr = local.cidr
}
module "ec2" {
  source              = "./ec2"
  ami = local.ami
  instance_type = local.instance_type
  public_interface_id = module.network.public_interface_id
}
module "dynamodb" {
  source              = "./dynamodb"
}
