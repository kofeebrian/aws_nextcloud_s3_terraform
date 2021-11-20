resource "aws_route_table_association" "public_rt_as" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_rt_as_1" {
  subnet_id      = aws_subnet.private_subnet_nat.id
  route_table_id = aws_route_table.nat_route_table.id
}
