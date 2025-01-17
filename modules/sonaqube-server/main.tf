
resource "aws_instance" "SonarServer" {
  ami                    = var.ami # Ubuntu 20.04 LTS
  instance_type          = var.instance_type
  key_name               = var.key_name  # Set your key pair name
  count                  = lookup(var.subnet_count, var.tags.environment)
  subnet_id              = data.aws_subnet.private_subnet[count.index].id
  vpc_security_group_ids = [ aws_security_group.SonarServerSG.id ]

  tags = merge(var.tags, {
    Name = format("%s-%s-sonar-server", var.tags["environment"], var.tags["project"]) 
  }
  )
}

