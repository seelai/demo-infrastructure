# Create security lists

resource "oci_core_security_list" "app-private-sl" {
  compartment_id = var.compartment_ocid
  display_name = "app-private-security-list"
  vcn_id = var.vcn_id

  egress_security_rules {
    stateless = false
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol = "all"
  }

  ingress_security_rules {
    stateless = false
    source = "10.0.1.0/24"
    source_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options {
      min = 8080
      max = 8080
    }
  }

  ingress_security_rules {
    stateless = false
    source = "10.0.2.0/29"
    source_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    stateless = false
    source = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol = "1"

    icmp_options {
      type = 3
      code = 4
    }
  }

  ingress_security_rules {
    stateless = false
    source = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    protocol = "1"

    icmp_options {
      type = 3
    }
  }
}

resource "oci_core_security_list" "app-public-sl" {
  compartment_id = var.compartment_ocid
  display_name = "app-public-security-list"
  vcn_id = var.vcn_id

  egress_security_rules {
    stateless = false
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol = "all"
  }

  ingress_security_rules {
    stateless = false
    source = "0.0.0.0/0"
    protocol = "6"
    tcp_options {
      min = 80
      max = 80
    }
  }

  ingress_security_rules {
    stateless = false
    source = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol = "1"

    icmp_options {
      type = 3
      code = 4
    }
  }

  ingress_security_rules {
    stateless = false
    source = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    protocol = "1"

    icmp_options {
      type = 3
    }
  }
}


resource "oci_core_security_list" "bastion-public-sl" {
  compartment_id = var.compartment_ocid
  display_name = "bastion-public-security-list"
  vcn_id = var.vcn_id

  egress_security_rules {
    stateless = false
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol = "all"
  }

  ingress_security_rules {
    stateless = false
    source = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options {
      min = 8080
      max = 8080
    }
  }

  ingress_security_rules {
    stateless = false
    source = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options {
      min = 3000
      max = 3000
    }
  }

  ingress_security_rules {
    stateless = false
    source = "0.0.0.0/0"
    protocol = "6"
    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    stateless = false
    source = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol = "1"

    icmp_options {
      type = 3
      code = 4
    }
  }

  ingress_security_rules {
    stateless = false
    source = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    protocol = "1"

    icmp_options {
      type = 3
    }
  }
}

resource "oci_core_subnet" "app-private-subnet" {

  compartment_id = var.compartment_ocid
  vcn_id = var.vcn_id
  cidr_block = "10.0.0.0/24"
  route_table_id = var.vcn_nat_route_id
  security_list_ids = [oci_core_security_list.app-private-sl.id]
  display_name = "app-private-subnet"
}

resource "oci_core_subnet" "app-public-subnet" {

  compartment_id = var.compartment_ocid
  vcn_id = var.vcn_id
  cidr_block = "10.0.1.0/24"
  route_table_id = var.vcn_ig_route_id
  security_list_ids = [oci_core_security_list.app-public-sl.id]
  display_name = "app-public-subnet"
}

resource "oci_core_subnet" "bastion-public-subnet" {

  compartment_id = var.compartment_ocid
  vcn_id = var.vcn_id
  cidr_block = "10.0.2.0/29"
  route_table_id = var.vcn_ig_route_id
  security_list_ids = [oci_core_security_list.bastion-public-sl.id]
  display_name = "bastion-public-subnet"
}



