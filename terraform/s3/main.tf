resource "aws_s3_bucket" "frontend_bucket" {
  bucket = var.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "frontend_website" {
    bucket = aws_s3_bucket.frontend_bucket.id

    index_document {
      suffix = "index.html"
    }

    #   error_document {
    #     key = "error.html"
    #   }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.frontend_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "frontend_bucket_policy" {
  bucket = aws_s3_bucket.frontend_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = "*"
      Action    = "s3:GetObject"
      Resource  = "${aws_s3_bucket.frontend_bucket.arn}/*"
    }]
  })
}

resource "aws_s3_object" "bucket_files" {
  bucket = aws_s3_bucket.frontend_bucket.bucket

  for_each = fileset("${path.root}/../frontend/build", "**")
  key    = each.value
  source = "${path.root}/../frontend/build/${each.value}"
  etag = filemd5("${path.root}/../frontend/build/${each.value}")
  content_type = lookup({
      "html" = "text/html",
      "json" = "application/json",
      "css"  = "text/css",
      "js"   = "application/javascript",
      "jpg"  = "image/jpeg",
      "png"  = "image/png",
      "gif"  = "image/gif",
      "txt"  = "text/plain",
      "ico"  = "image/x-icon"
    }, 
    reverse(split(".", each.value))[0],
    "binary/octet-stream" # Default type
  )

  depends_on = [aws_s3_bucket_policy.frontend_bucket_policy]
}