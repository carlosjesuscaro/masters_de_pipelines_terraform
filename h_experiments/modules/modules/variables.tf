variable "aws_region" {
  description = "Define the region in which the instance should be created."
  type        = string
  default     = "us-east-2"
  validation {
    condition     = contains(["us-east-2", "us-west-2", "af-south-1", "ap-east-1", "ap-south-1"], var.aws_region)
    error_message = "*** This is NOT a valid AWS region. ***"
  }
}