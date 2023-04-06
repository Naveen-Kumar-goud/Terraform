provider "aws" {
  region = "us-east-1"
}

resource "aws_dynamodb_table" "Car" {
  name         = "car"
  hash_key     = "VIN"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "VIN"
    type = "N"
  }
}


resource "aws_dynamodb_table_item" "car_item" {
  table_name = aws_dynamodb_table.Car.id
  hash_key   = aws_dynamodb_table.Car.hash_key
  item       = <<EOF
  {
	"Manufaturer" : {"s": "Toyota"},
	"VIN" : {"N": "9867464789"},
	"Make" : {"S": "Corolla"},
	"Year" : {"N": "2004"}
  }
  EOF

}