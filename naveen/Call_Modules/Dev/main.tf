
module "Dev_Env" {
	source = "../../EC2-INSTANCE"
	aws_ami = "ami-007855ac798b5175e"
	aws_region = "us-east-1"
	aws_inst_type = "t2.micro"
}


