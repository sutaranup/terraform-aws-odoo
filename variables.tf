variable "instance_type" {
  type        = string
  description = "The EC2 instance type"
  default     = "t3.small"
  validation {
    condition     = contains(["t3.micro", "t3.small", "t3.medium", "t3.large", "t3.xlarge", "t3.2xlarge"], var.instance_type)
    error_message = "Instance type must be t3"
  }
}