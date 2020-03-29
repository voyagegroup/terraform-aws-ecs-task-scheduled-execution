output "sfn_state_machine_name" {
  value = aws_sfn_state_machine.this.name
}

output "cloudwatch_event_rule_arn" {
  value = aws_cloudwatch_event_rule.this.arn
}

output "cloudwatch_event_target_arn" {
  value = aws_cloudwatch_event_target.this.arn
}
