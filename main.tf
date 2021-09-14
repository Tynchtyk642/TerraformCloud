provider "aws" {
  region = "us-east-1"
}


data "terraform_remote_state" "instance_type" {
  backend = "remote"

  config = {
    organization = "Ant-Engineering_1"
    workspaces = {
      name = "Dev"
    }
  }
}


terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "Ant-Engineering_1"

    workspaces {
      name = "Dev"
    }
  }
}

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
  instance_type = data.terraform_remote_state.instance_type.config
  count = 1

  tags = {
      Name = "Terraform-EC2"
  }
}