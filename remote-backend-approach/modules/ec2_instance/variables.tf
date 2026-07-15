variable "instance_type" {
  description = "type of instance"
  type        = string
}

variable "ami_id" {
  description = "Ubuntu or Amazon Linux AMI ID for us-east-1"
  type        = string
}

variable "s3_bucket_name" {
  type        = string
  description = "Globally unique name for S3 bucket"
}


variable "dynamodb_table_name" {
  type        = string
  description = "Name of the DynamoDB table for state locking"
}