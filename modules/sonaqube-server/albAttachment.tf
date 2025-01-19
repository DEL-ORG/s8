# resource "aws_lb_target_group_attachment" "SonarAttachment" {
#   target_group_arn = data.aws_lb_target_group.SonarTG.arn
#   # for_each = toset([for index in range(length(aws_instance.SonarServer)) : index])
#   target_id        = aws_instance.SonarServer[0].id
#   port             = 9000
# }

resource "aws_route53_record" "jenkins_cname" {
  zone_id = data.aws_route53_zone.kendanZone_id.zone_id
  name    = format("%ssonar.kendanbeauty.com", var.tags["environment"])
  type    = "CNAME"
  ttl     = var.ttl
  records = [data.aws_lb.ALB.dns_name]
}
