# Create Compartments

module "compartments" {
  source = "./modules/compartments"
  tenancy_ocid = var.tenancy_ocid
}

# Create VCN
module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "2.0.0"

  compartment_id  = var.tenancy_ocid
  region  = var.region
  vcn_dns_label = "demo"
  vcn_name  = "demo-vnc"

  internet_gateway_enabled = true
  nat_gateway_enabled = true
  service_gateway_enabled = true
  vcn_cidr = "10.0.0.0/16"
}

# Create Subnets
module "subnets" {
  source = "./modules/subnets"
  compartment_ocid = var.tenancy_ocid
  app_compartment_ocid = module.compartments.app-compartment-OCID
  bastion_compartment_ocid = module.compartments.bastion-compartment-OCID
  vcn_id = module.vcn.vcn_id
  vcn_nat_route_id = module.vcn.nat_route_id
  vcn_ig_route_id = module.vcn.ig_route_id
}

# Create Jenkins Instance
module "jenkins-master" {
  source                = "./modules/jenkins-master"
  tenancy_ocid          = var.tenancy_ocid
  availability_domain   = var.availability_domain
  compartment_ocid      = module.compartments.bastion-compartment-OCID
  master_display_name   = var.master_display_name
  instance_shape        = var.instance_shape
  instance_user         = var.instance_user
  subnet_id             = module.subnets.bastion-public-subnet-OCID
  jenkins_version       = var.jenkins_version
  jenkins_password      = var.jenkins_password
  http_port             = var.http_port
  ssh_public_key        = var.ssh_public_key
  ssh_private_key       = var.ssh_private_key
  plugins               = var.plugins
  instance_os           = var.instance_os
  linux_os_version      = var.linux_os_version
}

# Create Grafana Instance
module "grafana" {
  source = "./modules/grafana"
  tenancy_ocid          = var.tenancy_ocid
  compartment_ocid      = module.compartments.bastion-compartment-OCID
  subnet_id             = module.subnets.bastion-public-subnet-OCID
  ssh_public_key        = var.ssh_public_key
  availability_domain   = var.availability_domain
  instance_shape        = var.instance_shape
  instance_os           = var.instance_os
  linux_os_version      = var.linux_os_version
}