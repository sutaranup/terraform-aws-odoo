output "instance_public_dns" {
  value       = aws_instance.server.public_dns
  description = "The public DNS of the main server instance."
}

output "instance_public_ip" {
  value = aws_eip.odoo_eip.public_ip
  description = "The public IP of the main server instance."
}