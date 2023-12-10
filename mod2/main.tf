variable "config" {
  type = object({
    detail2 = optional(string, "reasonable mod2 default")
    detail3 = string
  })
}

output "config" {
  value = var.config
}

module "mod1" {
  source = "../mod1"
  config = var.config
}

output "mod1" {
  value = module.mod1
}
