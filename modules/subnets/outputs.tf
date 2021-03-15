#  Outputs for subnets

output "app-private-subnet-OCID" {
  value = oci_core_subnet.app-private-subnet.id
}

output "app-public-subnet-OCID" {
  value = oci_core_subnet.app-public-subnet.id
}

output "bastion-public-subnet-OCID" {
  value = oci_core_subnet.bastion-public-subnet.id
}