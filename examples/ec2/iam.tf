data "aws_caller_identity" "current" {}

### ECS Task Role

resource "aws_iam_role" "ecs_task" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role_policy.json
}

data "aws_iam_policy_document" "ecs_task_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_attachment_policy" {
  role       = aws_iam_role.ecs_task.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

### Host Instance

resource "aws_iam_instance_profile" "host_instance" {
  role = aws_iam_role.host_instance.id
}

data "aws_iam_policy_document" "host_instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "host_instance" {
  name               = "${var.name}HostInstance"
  assume_role_policy = data.aws_iam_policy_document.host_instance_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "attachment_ecs_host_instance_policy" {
  role       = aws_iam_role.host_instance.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}
