terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.28.0"
    }
  }
}

resource "aws_instance" "laravel" {
    ami                       = var.ami
    instance_type             = var.instance_type
    key_name                  = aws_key_pair.deployer.id
    vpc_security_group_ids    = [aws_security_group.ssh.id, aws_security_group.http.id]
    user_data                 = file(var.user_data_path)
    tags                      = {
        Name = "Ubuntu 22.04 Nginx PHP Laravel"
    }
}

resource "aws_eip" "eip" {
    instance = aws_instance.laravel.id
    tags     = {
        Name = "Ubuntu 22.04 Nginx PHP Laravel"
    }
}

resource "aws_key_pair" "deployer" {
    key_name   = "deployer-key"
    public_key = var.public_key
}

resource "aws_security_group" "ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    description      = "SSH from EC2"
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "http" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"

  ingress {
    description      = "HTTP from EC2"
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_http"
  }
}