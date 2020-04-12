data aws_caller_identity current {}

### ECS Task Role

resource aws_iam_role ecs_task {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role_policy.json
}

data aws_iam_policy_document ecs_task_assume_role_policy {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource aws_iam_role_policy_attachment ecs_task_attachment_policy {
  role       = aws_iam_role.ecs_task.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

### CloudWatch Event Role

resource aws_iam_role cloudwatch_event {
  name               = "StartExecutionStepFunctionCloudWatchEvent"
  assume_role_policy = data.aws_iam_policy_document.cloudwatch_event_assume_role_policy.json
}

data aws_iam_policy_document cloudwatch_event_assume_role_policy {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

resource aws_iam_role_policy cloudwatch_event_policy {
  role   = aws_iam_role.cloudwatch_event.id
  policy = data.aws_iam_policy_document.cloudwatch_event_policy.json
}

data aws_iam_policy_document cloudwatch_event_policy {
  statement {
    actions = ["states:StartExecution"]

    resources = ["*"]
  }
}


### StepFunctions StateMachine Role

resource aws_iam_role sfn {
  name               = "${var.name}StepFunction"
  assume_role_policy = data.aws_iam_policy_document.sfn_assume_role_policy.json

  depends_on = [aws_iam_role.ecs_task]
}

data aws_iam_policy_document sfn_assume_role_policy {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["states.amazonaws.com"]
    }
  }
}

resource aws_iam_role_policy_attachment sfn_attachment_policy {
  role       = aws_iam_role.sfn.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource aws_iam_role_policy sfn_policy {
  role   = aws_iam_role.sfn.id
  policy = data.aws_iam_policy_document.sfn_policy.json
}

data aws_iam_policy_document sfn_policy {
  statement {
    effect = "Allow"
    actions = [
      "ecs:RunTask",
      "ecs:StopTask",
      "ecs:DescribeTasks"
    ]
    resources = ["arn:aws:ecs:${var.region}:${data.aws_caller_identity.current.account_id}:task-definition/${aws_ecs_task_definition.this.family}"]
  }

  statement {
    effect = "Allow"
    actions = [
      "events:PutTargets",
      "events:PutRule",
      "events:DescribeRule"
    ]
    resources = [
      "arn:aws:events:${var.region}:${data.aws_caller_identity.current.account_id}:rule/StepFunctionsGetEventsForECSTaskRule"
    ]
  }

  statement {
    effect    = "Allow"
    actions   = ["iam:PassRole"]
    resources = [aws_iam_role.ecs_task.arn]
  }
}
