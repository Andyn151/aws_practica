terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.0.0"  # Asegúrate de que estás usando una versión compatible de Terraform
}

provider "aws" {
  region  = "eu-west-1"  # Región en la que se encuentra tu VPC
  profile = "andreaisabeln"     # Asegúrate de que este perfil está configurado correctamente en tu AWS CLI
}

