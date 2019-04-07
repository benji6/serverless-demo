resource "aws_dynamodb_table" "comments" {
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "userId"
  name         = "comments_demo"
  range_key    = "dateCreated"

  attribute = {
    name = "dateCreated"
    type = "S"
  }

  attribute = {
    name = "userId"
    type = "S"
  }
}
