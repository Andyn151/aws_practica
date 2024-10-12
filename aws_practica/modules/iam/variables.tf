variable "ecs_task_execution_role_name" {
  description = "Nombre del rol de ejecución de tareas para ECS"
  type        = string
  default     = "ecsTaskExecutionRole"
}

variable "ecs_task_execution_policy_name" {
  description = "Nombre de la política para el rol de ejecución de tareas ECS"
  type        = string
  default     = "ecsTaskExecutionPolicy"
}
