module "s3" {
  source = "../../modules/s3"

  bucket_name = "rdcicidr-prod-app"
  region = "us-west-2"
}
