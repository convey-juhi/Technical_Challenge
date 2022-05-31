# External LB to connect Users to the Application
resource "aws_lb" "web-lb" {
  name               = "web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.web_lb_sg]
  subnets            = var.web_subnet_ids

  tags = {
    Environment = "production"
  }
}

# External LB Target Group
resource "aws_lb_target_group" "web-lb-tg" {
  name        = "web-lb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
}

# External LB Listener Rules
resource "aws_lb_listener" "web-alb-listener" {

  load_balancer_arn = aws_lb.web-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-lb-tg.arn
  }
}

# Attaching External LB to Web AutoScaling Group
resource "aws_autoscaling_attachment" "web_asg_tg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.web-asg.id
  lb_target_group_arn    = aws_lb_target_group.web-lb-tg.arn
}

# Internal Loadbalance to connect Web-tier to App tier
resource "aws_lb" "app-lb" {
  name               = "app-lb"
  internal           = true
  load_balancer_type = "network"
  subnets            = var.app_subnet_ids

  tags = {
    Environment = "production"
  }
}

# Internal LB Target Group
resource "aws_lb_target_group" "app-lb-tg" {
  name        = "app-lb-tg"
  port        = 3000
  protocol    = "TCP"
  target_type = "instance"
  vpc_id      = var.vpc_id
}

# Internal LB Listener Rules
resource "aws_lb_listener" "app-alb-listener" {
  load_balancer_arn = aws_lb.app-lb.arn
  port              = "3000"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-lb-tg.arn
  }
}

# Attaching Internal LB to App AutoScaling Group
resource "aws_autoscaling_attachment" "app_asg_tg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.app-asg.id
  lb_target_group_arn    = aws_lb_target_group.app-lb-tg.arn
}
