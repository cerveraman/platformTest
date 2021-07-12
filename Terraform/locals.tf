locals {
  cidr = "10.123.0.0/24"
}
locals {
  ami = "ami-005e54dee72cc1d00" # us-west-2
}
locals {
  instance_type = "t2.micro"
}
locals {
  destination_cidr = "0.0.0.0/0"
}
locals {
  service_name = "com.amazonaws.us-west-1.dynamodb"
}
locals {
  ingress_from_port = 22
}
locals {
  ingress_to_port = 22
}
locals {
  ingress_protocol = "tcp"
}
locals {
  egress_from_port = 22
}
locals {
  egress_to_port = 22
}
locals {
  egreess_protocol = -1
}
locals {
  egress_protocol = "tcp"
}