provider "aws" {
  region = "eu-west-1"
}

# Security Group
resource "aws_security_group" "web_sg" {
  name = "web_sg"

  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "web" {
  ami           = "ami-047bb4163c506cd98"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.web_sg.name]
  key_name      = "your-key-name"  # CHANGE THIS

  tags = {
    Name = "DevOps-Server"
  }
}
