variable "region" {
  type = string
  description = "The region to deploy the S3 bucket in"
}

variable "bucket_name" {
  type = string
  description = "The name of the S3 bucket for the website"
}
