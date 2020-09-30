data "template_file" "init-script" {
  template = file("scripts/init.cfg")
  vars = {
    REGION = var.AWS_REGION
  }
}

data "template_file"  "shell-script" {
  template = file("scripts/user-data.sh")
  vars = {
   DEVICE = var.volume_path
  }
}

data "template_cloudinit_config" "cloud-init-config" {
  gzip = false
  base64_encode = false
  part {
    filename = "init.cfg"
    content_type = "text/cloud-config"
    content = data.template_file.init-script.rendered
  }

  part {
    content_type = "text/x-shellscript"
    content = data.template_file.shell-script.rendered
  }
}