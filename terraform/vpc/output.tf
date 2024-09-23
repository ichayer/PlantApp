output "vpc_id" {
  value = aws_vpc.plantapp_vpc.id
  description = "ID of the VPC"
}