resource "oci_core_instance" "grafana_instance" {
  # Required
  availability_domain = lookup(data.oci_identity_availability_domains.ads.availability_domains[0],"name")
  compartment_id = var.compartment_ocid
  shape = var.instance_shape
  source_details {
    source_id = data.oci_core_images.InstanceImageOCID.images[0].id
    source_type = "image"
  }

  # Optional
  display_name = "grafana-instance"
  create_vnic_details {
    assign_public_ip = true
    subnet_id = var.subnet_id
  }
  metadata = {
    ssh_authorized_keys = chomp(file(var.ssh_public_key))
  }
  preserve_boot_volume = false
}