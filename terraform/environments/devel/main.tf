module "s3" {
  source = "../../modules/s3"

  bucket_name = "rdcicidr-devel-app"
  region = "us-east-1"
}
