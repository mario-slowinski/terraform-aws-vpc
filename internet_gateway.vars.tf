variable "internet_gateway" {
  type        = map(string)
  description = "Map of tags, create internet gateway if not null."
  default     = null
}
