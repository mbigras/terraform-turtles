variable "config" {
  type = object({
    detail3 = string
  })
}

output "config" {
  value = var.config
}

module "mod2" {
  source = "./mod2"
  config = var.config
}

output "mod2" {
  value = module.mod2
}
