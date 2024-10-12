# Crear el rol de ejecución de tareas para ECS
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

# Política de ejecución para el rol ECS
resource "aws_iam_policy" "ecs_task_execution_policy" {
  name        = "ecs-task-execution-policy"
  description = "Política para permitir acceso a servicios necesarios en ECS, incluyendo acceso a logs y Amazon ECR."
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetAuthorizationToken",
          "s3:GetObject",
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

# Asociar la política con el rol de ejecución de ECS
resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_task_execution_policy.arn
}

# Data source para el rol existente (si es necesario)
data "aws_iam_role" "ecs_task_execution_role_existing" {
  name = "ecs-task-execution-role"  # Asegúrate de que este nombre coincida con tu rol existente
}
