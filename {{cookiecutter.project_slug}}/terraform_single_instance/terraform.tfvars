// aws generic vars
AWS_REGION = {{cookiecutter.aws_region}}

// single instance vars
iam_instance_profile = {{cookiecutter.iam_instance_profile}}//"squarepeg"
network_name = {{cookiecutter.network_name}}//"myvpc"
private_key_path = {{cookiecutter.private_key_path}}//"mykey"
public_key_path = {{cookiecutter.public_key_path}}//"mykey.pub"
create_sg = {{cookiecutter.create_sg}}//"true"
create = {{cookiecutter.create}} //"true"
create_ebs_volume = {{cookiecutter.create_ebs_volume}} //"true"
domain_name = {{cookiecutter.domain_name}} //"launchwith.click"

