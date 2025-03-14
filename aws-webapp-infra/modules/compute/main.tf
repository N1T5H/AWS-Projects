resource "aws_launch_template" "webapp" {
  name_prefix = "webapp-"
  image_id = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  
  network_interfaces {
    associate_public_ip_address = false
    security_groups = [aws_security_group.webapp.id]
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              EOF
  )
}

resource "aws_autoscaling_group" "webapp" {
  desired_capacity = var.min_size
  max_size = var.max_size
  min_size = var.min_size
  vpc_zone_identifier = var.private_subnet_ids

  launch_template {
    id = aws_launch_template.webapp.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.webapp.arn]
}

resource "aws_lb" "webapp" {
  name = "webapp-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb.id]
  subnets = var.public_subnet_ids
}

# Add ALB listener, target group, and security groups

