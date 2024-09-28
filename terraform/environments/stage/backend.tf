terraform {
  backend "s3" {
    bucket         = "rdcicidr-terraform-state"
    key            = "stage/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}