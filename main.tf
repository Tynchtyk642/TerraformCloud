# 

data "aws_ami" "amazon_linux" {
    owners = ["amazon"]
    most_recent = true
    filter {
        name = "name"
        values = ["amzn2-ami-hvm-2.0.*"]
    }
}

resource "aws_instance" "CloudProject" {
  ami = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  count = var.amount

  tags = {
      Name = var.instance_name
  }
}



#===========================variables=================================

variable "instance_type" {
  type = string
}

variable "amount" {
  type = number
}

variable "instance_name" {
  type = string
}