variable "name" {
  description = "About this name."
  type        = string
}

variable "enabled" {
  description = "The boolean flag whether this execution is enabled or not. No execution when set to false."
  type        = bool
  default     = true
}

variable "cluster_name" {
  description = "ECS Fargate Cluster name."
  type        = string
}

variable "ecs_task_definetion_family" {
  description = "ECS Fargate Task Definition family."
  type        = string
}

variable "subnets" {
  description = "Specify the subnet on which to run ECS Fargate."
  type        = list(string)
}

variable "security_groups" {
  description = "Specify the security groups to attach."
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Choose whether to have your tasks receive a public IP address. If you are using Fargate tasks, in order for the task to pull the container image it must either use a public subnet and be assigned a public IP address or a private subnet that has a route to the internet or a NAT gateway that can route requests to the internet."
  type        = bool
  default     = false
}

variable "cloudwatch_event_schedule_expression" {
  description = "Schedule Expressions for Rules ex: cron(0 12 * * ? *), rate(5 minutes)."
  type        = string
}

variable "cloudwatch_event_description" {
  description = "CloudWatch Event Description."
  type        = string
  default     = "Invoke ECS Retry StepFunction StateMachine."
}

variable "cloudwatch_event_role_name" {
  description = "StepFunctions StateMachine invokable IAM Role name."
  type        = string
}

variable "sfn_iam_role_name" {
  description = "StateMachine IAM Role name."
  type        = string
}

variable "sfn_comment" {
  description = "StepFunctions StateMachine comment"
  type        = string
  default     = "ECS Task run."
}

variable "ecs_task_need_retry_errors" {
  description = "The errors you want to retry."
  type        = list(string)
  default     = ["States.TaskFailed", "States.Timeout"]
}

variable "ecs_task_retry_interval_seconds" {
  description = "An integer that represents the number of seconds before the first retry attempt."
  type        = number
  default     = 60
}

variable "ecs_task_retry_max_attemps" {
  description = "A positive integer that represents the maximum number of retry attempts. If the error recurs more times than specified, retries cease and normal error handling resumes. A value of 0 specifies that the error or errors are never retried."
  type        = number
  default     = 5
}

variable "ecs_task_retry_backoff_rate" {
  description = "The multiplier by which the retry interval increases during each attempt."
  type        = number
  default     = 2
}

variable "ecs_task_ignore_retry_errors" {
  description = "The errors you do not want to retry."
  type        = list(string)
  default     = ["States.Permissions"]
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

