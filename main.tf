
resource "random_string" "bucket_suffix" {
  count  = 50
  length = 8
  special = false
}

resource "aws_s3_bucket" "my_buckets" {
  count = 50
  bucket = "${var.bucket}-${random_string.bucket_suffix[count.index].result}"
  
  tags = {
    Name = "Bucket ${count.index + 1}"
  }
}

resource "aws_s3_bucket_acl" "example" {
  count = 50  
  bucket = aws_s3_bucket.my_buckets[count.index].id
  acl    = "private"
}