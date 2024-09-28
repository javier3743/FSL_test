provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "app_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_website_configuration" "app_bucket" {
  bucket = aws_s3_bucket.app_bucket.id

  index_document {
    suffix = "index.html"
  }

}

resource "aws_s3_bucket_public_access_block" "app_bucket" {
  bucket = aws_s3_bucket.app_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "app_bucket" {
  bucket = aws_s3_bucket.app_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.app_bucket.arn}/*"
      },
    ]
  })
  depends_on = [ aws_s3_bucket_public_access_block.app_bucket ]
}

resource "aws_s3_object" "build_files" {
  for_each = fileset("./build", "**/*")

  bucket = aws_s3_bucket.app_bucket.id
  key    = each.value
  source = "./build/${each.value}"
  etag   = filemd5("./build/${each.value}")

  #content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.value), null)
}

# locals {
#   mime_types = {
#     ".html" = "text/html"
#     ".css"  = "text/css"
#     ".js"   = "application/javascript"
#     ".png"  = "image/png"
#     ".jpg"  = "image/jpeg"
#     ".json" = "application/json"
#     ".txt"  = "text/plain"
#   }
# }