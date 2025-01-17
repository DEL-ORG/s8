resource "aws_lb" "ALB" {
  depends_on         = [aws_security_group.alb_sg]
  name               = format("%s-ALB", var.tags["environment"])
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = data.aws_subnets.public_subnets.ids
  enable_deletion_protection = var.enable_deletion_protection

 tags = merge(var.tags, {
    Name = format("%s-ALB", var.tags["environment"])
  }
 )
}

