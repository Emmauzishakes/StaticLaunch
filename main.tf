resource "aws_s3_bucket" "staticlaunch" {
    bucket = var.bucket_name

    tags = {
      Name = "StaticLaunch"
      Environment = "Dev"
      ManagedBy = "Terraform"
      Project = "StaticLaunch"
    }
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.staticlaunch.id
  key = "index.html"
  source = "website/index.html"
  content_type = "text/html"

  depends_on = [ 
    aws_s3_bucket_ownership_controls.ownership
   ]
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.staticlaunch.id
  key = "error.html"
  source = "website/error.html"
  content_type = "text/html"

  depends_on = [ 
    aws_s3_bucket_ownership_controls.ownership
   ]
}

# Website Hosting
resource "aws_s3_bucket_website_configuration" "staticlaunch" {
    bucket = aws_s3_bucket.staticlaunch.id

    index_document {
        suffix = "index.html"
    }

    error_document {
        key = "error.html"
    }
}

# Public Access Block
resource "aws_s3_bucket_public_access_block" "public" {
  bucket = aws_s3_bucket.staticlaunch.id

  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

# Bucket Ownership Controls
resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.staticlaunch.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Bucket Policy
resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.staticlaunch.id

  depends_on = [ 
    aws_s3_bucket_public_access_block.public,
    aws_s3_bucket_ownership_controls.ownership
   ]

   policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
        {
            Sid = "PublicReadGetObject"
            Effect = "Allow"
            Principal = "*"

            Action = "s3:GetObject"

            Resource = [
                "${aws_s3_bucket.staticlaunch.arn}/*"
            ]
        }
    ]
   })
}