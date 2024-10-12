# Definir la región
variable "aws_region" {
  description = "us-east-1"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "kc-ecs-andrea"
  type        = string
  default     = "kc-ecs-andrea"
}

variable "bucket_name" {
  description = "kc-s3-andrea"
  type        = string
  default     = "kc-s3-andrea"
}

variable "enable_versioning" {
  description = "Habilitar versionado en el bucket S3"
  type        = bool
  default     = false
}

variable "enable_website" {
  description = "Habilitar sitio web estático en el bucket S3"
  type        = bool
  default     = false
}
variable "tag_name" {
  description = "El nombre de la etiqueta para el bucket"
  type        = string
  default     = "kc-bn-andrea"  # Puedes cambiar esto a lo que desees
}
