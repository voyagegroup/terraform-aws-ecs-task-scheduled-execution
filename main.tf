resource aws_cloudwatch_event_rule this {
  name                = var.name
  description         = var.cloudwatch_event_description
  schedule_expression = var.cloudwatch_event_schedule_expression
  is_enabled          = var.enabled
  tags                = var.tags
}

data aws_iam_role cloudwatch_event {
  name = var.cloudwatch_event_role_name
}

resource aws_cloudwatch_event_target this {
  rule      = aws_cloudwatch_event_rule.this.name
  target_id = aws_cloudwatch_event_rule.this.name
  role_arn  = data.aws_iam_role.cloudwatch_event.arn
  input     = "{}"
  arn       = aws_sfn_state_machine.this.id

  depends_on = [aws_cloudwatch_event_rule.this]
}

data aws_iam_role sfn {
  name = var.sfn_iam_role_name
}

data aws_ecs_task_definition this {
  task_definition = var.ecs_task_definetion_family
}

locals {
  assign_public_ip = var.assign_public_ip == true ? "ENABLED" : "DISABLED"
}

resource aws_sfn_state_machine this {
  name     = var.name
  role_arn = data.aws_iam_role.sfn.arn
  tags     = var.tags

  definition = <<EOF
{
  "Comment": "${var.sfn_comment}",
  "StartAt": "Run",
  "States": {
    "Run": {
      "Type": "Task",
      "End": true,
      "Resource": "arn:aws:states:::ecs:runTask.sync",
      "Parameters": {
        "LaunchType": "FARGATE",
        "Cluster": "${var.cluster_name}",
        "TaskDefinition": "${data.aws_ecs_task_definition.this.id}",
        "NetworkConfiguration": {
          "AwsvpcConfiguration": {
            "SecurityGroups": ${jsonencode(var.security_groups)},
            "Subnets": ${jsonencode(var.subnets)},
            "AssignPublicIp": "${local.assign_public_ip}"
          }
        }
      },
      "Retry": [
        {
          "ErrorEquals": ${jsonencode(var.ecs_task_need_retry_errors)},
          "IntervalSeconds": ${var.ecs_task_retry_interval_seconds},
          "MaxAttempts": ${var.ecs_task_retry_max_attemps},
          "BackoffRate": ${var.ecs_task_retry_backoff_rate}
        },
        {
          "ErrorEquals": ${jsonencode(var.ecs_task_ignore_retry_errors)},
          "MaxAttempts": 0
        }
      ]
    }
  }
}
EOF
}
