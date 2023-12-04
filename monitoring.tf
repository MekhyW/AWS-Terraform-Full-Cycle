resource "aws_cloudwatch_metric_alarm" "highRequests" {
  alarm_name = "highRequests"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "RequestCount"
  namespace = "AWS/ApplicationELB"
  period = "60"
  statistic = "Average"
  threshold = "150"
  alarm_description = "This metric checks request count"
  alarm_actions = [aws_autoscaling_policy.asg_policy_up.arn]
  dimensions = {
    LoadBalancer = aws_lb.loadBalancer.arn
  }
}

resource "aws_cloudwatch_metric_alarm" "highCPU" {
  alarm_name = "highCPU"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "80"
  alarm_description = "This metric checks cpu utilization"
  alarm_actions = [aws_autoscaling_policy.asg_policy_up.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.apps.name
  }
}

resource "aws_cloudwatch_metric_alarm" "lowCPU" {
  alarm_name = "lowCPU"
  comparison_operator = "LessThanThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "20"
  alarm_description = "This metric checks cpu utilization"
  alarm_actions = [aws_autoscaling_policy.asg_policy_down.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.apps.name
  }
}