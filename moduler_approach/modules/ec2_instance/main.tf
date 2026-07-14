resource "aws_instance" "my_sample_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "my_sample_terraform_ec2"
  }
}
