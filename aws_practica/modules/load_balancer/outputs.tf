# Salida para el ARN del Load Balancer
output "lb_arn" {
  value = data.aws_lb.kc_alb_andrea.arn  # Exportar el ARN del Load Balancer existente
}

# Salida para el ARN del Target Group
output "target_group_arn" {
  value = aws_lb_target_group.app_tg.arn  # Exportar el ARN del target group
}

