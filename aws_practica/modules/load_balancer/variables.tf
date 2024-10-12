variable "security_group_id" {
  description = "ID del grupo de seguridad para el Load Balancer"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de IDs de subredes para el Load Balancer"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID de la VPC donde se encuentra el Load Balancer"
  type        = string
}
