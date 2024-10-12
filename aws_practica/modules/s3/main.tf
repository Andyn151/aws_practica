resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  # Configuraciones opcionales
  tags = {
    Name = var.tag_name  # Usa la variable aquí
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::921108067704:user/andreaisabeln"  # Cambia a tu ARN
        }
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.bucket.arn}/*"
      }
    ]
  })
}
