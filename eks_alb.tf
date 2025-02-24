# resource "aws_lb" "nginx_alb" {
#   name                       = "nginx-alb"
#   internal                   = false
#   load_balancer_type         = "application"
#   security_groups            = [module.vpc.default_security_group_id]
#   subnets                    = flatten([module.vpc.public_subnets])
#   enable_deletion_protection = false

#   enable_cross_zone_load_balancing = true
#   enable_http2                     = true
#   idle_timeout                     = 60

#   depends_on = [module.eks]

#   tags = {
#     Name = "nginx-alb"
#   }
# }


# resource "aws_lb_target_group" "nginx_tg" {
#   name     = "nginx-tg"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = module.vpc.vpc_id

#   health_check {
#     path                = "/health"
#     interval            = 30
#     timeout             = 5
#     healthy_threshold   = 3
#     unhealthy_threshold = 3
#   }

#   depends_on = [module.eks]

#   tags = {
#     Name = "nginx-tg"
#   }
# }

# # Agrega las reglas de listener para el ALB
# resource "aws_lb_listener" "nginx_listener" {
#   load_balancer_arn = aws_lb.nginx_alb.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.nginx_tg.arn
#   }

#   depends_on = [aws_lb.nginx_alb]
# }

# # Obtener las instancias EC2 del Node Group de EKS
# data "aws_instances" "madeo07_act3_nodes_instances" {
#   filter {
#     name   = "tag:aws:eks:nodegroup-name"
#     values = ["madeo07_act3_nodes"]
#   }

#   filter {
#     name   = "tag:aws:eks:cluster-name"
#     values = [module.eks.cluster_id]
#   }

#   filter {
#     name   = "vpc-id"
#     values = [module.vpc.vpc_id]
#   }
# }

# # Asignar instancias al Target Group
# resource "aws_lb_target_group_attachment" "nginx_attachment" {
#   count            = length(data.aws_instances.madeo07_act3_nodes_instances.ids)
#   target_group_arn = aws_lb_target_group.nginx_tg.arn
#   target_id        = element(data.aws_instances.madeo07_act3_nodes_instances.ids, count.index)
#   port             = 80

#   depends_on = [
#     aws_lb.nginx_alb,
#     module.eks
#   ]
# }




