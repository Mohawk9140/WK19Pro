resource "aws_vpc" "wk19_pro" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "wk19_pro"
  }
}

resource "aws_ecs_cluster" "cluster" {
  name = "wk19_Pro_cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

module "ecs-fargate" {
  source  = "umotif-public/ecs-fargate/aws"
  version = "~> 6.1.0"

  name_prefix        = "Wk19_pro_ecs_fargate"
  vpc_id             = aws_vpc.wk19_pro.id
  private_subnet_ids = [aws_subnet.Wk19_private_subnet1.id, aws_subnet.Wk19_private_subnet2.id]

  cluster_id = aws_ecs_cluster.cluster.id

  task_container_image   = "centos:latest"
  task_definition_cpu    = 256
  task_definition_memory = 512

  task_container_port             = 80
  task_container_assign_public_ip = true

  load_balanced = false

  target_groups = [
    {
      target_group_name = "wk19_pro_fargate_tg"
      container_port    = 80
    }
  ]

  health_check = {
    port = "traffic-port"
    path = "/"
  }

  tags = {
    Environment = "pro19_test"
    Project     = "pro19_Test"
  }
}

