provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source         = "./modules/ec2"
  web_subnet_ids = [module.vpc.app-subnet-public-az1, module.vpc.app-subnet-public-az2]
  app_subnet_ids = [module.vpc.app-subnet-private-az1, module.vpc.app-subnet-private-az2]
  vpc_id         = module.vpc.vpc_id
  web_lb_sg      = module.vpc.web-lb-sg-id
  web_tier_sg    = module.vpc.web-tier-sg-id
  app_tier_sg    = module.vpc.app-tier-sg-id
  depends_on = [
    module.vpc
  ]
}

module "database" {
  source        = "./modules/database"
  db_subnet_ids = module.vpc.db_subnet_group
  db_sg_id      = module.vpc.database-sg-id
  depends_on = [
    module.vpc
  ]
}