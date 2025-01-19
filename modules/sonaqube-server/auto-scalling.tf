resource "aws_launch_template" "sonar_lt" {
  name          = format("%s-Sonartemplate", var.tags["environment"]) 
  image_id      = data.aws_ami.sonar_ami.id
  instance_type = var.instance_type
  key_name      = var.key_name

  block_device_mappings {
    device_name = "/dev/sda2"
    ebs {
      volume_size = "20"
      volume_type = "gp3"
    }
  }

  network_interfaces {
    security_groups = [aws_security_group.SonarServerSG.id]
    subnet_id       = element(data.aws_subnets.private_subnets.ids, 0)
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(var.tags, {
      Name = format("%s-%s-SonarServer", var.tags["environment"], var.tags["project"]) 
      }
    )
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "sonar_asg" {
  launch_template {
    id      = aws_launch_template.sonar_lt.id
    version = "$Latest"
  }

  vpc_zone_identifier       = data.aws_subnets.private_subnets.ids
  desired_capacity          = var.desired_capacity         
  min_size                  = var.min_size                 
  max_size                  = var.max_size                 
  health_check_type         = var.health_check_type        
  health_check_grace_period = var.health_check_grace_period

  target_group_arns = [data.aws_lb_target_group.SonarTG.arn]

  tag {
    key                 = "Name"
    value               = "sonar-master"
    propagate_at_launch = true
  }
}

# Attach the Auto Scaling Group to the Load Balancer Target Group
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.sonar_asg.id
  lb_target_group_arn    = data.aws_lb_target_group.SonarTG.arn
}

# Scaling policy for CPU utilization
resource "aws_autoscaling_policy" "scale_up" {
  name                   = format("%sSonarScaleUpPolicy", var.tags["environment"])
  scaling_adjustment     = var.scaleUp.scaling_adjustment
  adjustment_type        = var.scaleUp.adjustment_type   
  cooldown               = var.scaleUp.cooldown          
  autoscaling_group_name = aws_autoscaling_group.sonar_asg.id
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = format("%sSonarScaleDownPolicy", var.tags["environment"])
  scaling_adjustment     = var.scaleDown.scaling_adjustment
  adjustment_type        = var.scaleDown.adjustment_type   
  cooldown               = var.scaleDown.cooldown          
  autoscaling_group_name = aws_autoscaling_group.sonar_asg.id
}