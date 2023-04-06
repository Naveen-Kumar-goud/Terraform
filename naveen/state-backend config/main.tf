resource "aws_s3_bucket" "s3" {
  bucket = "state-lock1997"

}

resource "aws_dynamodb_table" "dynamodb" {
  name           = "state-locking"
  hash_key       = "LockID"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  attribute {
    name = "LockID"
    type = "S"
  }

}


provider "aws" {
  region = "us-east-1"
}