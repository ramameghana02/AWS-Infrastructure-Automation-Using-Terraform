variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

resource "aws_lb" "app_lb" {
  name               = "${var.environment}-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [module.vpc.public_subnet_ids] # Public subnets
}

resource "aws_lb_listener" "app_lb_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

resource "aws_lb_target_group" "app_tg" {
  name        = "${var.environment}-app-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.myvpc.id
  target_type = "instance"
}
