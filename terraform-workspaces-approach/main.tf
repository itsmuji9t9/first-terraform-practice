provider "aws" {
    region = "us-east-1"
  
}

variable "instance_type" {
    description = "Type of EC2 instance"
    
}

variable "ami_id" {
    description = "AMI ID for the EC2 instance"
    
}
module "ec2_instance" {
    source        = "./modules/ec2"
    instance_type = var.instance_type
    ami_id        = var.ami_id
}