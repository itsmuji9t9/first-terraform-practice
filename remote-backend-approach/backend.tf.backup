terraform {
  backend "s3" {
    bucket         = "mujahid-s3-demo-xyz-9t9999"         # Jo bucket name aapne module mein pass kiya hai
    key            = "global/s3/terraform.tfstate"    # Bucket ke andar state file ka path/naam
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"              # DynamoDB table ka naam locking ke liye
    encrypt        = true
  }
}