# resource "aws_lb_target_group_attachment" "JenkinsAttachment" {
#   target_group_arn = data.aws_lb_target_group.JenkinsTG.arn
#   target_id        = aws_launch_template.jenkins_lt.id
#   port             = 8080
# }

resource "aws_route53_record" "jenkins_cname" {
  zone_id = "Z0699124QZYV2PLKNVKR"
  name    = "jenkins.kendanbeauty.com"
  type    = "CNAME"
  ttl     = 300
  records = [data.aws_lb.ALB.dns_name]
}

