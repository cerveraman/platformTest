# Deploy an EC2 instance connected to a DynamoDB database with Terraform:
* The goal of the exercise is to deploy an EC2 instance connected to DynamoDB, isolating database from internet for security reasons, following the diagram described in https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/vpc-endpoints-dynamodb.html
* Only EC2 instance can connect to database throug an VPC Endpoint
* Sensible data (keys and secrets) have been stored in terraform.tfvars file, as this is a learning exercise this file has been exceptionally included in git hub repository


# Implementation:
* Three terraform modules have been deployed, network, ec2 and dynamodb
## Module network
* The module implements several aws network resources:
* 1 - aws_vpc main_vpc: main vpc who connects all resources
* 2 - aws_subnet public_subnet: public subnet to connect to EC2 instance
* 3 - aws_subnet private_subnet: private subnet to connect to DynamoDB
* 4 - aws_network_interface public_interface: elastic interface to connect EC2 instance to public_subnet
* 5 - aws_route_table public_route_table: custom route table to connect the VPC to internet
* 6 - aws_internet_gateway internet_gateway: gateway to connect tbe VPC to internet
* 7 - aws_route default_route: route to direct all external traffico to thee public subnet throug the gateway
* 8 - aws_route_table_association public: route table association to link the public route table with the public subnet. This resource throws an error in the terraform aws plugin that has not been solved
* 9 - aws_vpc_endpoint dynamodb: enpoint to connect DynamoDB to the private subnet and the VPC

## Module ec2
* The module implements an Amazon AMI instance running in EC2, connected to the VPC through an elastic network interface

## Module dynamodb
* The module implements an Amazon Dynamodb table with three attributes, SneakerID, SneakerName and Stock, simulating a simple store warehouse. The table is connected to a private subnet by an VPC endpoint

## Issues:
* 1 - As detailed in the resource description the aws_route_table_association throws "Error: The terraform-provider-aws_v3.49.0_x5 plugin crashed!", and has not been fixed
* 2 - terraform apply does not update the vpc id value in terraform.tfstate file in the aws_vpc_endpoint dynamodb resource, thus aftere first apply terraform.tfstate must be manually deleted before apply again.