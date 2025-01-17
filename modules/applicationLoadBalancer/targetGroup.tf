# Create Target Groups
resource "aws_lb_target_group" "JenkinsTG" {
  name        = format("%s-JenkinsTG", var.tags["environment"])
  port        =  var.JenkinsTG.port    
  protocol    = var.JenkinsTG.protocol
  vpc_id      = data.aws_vpc.my_vpc.id 
  target_type = var.JenkinsTG.target_type
  health_check {
    path                =  var.JenkinsTG.path               
    interval            =  var.JenkinsTG.interval           
    timeout             = var.JenkinsTG.timeout            
    healthy_threshold   = var.JenkinsTG.healthy_threshold  
    unhealthy_threshold = var.JenkinsTG.unhealthy_threshold
  }

  tags = merge(var.tags, {
   Name = format("%s-JenkinsTG", var.tags["environment"])
 }
)
}

resource "aws_lb_target_group" "SonarTG" {
  name        = format("%s-SonarTG", var.tags["environment"])
  vpc_id      = data.aws_vpc.my_vpc.id
  port        = var.SonarTG.port       
  protocol    = var.SonarTG.protocol    
  target_type = var.SonarTG.target_type

  health_check {
    path                = var.SonarTG.path                
    interval            = var.SonarTG.interval             
    timeout             = var.SonarTG.timeout            
    healthy_threshold   = var.SonarTG.healthy_threshold  
    unhealthy_threshold = var.SonarTG.unhealthy_threshold
  }

  tags = merge(var.tags, {
    Name = format("%s-SonarTG", var.tags["environment"])
  }
 )
}

# resource "aws_lb_target_group" "yellow" {
#   name        = "yellow-tg"
#   port        = 80
#   protocol    = "HTTP"
#   vpc_id      = data.aws_vpc.my_vpc.id 
#   target_type = "instance"

#   health_check {
#     path                = "/"
#     interval            = 30
#     timeout             = 5
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#   }

#   tags = {
#     Name = "yellow-tg"
#   }
# }
