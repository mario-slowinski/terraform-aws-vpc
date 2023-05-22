variable "separator" {
  type        = string
  description = "Single character to separate segments in object's name."
  default     = "."
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to be used instead of the ones composed automatically."
  default     = {}
}

variable "tags_keys" {
  type        = list(string)
  description = "List of tags keys."
  default = [
    "environment",
    "vendor",
    "product",
  ]
}

variable "tags_values" {
  type        = list(string)
  description = "List of tags values."
  default = [
    "",
    "",
    "",
  ]
}

variable "names_keys" {
  type        = list(string)
  description = "List of tags keys to be used for name composition."
  default = [
    "environment",
    "vendor",
    "product",
  ]
}
