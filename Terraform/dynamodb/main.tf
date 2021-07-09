resource "aws_dynamodb_table" "Inventory" {
  name           = "Inventory"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "SneakerId"
  range_key      = "SneakerName"

  attribute {
    name = "SneakerId"
    type = "S"
  }

  attribute {
    name = "SneakerName"
    type = "S"
  }

  attribute {
    name = "Stock"
    type = "N"
  }
  global_secondary_index {
    name               = "SneakerNameIndex"
    hash_key           = "SneakerName"
    range_key          = "Stock"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["SneakerId"]
  }
  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }
  tags = {
    Name        = "dynamodb-table-1"
    Environment = "production"
  }
}