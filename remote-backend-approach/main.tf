provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
    source              = "./modules/ec2_instance"
    ami_id              = "ami-0b6d9d3d33ba97d99"
    instance_type       = "t3.micro"
    s3_bucket_name      = "mujahid-s3-demo-xyz-9t9999"      
    dynamodb_table_name = "terraform-lock"

}