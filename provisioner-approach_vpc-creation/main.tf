provider "aws" {
  region = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

resource "aws_key_pair" "example" {
  key_name   = "my-key"
  public_key = file("my-key.pub")
}

resource "aws_vpc" "sample_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "sample_subnet" {
  vpc_id            = aws_vpc.sample_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "my-subnet"
  }
}

resource "aws_internet_gateway" "sample_igw" {
  vpc_id = aws_vpc.sample_vpc.id

  tags = {
    Name = "my-igw"
  }
}

resource "aws_route_table" "sample_route_table" {
  vpc_id = aws_vpc.sample_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sample_igw.id
  }
}

resource "aws_route_table_association" "sample_route_table_association" {
  subnet_id      = aws_subnet.sample_subnet.id
  route_table_id = aws_route_table.sample_route_table.id
}

resource "aws_security_group" "sample_security_group" {
  name        = "sample-security-group"
  description = "Sample security group"
  vpc_id      = aws_vpc.sample_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "my-security-group"
  }
}
resource "aws_instance" "sample_instance" {
  ami           = "ami-0b6d9d3d33ba97d99"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.sample_subnet.id
  key_name      = aws_key_pair.example.key_name
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.sample_security_group.id]

  tags = {
    Name = "my-instance"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("my-key.pem")
    host        = coalesce(self.public_ip, self.private_ip)
  }

  provisioner "file" {
    source      = "app.py"
    destination = "/home/ubuntu/app.py"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remoteterra instance'",
      "sudo apt update -y",  # Update package lists (for ubuntu)
      "sudo apt-get install -y python3-pip",  # Example package installation
      "cd /home/ubuntu",
      "sudo pip3 install flask --break-system-packages",
      "sudo python3 app.py &",
    ]
}
}

