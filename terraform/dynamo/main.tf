# DynamoDB is schema-less, which means you can include additional attributes in items without 
# declaring them in the table schema. When inserting or updating an item, simply include the 
# desired attribute, and DynamoDB will store it.

resource "aws_dynamodb_table" "waterings" {
  name           = "waterings"
  hash_key       = "plantId"           # Partition Key
  range_key      = "timestamp"         # Sort Key
  read_capacity  = 3
  write_capacity = 3

  attribute {
    name = "plantId"
    type = "N"
  }

  attribute {
    name = "timestamp"
    type = "S"
  }

  billing_mode = "PROVISIONED"

  tags = {
    Name = "waterings-table"
  }
}