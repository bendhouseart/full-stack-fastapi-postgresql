// aws generic vars
AWS_REGION = "us-west-2"//{{cookiecutter.aws_region}}

// single instance vars
iam_instance_profile = "squarepeg"//{{cookiecutter.iam_instance_profile}}//"squarepeg"
network_name = "myvpc"//{{cookiecutter.network_name}}//"myvpc"
private_key_path = "mykey"//{{cookiecutter.private_key_path}}//"mykey"
public_key_path = "mykey.pub"//{{cookiecutter.public_key_path}}//"mykey.pub"
create_sg = "true"//{{cookiecutter.create_sg}}//"true"
//create = {{cookiecutter.create}} //"true"
//create_ebs_volume = {{cookiecutter.create_ebs_volume}} //"true"
domain_name = "launchwith.click"//{{cookiecutter.domain_main}} //"launchwith.click"

