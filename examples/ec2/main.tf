module "ecs_task_scheduled_execution" {
  source                               = "../.."
  name                                 = var.name
  cluster_name                         = aws_ecs_cluster.this.name
  ecs_task_definition_family           = aws_ecs_task_definition.this.family
  security_groups                      = [aws_security_group.this.id]
  subnets                              = module.vpc.private_subnets
  assign_public_ip                     = false
  enabled                              = true
  cloudwatch_event_schedule_expression = "rate(2 minutes)"
  ecs_launch_type                      = "EC2"

  // need examples/deps apply
  cloudwatch_event_role_name = "StartExecutionStepFunctionCloudWatchEvent"
  sfn_iam_role_name          = "EcsTaskScheduledExecutionStepFunction"
}
