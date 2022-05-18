
module "alb_knox" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "alb-knox-${var.project}-${terraform.workspace}"

  load_balancer_type = "application"

  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnets
  security_groups    = [
    module.sg_http.security_group_id,
  ]

  # access_logs = {
  #   bucket = "my-alb-logs"
  # }

  target_groups = [
    {
      name      = "knox-${var.project}-${terraform.workspace}"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"

      # targets = [
      #   for i in module.ec2_edge : 
      #   {
      #     target_id = module.ec2_edge[0].id
      #     port = 8443
      #   },
      # ]
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
}

resource "aws_lb_target_group_attachment" "knox" {
  count = max(1,var.nb_edge)

  target_group_arn = module.alb_knox.target_group_arns[0]
  target_id        = module.ec2_edge[count.index].id
  port             = 8443
}
