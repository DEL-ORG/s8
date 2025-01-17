resource "aws_launch_template" "jenkins_lt" {
  name          = format("%s-Jenkinstemplate", var.tags["environment"]) 
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = "20"
      volume_type = "gp3"
    }
  }

  network_interfaces {
    security_groups = [aws_security_group.jenkinsSG.id]
    subnet_id       = element(data.aws_subnets.private_subnets.ids, 0)
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(var.tags, {
      Name = format("%s-%s-JenkinsServer", var.tags["environment"], var.tags["project"]) 
      }
    )
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "jenkins_asg" {
  launch_template {
    id      = aws_launch_template.jenkins_lt.id
    version = "$Latest"
  }

  vpc_zone_identifier       = data.aws_subnets.private_subnets.ids
  desired_capacity          = 2
  min_size                  = 1
  max_size                  = 5
  health_check_type         = "EC2"
  health_check_grace_period = 300

  target_group_arns = [data.aws_lb_target_group.JenkinsTG.arn]

  tag {
    key                 = "Name"
    value               = "jenkins-master"
    propagate_at_launch = true
  }
}

# Attach the Auto Scaling Group to the Load Balancer Target Group
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.jenkins_asg.id
  lb_target_group_arn    = data.aws_lb_target_group.JenkinsTG.arn
}

# Scaling policy for CPU utilization
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale-up-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.jenkins_asg.id
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale-down-policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.jenkins_asg.id
}