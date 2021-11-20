resource "aws_eip" "nextcloud-eip" {
  vpc                       = true
  network_interface         = aws_network_interface.web_server_nic.id
  associate_with_private_ip = "10.0.1.50"

  depends_on = [
    aws_network_interface.web_server_nic,
    aws_internet_gateway.gw
  ]

  tags = {
    Name = "public-eip"
  }
}

resource "aws_eip" "nat_eip" {
  vpc = true

  tags = {
    Name = "nat-eip"
  }
}
