provider "aws" {
	region = "us-east-1"
}


resource "aws_instance" "webserver" {
	ami = "ami-00c39f71452c08778"
	instance_type = "t2.micro"
	tags = {
		Name = "Webserver"
		Description = "Webservers"
	}
	provisioner "local-exec" {
		when = destroy
		command = "echo  Instance ${self.public_ip} destroyed ! > destroy.txt " 
	}
	provisioner "local-exec" {
		command = "echo  Instance ${self.public_ip} created ! > create.txt " 
	}

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