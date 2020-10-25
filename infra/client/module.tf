terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.region
}

resource "aws_vpc" "test-env" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_subnet" "subnet-uno" {
  cidr_block = cidrsubnet(aws_vpc.test-env.cidr_block, 3, 1)
  vpc_id     = aws_vpc.test-env.id
}

resource "aws_security_group" "ingress-all-test" {
  name   = "allow-all-sg"
  vpc_id = aws_vpc.test-env.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 9001
    to_port   = 9001
    protocol  = "tcp"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = var.pub_key
}

resource "aws_instance" "pingpong_client" {
  ami             = var.amis[var.region]
  instance_type   = "t2.nano"
  key_name        = "deployer-key"
  security_groups = [aws_security_group.ingress-all-test.id]
  subnet_id       = aws_subnet.subnet-uno.id
}

resource "aws_eip" "ip-test-env" {
  instance = aws_instance.pingpong_client.id
  vpc      = true
}

resource "aws_internet_gateway" "test-env-gw" {
  vpc_id = aws_vpc.test-env.id
}

resource "aws_route_table" "route-table-test-env" {
  vpc_id = aws_vpc.test-env.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-env-gw.id
  }
}
resource "aws_route_table_association" "subnet-association" {
  subnet_id      = aws_subnet.subnet-uno.id
  route_table_id = aws_route_table.route-table-test-env.id
}

