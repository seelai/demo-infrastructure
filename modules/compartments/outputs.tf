# Outputs for compartment

output "app-compartment-name" {
  value = oci_identity_compartment.app-compartment.name
}

output "app-compartment-OCID" {
  value = oci_identity_compartment.app-compartment.id
}

output "bastion-compartment-name" {
  value = oci_identity_compartment.bastion-compartment.name
}

output "bastion-compartment-OCID" {
  value = oci_identity_compartment.bastion-compartment.id
}