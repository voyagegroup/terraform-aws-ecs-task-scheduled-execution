resource aws_ecs_cluster this {
  name = var.name
}

locals {
  log_group_name = "/${var.name}"
}

resource aws_cloudwatch_log_group this {
  name              = local.log_group_name
  retention_in_days = 30
}

resource aws_ecs_task_definition this {
  family                   = var.name
  task_role_arn            = aws_iam_role.ecs_task.arn
  execution_role_arn       = aws_iam_role.ecs_task.arn
  network_mode             = "awsvpc"
  memory                   = "512"
  cpu                      = "256"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = <<EOF
[
{
    "name": "${var.name}",
    "command": [
        "echo $EXECUTION_TIME; echo $ENVIROMENT;"
    ],
    "entryPoint": [
        "sh",
        "-c"
    ],
    "environment": [
        {"name": "ENVIROMENT", "value": "prod"}
    ],
    "image": "alpine:latest",
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
            "awslogs-group": "${local.log_group_name}",
            "awslogs-region": "${var.region}",
            "awslogs-stream-prefix": "ecs"
        }
    }
}
]
EOF

  depends_on = [aws_iam_role.ecs_task]
}
