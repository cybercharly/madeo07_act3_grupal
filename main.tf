
data "aws_eks_cluster" "madeo07_act3_grupal_module_cluster" {
  name       = module.eks.cluster_id
  depends_on = [module.eks]
}

data "aws_eks_cluster_auth" "madeo07_act3_grupal_module_cluster" {
  name       = module.eks.cluster_id
  depends_on = [module.eks]

}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "19.0.0"
  cluster_name    = "madeo07_act3_grupal"
  cluster_version = "1.32"

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = flatten([module.vpc.private_subnets])

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  enable_irsa = true

  eks_managed_node_groups = {
    madeo07_act3_nodes = {
      desired_size = 2
      max_size     = 3
      min_size     = 1

      instance_types = ["t3.nano"]
      capacity_type  = "SPOT"
      key_name       = "UNIR_MACBOOK_PRO_US-WEST-2"

      ami_type = "AL2_x86_64"

      bootstrap_extra_args = "--kubelet-extra-args '--node-labels=node.kubernetes.io/lifecycle=spot'"
    }
  }

  tags = {
    terraform = true
    materia   = "madeo07_act3_grupal"
  }
}

resource "aws_iam_role_policy_attachment" "madeo07_act3_ssm_policy" {
  role       = module.eks.eks_managed_node_groups["madeo07_act3_nodes"].iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "kubernetes_namespace" "madeo07_act3_grupal_namespace" {
  metadata {
    name = "madeo07-act3-grupal"
    annotations = {
      name = "madeo07-act3-grupal"
    }
  }
  depends_on = [
    data.aws_eks_cluster.madeo07_act3_grupal_module_cluster,
    module.eks,
  ]
}