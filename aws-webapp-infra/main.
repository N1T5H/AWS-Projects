module "networking" {
  source = "./modules/networking"
  vpc_cidr = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "compute" {
  source = "./modules/compute"
  vpc_id = module.networking.vpc_id
  public_subnet_ids = module.networking.public_subnet_ids
  private_subnet_ids = module.networking.private_subnet_ids
  instance_type = var.instance_type
  min_size = var.min_size
  max_size = var.max_size
}

module "database" {
  source = "./modules/database"
  vpc_id = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnet_ids
  db_name = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}

