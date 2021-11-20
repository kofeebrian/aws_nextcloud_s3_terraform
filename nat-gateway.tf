resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    name = "nat-gw"
  }

  depends_on = [
    aws_internet_gateway.gw
  ]
}
