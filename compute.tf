resource "aws_launch_configuration" "launch" {
  name = "apps"
  image_id = var.instance_image
  instance_type = var.instance_type
  user_data = templatefile("setup.sh", { rds_endpoint = aws_db_instance.db.address})
  security_groups = [aws_security_group.app.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  lifecycle {
    create_before_destroy = true
  }
}

resource aws_autoscaling_group "apps" {
  launch_configuration = aws_launch_configuration.launch.id
  min_size = 2
  max_size = 10
  vpc_zone_identifier = [aws_subnet.sub_public.id, aws_subnet.sub_public_2.id]
  enabled_metrics = [
   "GroupTotalInstances",
   "GroupInServiceInstances",
   "GroupPendingInstances",
   "GroupStandbyInstances",
   "GroupTerminatingInstances",
   "GroupDesiredCapacity",
   "GroupMaxSize",
   "GroupMinSize",
   "GroupInServiceCapacity",
   "GroupPendingCapacity",
   "GroupStandbyCapacity",
   "GroupTerminatingCapacity",
   "GroupTotalCapacity"
 ]
}

resource "aws_autoscaling_policy" "asg_policy_up" {
  name                 = "asg_policy"
  autoscaling_group_name = aws_autoscaling_group.apps.name
  adjustment_type       = "ChangeInCapacity"
  scaling_adjustment    = 1
  cooldown              = 300
}

resource "aws_autoscaling_policy" "asg_policy_down" {
  name                 = "asg_policy"
  autoscaling_group_name = aws_autoscaling_group.apps.name
  adjustment_type       = "ChangeInCapacity"
  scaling_adjustment    = -1
  cooldown              = 300
}