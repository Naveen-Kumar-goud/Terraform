provider "aws" {
	region = var.aws_region
}


resource "aws_instance" "webserver" {
	ami = var.aws_ami
	instance_type = var.aws_inst_type
	tags = {
		Name = "Webserver"
		Description = "Webserver"
	}
	user_data = <<-EOF
		#!/bin/bash
		sudo apt update -y 
		sudo apt install nginx -y 
		sudo systemctl enable nginx
		sudo systemctl start nginx		
		EOF
	key_name = aws_key_pair.key.id
	vpc_security_group_ids = [ aws_security_group.web_sg.id ]
}

resource "aws_key_pair" "key" {
	public_key = file("id_rsa.pub")

}

resource "aws_security_group" "web_sg" {
	name = "web_sg"
	ingress {
		to_port = 22
		from_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

output "Public_IP" {
	value = aws_instance.webserver.public_ip
}