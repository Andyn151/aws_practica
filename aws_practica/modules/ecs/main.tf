# Crear el clúster de ECS
resource "aws_ecs_cluster" "main" {
  name = "kc-ecs-andrea"
}

# Definir la tarea de ECS con Nginx
resource "aws_ecs_task_definition" "nginx_task" {
  family                   = "nginx-task"
  container_definitions    = jsonencode([{
    name        = "nginx"
    image       = var.container_image  # Cambiado a usar la variable
    essential   = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
  }])
  execution_role_arn       = var.ecs_task_definition_role
  network_mode             = "awsvpc"
  requires_compatibilities  = ["FARGATE"]
  cpu                      = var.cpu  # Cambiado a usar la variable
  memory                   = var.memory  # Cambiado a usar la variable
}

# Servicio de ECS para Nginx
resource "aws_ecs_service" "nginx_service" {
  name            = "nginx-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.nginx_task.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnet_ids  # Cambiado a usar la variable
    security_groups = var.security_group_ids  # Cambiado a usar la variable
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "nginx"
    container_port   = 80  # Este valor es correcto, ya que lo necesitas aquí
  }
}
