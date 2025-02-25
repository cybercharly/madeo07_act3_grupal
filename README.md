# madeo07_act3_grupal
Construcción de aplicativo en contenedores y despliegue en un clúster de Kubernetes

## Resumen

**Terraform - Infraestructura como Codigo**

En este DEMO se planea demostrar el uso de Terraform para desplegar un cluster de EKS sobre AWS para posteriormente desplegar 2 deployments usando `kubectl`, los deployments constan de un app web y una base de datos custom con contenedores creados por el quipo y alojados en [hub.docker.com](https://hub.docker.com/repository/docker/cybercharly/madeo07_act3_grupal/tags)

## Como usar

### Pre-requisitos
* Clonar este repositorio localmente
* Tener una cuenta de AWS
* Asegurate de tus credenciales de acceso programatico estan previamente configuradas con `aws configure`, [puedes seguir la documentacion oficial](https://docs.aws.amazon.com/cli/v1/userguide/cli-authentication-user.html)
* Asegurate de que tienes instalado terraform en tu equipo, [puedes seguir la documentacion oficial](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* Actualiza `providers.tf` linea`3` con la informacion de tus credenciales de AWS
* Ejecuta los siguientes comandos

```bash
terraform init
terraform validate
terraform apply --auto-approve
```

## Comenzando
**Ejemplo**

```terraform
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

      instance_types = ["t3.medium"]
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

```


### Notable
* se debe desplegar el cluster de eks primero y despues desplegar los deployments de eks

## Contribuidores al Proyecto
| Nombre | Email |
|------|-------|
| Juan Carlos Perez Hernandez | jc.przhdz@gmail.com |
| Fernando Hernandez | fernandoh05@outlook.com |
| Eduardo José Gil Apastillar | eduardojgila@gmail.com |

# Registro de Cambios
***
### Version 1.0.0
***Se Agregaron***
* Se agrego el codigo terraform para crear la red
* Se agrego el codigo terraform para crear el eks cluster
* Se agrego el codigo con los dockerfile
* se agregaron los yaml para los deployments declarativos
* Se agrego el README