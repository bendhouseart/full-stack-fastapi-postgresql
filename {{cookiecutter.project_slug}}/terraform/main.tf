resource "random_pet" "this" {}

data "aws_caller_identity" "this" {}

module "ami" {
  source = "github.com/insight-infrastructure/terraform-aws-ami.git?ref=v0.1.0"
}

resource "aws_key_pair" "this" {
  count      = var.public_key_path != "" && var.create ? 1 : 0
  public_key = file(var.public_key_path)
}

locals {
  tags = merge(var.tags, { Name = var.name })
}

locals {
  logging_bucket_name = var.logging_bucket_name == "" ? "logs-${data.aws_caller_identity.this.account_id}" : var.logging_bucket_name
}

// Option 1
//data "template_file" "this" {
  //template = file("${path.module}/user-data.sh")
  //vars = {
   // foo = "bar"
  //}
//}

//// Option 2
//resource "template_cloudinit_config" "this" {
//  part {}
//}

resource "aws_instance" "this" {
  count         = var.create ? 1 : 0
  ami           = module.ami.ubuntu_1804_ami_id
  instance_type = var.instance_type

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
    iops        = var.root_iops
  }

//  Important
  user_data = data.template_cloudinit_config.cloud-init-config.rendered

  subnet_id              = var.subnet_id
  vpc_security_group_ids = compact(concat(aws_security_group.this.*.id, var.additional_security_group_ids))

  iam_instance_profile = var.iam_instance_profile
  key_name             = var.public_key_path == "" ? var.key_name : aws_key_pair.this.*.key_name[0]

  tags = merge({ name = var.name }, local.tags)
}

variable "domain_name" {
  description = "The domain - example.com. Blank for no ssl / nginx"
  type        = string
  default     = ""
}

variable "hostname" {
  description = "The hostname - ie hostname.example.com"
  type        = string
  default     = "airflow"
}

data "aws_route53_zone" "this" {
  count = var.domain_name != "" ? 1 : 0
  name  = var.domain_name
}

resource "aws_route53_record" "this" {
  count = var.domain_name != "" && var.hostname != "" ? 1 : 0

  name    = "${var.hostname}.${var.domain_name}"
  type    = "A"
  ttl     = "300"
  zone_id = join("", data.aws_route53_zone.this.*.id)
  records = [join("", aws_instance.this.*.public_ip)]
}

resource "aws_security_group" "this" {
  count = var.create_sg && var.create ? 1 : 0
  vpc_id = var.vpc_id == "" ? null : var.vpc_id

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "public_ports" {
  count = var.create_sg && var.create ? length(var.public_ports) : 0

  type              = "ingress"
  security_group_id = join("", aws_security_group.this.*.id)
  protocol          = "tcp"
  from_port         = var.public_ports[count.index]
  to_port           = var.public_ports[count.index]
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "private_ports" {
  count = var.create_sg && var.create ? length(var.private_ports) : 0

  type              = "ingress"
  security_group_id = join("", aws_security_group.this.*.id)
  protocol          = "tcp"
  from_port         = var.private_ports[count.index]
  to_port           = var.private_ports[count.index]
  cidr_blocks       = var.private_port_cidrs
}
