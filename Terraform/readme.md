# Deploy an EC2 instance connected to a DynamoDB database with Terraform:
* The goal of the exercise is to deploy an EC2 instance connected to DynamoDB, isolating database from internet for security reasons, following the diagram described in https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/vpc-endpoints-dynamodb.html
* Only EC2 instance can connect to database throug an VPC Endpoint
* Sensible data (keys and secrets) have been stored in terraform.tfvars file, as this is a learning exercise this file has been exceptionally included in git hub repository
* All resources will be deployed in a local docker container running LocalStack

# Implementation:
* Three terraform modules have been deployed, network, ec2 and dynamodb
## Module network
* The module implements several aws network resources:
  - aws_vpc main_vpc: main vpc who connects all resources
  - aws_subnet public_subnet: public subnet to connect to EC2 instance
  - aws_subnet private_subnet: private subnet to connect to DynamoDB
  - aws_network_interface public_interface: elastic interface to connect EC2 instance to public_subnet
  - aws_route_table public_route_table: custom route table to connect the VPC to internet
  - aws_internet_gateway internet_gateway: gateway to connect tbe VPC to internet
  - aws_route default_route: route to direct all traffic to the public subnet through the gateway
  - aws_route_table_association public: route table association to link the public route table with the public subnet. This resource throws an error in the terraform aws plugin that has not been solved
  - aws_default_route_table private_rt: The default route table deployed with the aws_vpc main_vpc resource will be used as default route table in our VPC
  - aws_vpc_endpoint dynamodb: enpoint to connect DynamoDB to the private subnet and the VPC
  - aws_security_group public_access_sg: This security group allows to filter inbound and outbound traffic. All outbound traffic is allowed, but only inbound traffic from port 22 ant to port 22 is allowed. As this is a learning exercise, traffic for any IP address is allowed, but this should be limited for production environments.
## Module ec2
* The module implements an Amazon AMI instance running in EC2, connected to the VPC through an elastic network interface

## Module dynamodb
* The module implements an Amazon Dynamodb table with three attributes, SneakerID, SneakerName and Stock, simulating a simple store warehouse. The table is connected to a private subnet by an VPC endpoint

## Issues:
* 1 - As detailed in the resource description the aws_route_table_association throws "Error: The terraform-provider-aws_v3.49.0_x5 plugin crashed!", and has not been fixed
* 2 - terraform apply does not update the vpc id value in terraform.tfstate file in the aws_vpc_endpoint dynamodb resource, thus aftere first apply terraform.tfstate must be manually deleted before apply again.