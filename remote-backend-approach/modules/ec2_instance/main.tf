resource "aws_instance" "my_sample_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "my_sample_terraform_ec2"
  }
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.s3_bucket_name # <-- Variable se value uthayi
}


resource "aws_dynamodb_table" "terraform_lock" {
  name         = var.dynamodb_table_name # <-- Variable se value uthayi
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}