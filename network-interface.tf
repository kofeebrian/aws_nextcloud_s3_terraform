resource "aws_network_interface" "web_server_nic" {
  subnet_id       = aws_subnet.public_subnet.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.allow_web.id]

  tags = {
    Name = "public-web"
  }
}

resource "aws_network_interface" "web-db-nic" {
  subnet_id   = aws_subnet.private_subnet_db.id
  private_ips = ["10.0.2.50"]

  tags = {
    Name = "web-db"
  }
}

resource "aws_network_interface" "db-web-nic" {
  subnet_id       = aws_subnet.private_subnet_db.id
  private_ips     = ["10.0.2.51"]
  security_groups = [aws_security_group.allow_db.id]

  tags = {
    Name = "db-web"
  }
}

resource "aws_network_interface" "db-nat-nic" {
  subnet_id   = aws_subnet.private_subnet_nat.id
  private_ips = ["10.0.3.50"]

  tags = {
    Name = "db-nat"
  }
}
