provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "sj-test-tf-bucket" {
  region = var.region
  bucket = "sj-tf-s3-bucket-${data.aws_caller_identity.sj-act.account_id}"
  versioning {
    enabled = true
  }
  lifecycle_rule {
    enabled = true
    noncurrent_version_transition {
      storage_class = "STANDARD_IA"
      days = 30
    }
    noncurrent_version_transition {
      storage_class = "GLACIER"
      days = 60
    }
    noncurrent_version_expiration {
      days = 90
    }
  }
  tags = {
    TYPE = "PERSONAL"
    CONTENT = "PICS"
  }
}

data "aws_caller_identity" "sj-act" {}

