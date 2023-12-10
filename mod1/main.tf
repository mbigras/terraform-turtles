variable "config" {
  type = object({
    detail1 = optional(string, "reasonable mod1 default")
    detail2 = string
    detail3 = string
  })
}

output "config" {
  value = var.config
}
