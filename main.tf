data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "odoo_sg" {
  name        = "odoo_security_group"
  description = "odoo security group in the default VPC"
  # Reference the ID of the default VPC using data.aws_vpc.default.id
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name = "odoo-terraform"
  }

  vpc_security_group_ids = [aws_security_group.odoo_sg.id]

  user_data = file("./script.sh")
}

resource "aws_eip" "odoo_eip" {
  instance = aws_instance.server.id
  domain   = "vpc" # 'vpc' is the default for modern AWS
  tags = {
    Name = "odoo-eip"
  }
}