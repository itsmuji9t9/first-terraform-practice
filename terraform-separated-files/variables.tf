variable "instance_type" {
  description = "type of instance"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "Ubuntu or Amazon Linux AMI ID for us-east-1"
  type        = string
  default     = "ami-0b6d9d3d33ba97d99"
}
