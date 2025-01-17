
# HTTP Listener for Redirecting to HTTPS
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      host        = "#{host}"
      path        = "/"
      port        = "443"

      protocol    = "HTTPS"
      query       = "#{query}"
      status_code = "HTTP_301"
    }
  }
}

# HTTPS Listener for Application Traffic
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy      = "ELBSecurityPolicy-2016-08"
  certificate_arn = "arn:aws:acm:us-east-2:074842358617:certificate/53456ca5-9b11-454e-93ae-b9c4e8ef40dd"

  #   Default action (should only be applied if no rules match)
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.JenkinsTG.arn
  }
}

# Define Routing Rules for HTTP Listener based on hostname
resource "aws_lb_listener_rule" "jenkinsServer" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  condition {
    host_header {
      values = ["jenkins.kendanbeauty.com"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.JenkinsTG.arn
  }
}

resource "aws_lb_listener_rule" "SonarServer" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 101

  condition {
    host_header {
      values = ["sonarqube.kendanbeauty.com"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.SonarTG.arn
  }
}

