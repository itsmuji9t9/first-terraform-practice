output "public_ip" {
  description = "The public IP address of the created EC2 instance"
  value       = module.ec2_instance.public_ip
}
