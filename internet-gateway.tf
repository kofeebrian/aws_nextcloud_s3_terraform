resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.nextcloud_vpc.id
  tags = {
    Name = "internet-gateway"
  }
}

