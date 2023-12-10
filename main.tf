module "mod3" {
  source = "./mod3"
}

output "mod3" {
  value = module.mod3
}
