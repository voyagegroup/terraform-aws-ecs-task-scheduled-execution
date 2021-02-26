data "aws_caller_identity" "current" {}

### CloudWatch Event Role

resource "aws_iam_role" "cloudwatch_event" {
  name               = "StartExecutionStepFunctionCloudWatchEvent"
  assume_role_policy = data.aws_iam_policy_document.cloudwatch_event_assume_role_policy.json
}

data "aws_iam_policy_document" "cloudwatch_event_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "cloudwatch_event_policy" {
  role   = aws_iam_role.cloudwatch_event.id
  policy = data.aws_iam_policy_document.cloudwatch_event_policy.json
}

data "aws_iam_policy_document" "cloudwatch_event_policy" {
  statement {
    actions = ["states:StartExecution"]

    resources = ["*"]
  }
}

resource "aws_iam_role" "sfn" {
  name               = "EcsTaskScheduledExecutionStepFunction"
  assume_role_policy = data.aws_iam_policy_document.sfn_assume_role_policy.json
}

data "aws_iam_policy_document" "sfn_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["states.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "sfn_policy" {
  role   = aws_iam_role.sfn.id
  policy = data.aws_iam_policy_document.sfn_policy.json
}

data "aws_iam_policy_document" "sfn_policy" {
  statement {
    effect = "Allow"
    actions = [
      "ecs:RunTask",
      "ecs:StopTask",
      "ecs:DescribeTasks"
    ]
    resources = ["arn:aws:ecs:${var.region}:${data.aws_caller_identity.current.account_id}:task-definition/*"]
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
    resources = ["*"]
  }
}

