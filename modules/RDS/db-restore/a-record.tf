resource "aws_route53_record" "cname_record" {
  depends_on = [aws_db_instance.postgres]
  zone_id  = "Z05777641WR5348CPPSII"
  name     = "postgresql.kendanbeauty.com"
  type    = "CNAME"
  ttl     = 300
  records = [local.enpoint_without_port]  # Pointing to A record
}

 locals {
  rds_endpoint  = aws_db_instance.postgres.endpoint
  enpoint_without_port = replace(local.rds_endpoint, ":5432" , "")
 }