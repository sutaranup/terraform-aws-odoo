output "instance_ip_addr" {
  value       = aws_instance.server.public_dns
  description = "The public DNS of the main server instance."
  sensitive   = true
}
