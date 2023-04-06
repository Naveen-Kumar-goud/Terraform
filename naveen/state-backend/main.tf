resource "local_file" "file" {
  filename = "file.txt"
  content  = "Naveen"
}

terraform {
  backend "s3" {
    bucket         = "state-lock1997"
    key            = "state/terraform.tfstate"
    dynamodb_table = "state-locking"
    region         = "us-east-1"
  }
}