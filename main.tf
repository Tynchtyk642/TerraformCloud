resource "aws_instance" "amazon_instance" {
    count = var.number_of_instances
    ami = data.aws_ami.latest_amazon.id
    instance_type = var.instance_type
tags = {
  "Name" = "${terraform.workspace}-instance"
}
}

data "aws_ami" "latest_amazon" {
  owners = ["amazon"]
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

variable "number_of_instances" {
default = 2
}

variable "instance_type" {
default = "t2.micro"
}