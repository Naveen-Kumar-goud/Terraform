variable "region" {
	default = {
		test = "us-east-1"
		dev = "us-east-2"
		prod = "us-west-1"
		}
}

variable "ami" {
	default = {
		test = "ami-06e46074ae430fba6"
		dev = "ami-0103f211a154d64a6"
		prod = "ami-09c5c62bac0d0634e"
		}
}