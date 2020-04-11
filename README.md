# terraform-ecs-task-scheduled-execution

![Terraform](https://github.com/voyagegroup/terraform-aws-ecs-task-scheduled-execution/workflows/Terraform/badge.svg)

A terraform module to set up your ECS task the scheduled execution. If ECS task get failed retry until success.

![](https://raw.githubusercontent.com/voyagegroup/terraform-aws-ecs-task-scheduled-execution/master/docs/draw-io.png)

## Usage

[examples](https://github.com/voyagegroup/terraform-aws-ecs-task-scheduled-execution/tree/master/examples/simple)

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloudwatch\_event\_role\_name | StepFunctions StateMachine invokable IAM Role name. | `string` | n/a | yes |
| cloudwatch\_event\_schedule\_expression | Schedule Expressions for Rules ex: cron(0 12 \* \* ? \*), rate(5 minutes). | `string` | n/a | yes |
| cluster\_name | ECS Fargate Cluster name. | `string` | n/a | yes |
| ecs\_task\_definetion\_family | ECS Fargate Task Definition family. | `string` | n/a | yes |
| name | About this name. | `string` | n/a | yes |
| security\_groups | Specify the security groups to attach. | `list(string)` | n/a | yes |
| sfn\_iam\_role\_name | StateMachine IAM Role name. | `string` | n/a | yes |
| subnets | Specify the subnet on which to run ECS Fargate. | `list(string)` | n/a | yes |
| assign\_public\_ip | Choose whether to have your tasks receive a public IP address. If you are using Fargate tasks, in order for the task to pull the container image it must either use a public subnet and be assigned a public IP address or a private subnet that has a route to the internet or a NAT gateway that can route requests to the internet. | `bool` | `false` | no |
| cloudwatch\_event\_description | CloudWatch Event Description. | `string` | `"Invoke ECS Retry StepFunction StateMachine."` | no |
| ecs\_task\_ignore\_retry\_errors | The errors you do not want to retry. | `list(string)` | <pre>[<br>  "States.Permissions"<br>]</pre> | no |
| ecs\_task\_need\_retry\_errors | The errors you want to retry. | `list(string)` | <pre>[<br>  "States.TaskFailed",<br>  "States.Timeout"<br>]</pre> | no |
| ecs\_task\_retry\_backoff\_rate | The multiplier by which the retry interval increases during each attempt. | `number` | `2` | no |
| ecs\_task\_retry\_interval\_seconds | An integer that represents the number of seconds before the first retry attempt. | `number` | `60` | no |
| ecs\_task\_retry\_max\_attemps | A positive integer that represents the maximum number of retry attempts. If the error recurs more times than specified, retries cease and normal error handling resumes. A value of 0 specifies that the error or errors are never retried. | `number` | `5` | no |
| enabled | The boolean flag whether this execution is enabled or not. No execution when set to false. | `bool` | `true` | no |
| sfn\_comment | StepFunctions StateMachine comment | `string` | `"ECS Task run."` | no |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloudwatch\_event\_rule\_arn | n/a |
| cloudwatch\_event\_target\_arn | n/a |
| sfn\_state\_machine\_name | n/a |

