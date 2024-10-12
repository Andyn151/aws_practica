variable "bucket_name" {
  description = "El nombre del bucket S3"
  type        = string
}

variable "tag_name" {
  description = "El nombre de la etiqueta para el bucket"
  type        = string
}



variable "enable_versioning" {
  description = "Habilitar el versionado del bucket"
  type        = bool
  default     = false
}

variable "enable_website" {
  description = "Habilitar el sitio web en el bucket"
  type        = bool
  default     = false
}
