data "aws_ami" "debian" {
  most_recent = true
  owners =  ["136693071363"]
  filter {
    name   = "name"
    values = ["debian-11-amd64-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

resource "aws_vpc" "openwebui" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_subnet" "subnet" {
  cidr_block        = cidrsubnet(aws_vpc.openwebui.cidr_block, 3, 1)
  vpc_id            = aws_vpc.openwebui.id
  availability_zone = "us-east-2a"
}

resource "aws_internet_gateway" "openwebui" {
  vpc_id = aws_vpc.openwebui.id
}

resource "aws_route_table" "openwebui" {
  vpc_id = aws_vpc.openwebui.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.openwebui.id
  }
}

resource "aws_route_table_association" "openwebui" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.openwebui.id
}

resource "aws_security_group" "ssh" {
  name = "allow-all"

  vpc_id = aws_vpc.openwebui.id

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_key_pair" "openwebui" {
  key_name   = "openwebui"
  public_key = file("C:/Users/epelaez/.ssh/id_ed25519.pub")
}


resource "aws_spot_instance_request" "cheap_worker" {
  ami           = data.aws_ami.debian.id
  instance_type = "t3.micro"

  associate_public_ip_address = true
  key_name = aws_key_pair.openwebui.key_name
  vpc_security_group_ids = [aws_security_group.ssh.id]
  subnet_id = aws_subnet.subnet.id
  wait_for_fulfillment = true
}