//eks specific vars
num_workers = {{cookiecutter.eks_num_workers}}
cluster_autoscale = {{cookiecutter.eks_cluster_autoscale}}
cluster_autoscale_min_workers = {{cookiecutter.eks_cluster_autoscale_min_workers}}
cluster_autoscale_max_workers = {{cookiecutter.eks_cluster_autoscale_max_workers}}

// aws vars
id = "{{cookiecutter.eks_cluster_name}}"
region = "{{cookiecutter.aws_region}}"
vpc_name = "{{cookiecutter.vpc_name}}"
//azs = {{cookiecutter.azs}}
//num_azs = {{cookiecutter.num_azs}}


