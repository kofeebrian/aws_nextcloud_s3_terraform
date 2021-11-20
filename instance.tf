data "template_cloudinit_config" "cloudinit-nextcloud" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = templatefile("script/install_nextcloud.sh", {})
  }

  part {
    content_type = "text/x-shellscript"
    content = templatefile("script/config_db.sh", {
      database_name = var.database_name
      database_user = var.database_user
      database_pass = var.database_pass
      admin_user    = var.admin_user
      admin_pass    = var.admin_pass
      data_dir      = var.data_dir
    })
  }

  part {
    content_type = "text/x-shellscript"
    content = templatefile("script/config_s3.sh", {
      bucket_name     = var.bucket_name
      region          = var.region
      user_access_key = aws_iam_access_key.nextcloud-s3-access_key.id
      user_secret_key = aws_iam_access_key.nextcloud-s3-access_key.secret
    })
  }

  part {
    content_type = "text/x-shellscript"
    content      = templatefile("script/apache_conf.sh", {})
  }

  part {
    content_type = "text/x-shellscript"
    content      = templatefile("script/finish_start.sh", {})
  }

  depends_on = [
    aws_iam_user.nextcloud-s3
  ]
}

resource "aws_instance" "web-server-instance" {
  ami               = var.ami
  instance_type     = "t2.micro"
  availability_zone = var.availability_zone

  key_name = var.key_name

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.web_server_nic.id
  }

  network_interface {
    device_index         = 1
    network_interface_id = aws_network_interface.web-db-nic.id
  }

  user_data = data.template_cloudinit_config.cloudinit-nextcloud.rendered

  tags = {
    Name = "web-server"
  }
}

data "template_file" "init-db" {
  template = file("script/install_db.sh")

  vars = {
    database_root_pass = var.database_pass
    database_user      = var.database_user
    database_name      = var.database_name
    database_pass      = var.database_pass
  }
}

resource "aws_instance" "db-instance" {
  ami               = var.ami
  instance_type     = "t2.micro"
  availability_zone = var.availability_zone

  key_name = var.key_name

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.db-nat-nic.id
  }

  network_interface {
    device_index         = 1
    network_interface_id = aws_network_interface.db-web-nic.id
  }

  user_data = data.template_file.init-db.rendered

  tags = {
    Name = "db-server"
  }
}
