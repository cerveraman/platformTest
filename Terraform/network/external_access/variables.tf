variable "vpc_id" {
  type = string
}
variable "default_route_table_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "service_name" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "access_ip" {
  type = string
}

variable "destination_cidr" {
  type = string
}
variable "ingress_from_port" {
  type = number
}
variable "ingress_to_port" {
  type = number
}
variable "ingress_protocol" {
  type = string
}
variable "egress_from_port" {
  type = number
}
variable "egress_to_port" {
  type = number
}
variable "egress_protocol" {
  type = string
}
variable "egress_ip" {
  type = string
}
