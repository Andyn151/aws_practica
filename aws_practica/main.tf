# Usar la VPC ya existente
data "aws_vpc" "existing" {
  id = "vpc-0720eaf80b02c9dc2"  # ID de la VPC existente
}

# Usar las subredes públicas existentes
data "aws_subnet" "public" {
  count = 2
  id    = count.index == 0 ? "subnet-08db431b0d0bb12e4" : "subnet-04f02617fa4fa708b"  # IDs de las subredes públicas
}

# Usar el Security Group ya existente
data "aws_security_group" "existing_sg" {
  id = "sg-0db3a2db5c343ac4a"  # ID del security group existente
}

# Módulo IAM
module "iam" {
  source = "./modules/iam"
}

# Módulo de S3
module "s3" {
  source      = "./modules/s3"
  bucket_name = "nombre-de-tu-bucket"  # Asegúrate de que sea único
  tag_name    = "nombre-de-tu-etiqueta"  # Puedes personalizar la etiqueta
}

# Módulo de Load Balancer
module "load_balancer" {
  source            = "./modules/load_balancer"
  security_group_id = data.aws_security_group.existing_sg.id  # Usar el Security Group existente
  subnet_ids        = data.aws_subnet.public[*].id  # Usar las subredes públicas existentes
  vpc_id            = data.aws_vpc.existing.id  # Usar la VPC existente
}

# Módulo de ECS
module "ecs" {
  source                   = "./modules/ecs"
  target_group_arn          = module.load_balancer.target_group_arn  # Obtener el ARN del Target Group del módulo de Load Balancer
  ecs_task_definition_role  = module.iam.execution_role_arn
  subnet_ids               = data.aws_subnet.public[*].id  # Usar las subredes existentes
  security_group_ids       = [data.aws_security_group.existing_sg.id]
  desired_count            = 1  # Número de instancias de la tarea
  cpu                      = "256"  # CPU para la tarea
  memory                   = "512"  # Memoria para la tarea
  container_image          = "nginx:latest"  # Imagen del contenedor
}

# Crear el clúster de ECS
resource "aws_ecs_cluster" "main" {
  name = "kc-ecs-andrea"
}

# Definir la tarea de ECS con Nginx
resource "aws_ecs_task_definition" "nginx_task" {
  family                   = "nginx-task"
  container_definitions    = jsonencode([{
    name  = "nginx"
    image = "nginx:latest"
    essential = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
  }])
  execution_role_arn       = module.iam.execution_role_arn
  network_mode             = "awsvpc"
  requires_compatibilities  = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
}

# Servicio de ECS para Nginx
resource "aws_ecs_service" "nginx_service" {
  name            = "nginx-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.nginx_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  
  network_configuration {
    subnets         = data.aws_subnet.public[*].id  # Usar las subredes existentes
    security_groups = [data.aws_security_group.existing_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = module.load_balancer.target_group_arn  # Usar el ARN del target group del módulo Load Balancer
    container_name   = "nginx"
    container_port   = 80
  }
}
