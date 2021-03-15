# Create Application Compartment
resource "oci_identity_compartment" "app-compartment" {
    compartment_id = var.tenancy_ocid
    description = "Compartment for Application resources."
    name = "application-compartment"
}

# Create Bastion Compartment
resource "oci_identity_compartment" "bastion-compartment" {
    compartment_id = var.tenancy_ocid
    description = "Compartment for Bastion resources."
    name = "bastion-compartment"
}
