data "aws_ssm_parameter" "ecs_optimized_ami" {
  # Get latest ecs optimized ami
  # https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/ecs-optimized_AMI.html
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

resource "aws_autoscaling_group" "this" {
  name                = var.name
  max_size            = 1
  min_size            = 1
  default_cooldown    = 60
  vpc_zone_identifier = module.vpc.private_subnets

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  lifecycle {
    ignore_changes = [desired_capacity]
  }
}

resource "aws_launch_template" "this" {
  name                   = var.name
  image_id               = data.aws_ssm_parameter.ecs_optimized_ami.value
  vpc_security_group_ids = [aws_security_group.this.id]
  instance_type          = "t2.micro"

  user_data = base64encode(templatefile("./userdata.sh",
    {
      CLUSTER_NAME = aws_ecs_cluster.this.name
  }))

  iam_instance_profile {
    arn = aws_iam_instance_profile.host_instance.arn
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = var.name
    }
  }
}
