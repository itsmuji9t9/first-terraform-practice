output "public_ip" {
  description = "The public IP address of the created EC2 instance"
  value       = aws_instance.my_sample_ec2.public_ip
}
