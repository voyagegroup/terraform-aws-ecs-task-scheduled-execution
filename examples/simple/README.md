## How

```console
$ make plan
$ make apply
```

### If you found this error.

```console
$ make plan
...
Error: Error creating Step Function State Machine: AccessDeniedException: Neither the global service principal states.amazonaws.com, nor the regional one is authorized to assume the provided role.
	status code: 400, request id: xxxx-xxxx-xxxx-xxxx-xxxx

  on ../main.tf line 30, in resource "aws_sfn_state_machine" "this":
  30: resource "aws_sfn_state_machine" "this" {


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

