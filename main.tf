variable "config" {
  type = object({
    detail1 = string
    detail2 = string
    detail3 = string
  })
}

output "config" {
  value = var.config
}
