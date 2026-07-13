provider "aws" {

     region = "us-east-1"
}

variable "instance_type" {
   description = "type of instance "
   type        = string
   default     = "t3.micro"
}

variable "ami_id"{
   type    = string
   default = "ami-0b6d9d3d33ba97d99"
}

resource "aws_instance" "my_sample_ec2" {

     ami           = var.ami_id
     instance_type = var.instance_type
     tags = {

         Name = "my_sample_terraform_ec2"
}
}

output "public_ip" {
  value = aws_instance.my_sample_ec2.public_ip
}
