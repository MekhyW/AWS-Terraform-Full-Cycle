resource "aws_lb" "loadBalancer" {
  name               = "loadBalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb.id]
  subnets            = [aws_subnet.sub_public.id, aws_subnet.sub_public_2.id]
}

resource "aws_lb_target_group" "lb_target" {
  name      = "lb-target"
  port      = 80
  protocol  = "HTTP"
  vpc_id    = aws_vpc.vpc.id
  health_check {
    enabled            = true
    port               = 80
    interval           = 30
    protocol           = "HTTP"
    path               = "/"
    matcher            = "200"
    healthy_threshold  = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.loadBalancer.arn
  port             = "80"
  protocol         = "HTTP"
  default_action {
    type            = "forward"
    target_group_arn = aws_lb_target_group.lb_target.arn
  }
}

resource "aws_autoscaling_attachment" "asg_attach" {
  autoscaling_group_name = aws_autoscaling_group.apps.name
  lb_target_group_arn  = aws_lb_target_group.lb_target.arn
}