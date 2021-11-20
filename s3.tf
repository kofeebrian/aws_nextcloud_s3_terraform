resource "aws_s3_bucket" "nextcloud-s3-storage" {
  bucket = var.bucket_name
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }

  force_destroy = true

  versioning {
    enabled = true
  }

  tags = {
    Name = "nextcloud-bucket"
  }
}

# Allow access to the bucket only to the nextcloud user and the terraform user
resource "aws_s3_bucket_policy" "nextcloud-s3-datastore-policy" {

  bucket = aws_s3_bucket.nextcloud-s3-storage.id

  policy = <<S3_POLICY
{
  "Id": "NextcloudS3Policy",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllActions",
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [ 
          "${aws_s3_bucket.nextcloud-s3-storage.arn}",
          "${aws_s3_bucket.nextcloud-s3-storage.arn}/*" 
        ],
      "Principal": {
        "AWS": [
            "${aws_iam_user.nextcloud-s3.arn}",
            "${data.aws_caller_identity.terraform_user.arn}"
        ]
      }
    },
    {
      "Sid": "DenyTheRest",
      "Effect": "Deny",
      "Action": ["s3:*"],
      "Resource": [ "${aws_s3_bucket.nextcloud-s3-storage.arn}" ],
      "NotPrincipal": {
        "AWS": [
            "${aws_iam_user.nextcloud-s3.arn}",
            "${data.aws_caller_identity.terraform_user.arn}"
        ]
      }
    }
  ]
}
S3_POLICY
}
