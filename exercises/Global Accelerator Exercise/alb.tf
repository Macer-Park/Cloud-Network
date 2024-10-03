resource "aws_lb_target_group" "sydney_target_group" {
  name        = "sydney-alb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = module.aws_sydney_vpc.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 10
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "sydney-alb-tg"
  }

  depends_on = [module.sydney_EC2]

  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_lb_target_group_attachment" "sydney_tg_attachment_one" {
  target_group_arn = aws_lb_target_group.sydney_target_group.arn
  target_id        = module.sydney_EC2["1"].id
  port             = 80
}

resource "aws_lb_target_group_attachment" "sydney_tg_attachment_two" {
  target_group_arn = aws_lb_target_group.sydney_target_group.arn
  target_id        = module.sydney_EC2["2"].id
  port             = 80
}

resource "aws_lb" "sydney_lb" {
  name               = "sydney-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups = [
    module.sydney_http_ssh_sg.security_group_id,
  ]
  subnets = module.aws_sydney_vpc.public_subnets

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }

  depends_on = [aws_lb_target_group.sydney_target_group]
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.sydney_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sydney_target_group.arn
  }
}