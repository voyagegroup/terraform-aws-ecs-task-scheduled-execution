## How

```console
$ make plan
$ make apply
```

### If you found this error.

```console
$ make plan
...
Error: Error creating Step Function State Machine: AccessDeniedException: 'arn:aws:iam::851669633371:role/EcsTaskScheduledExecutionStepFunction' is not authorized to create managed-rule.
        status code: 400, request id: 192e3d83-c9c2-41b4-b584-093835a9067d

  on ../../main.tf line 37, in resource "aws_sfn_state_machine" "this":
  37: resource aws_sfn_state_machine this {


make: *** [apply] Error 1
```

This error reason is IAM Role doesn't finish create now so Step Functions do not found IAM Role.
Please retry `make apply` .

## Providers

| Name | Version |
|------|---------|
| aws | 2.53 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| name | n/a | `string` | `"EcsTaskScheduledExecution"` | no |
| profile | AWS Credential profile name | `string` | n/a | yes |
| region | n/a | `string` | `"ap-northeast-1"` | no |
| vpc\_azs | n/a | `list(string)` | <pre>[<br>  "ap-northeast-1a"<br>]</pre> | no |

## Outputs

No output.

