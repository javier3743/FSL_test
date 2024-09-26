module "s3" {
  source = "../../modules/s3"

  bucket_name = "rdcicidr-stage-app"
  region = "us-east-1"
}
