# resource "aws_lb_target_group_attachment" "JenkinsAttachment" {
#   target_group_arn = data.aws_lb_target_group.JenkinsTG.arn
#   target_id        = aws_launch_template.jenkins_lt.id
#   port             = 8080
# }

resource "aws_route53_record" "jenkins_cname" {
  zone_id = data.aws_route53_zone.kendanZone_id.zone_id
  name    = format("%sjenkins.kendanbeauty.com", var.tags["environment"])
  type    = "CNAME"
  ttl     = var.ttl
  records = [data.aws_lb.ALB.dns_name]
}

