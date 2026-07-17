provider "aws" {
    region = "us-east-1"
  
}

variable "instance_type" {
    description = "Type of EC2 instance"

}

variable "ami_id" {
    description = "AMI ID for the EC2 instance"
    
}

resource "aws_instance" "example" {
    ami           = var.ami_id
    instance_type = var.instance_type

    tags = {
        Name = "ExampleInstance"
    }
}