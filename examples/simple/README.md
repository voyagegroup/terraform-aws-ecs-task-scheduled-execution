## How

```console
$ make plan
$ make apply
```

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

