output "website_endpoint" {
  value = aws_s3_bucket.bucket.bucket_regional_domain_name
}
