resource "aws_s3_bucket" "images_bucket" {
  bucket = var.bucket_name # Usa una variable para el nombre del bucket

  # Configuración CORS
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "GET"]
    allowed_origins = ["*"]
    expose_headers  = []
  }

  # Define el nivel de acceso del bucket
  acl = "private"
}

# Bloquea el acceso público usando aws_s3_bucket_public_access_block
resource "aws_s3_bucket_public_access_block" "images_bucket_access_block" {
  bucket                  = aws_s3_bucket.images_bucket.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}