variable profile {
  type        = string
  description = "AWS Credential profile name"
}

variable name {
  type    = string
  default = "EcsTaskScheduledExecution"
}

variable region {
  type    = string
  default = "ap-northeast-1"
}

variable vpc_azs {
  type    = list(string)
  default = ["ap-northeast-1a"]
}
