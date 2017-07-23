variable "region" {
  default = "us-west1-a" // We're going to need it in several places in this config
}

provider "google" {
  credentials = "${file("account.json")}"
  project     = "homework-174618"
  region      = "${var.region}"
}

resource "google_compute_instance" "weatherchk" {
  count        = 1 // Adjust as desired
  name         = "weatherchk${count.index + 1}" // yields "weatherchk1", "weatherchk2", etc. It's also the machine's name and hostname
  machine_type = "f1-micro" // smallest (CPU &amp; RAM) available instance
  zone         = "${var.region}" // yields "europe-west1-d" as setup previously. Places your VM in Europe
  tags = [www-mode"]

  disk {
    image = "ubuntu-1604-xenial-v20170721" // the operative system (and Linux flavour) that your machine will run
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP - leaving this block empty will generate a new external IP and assign it to the machine
    }
  }
}
resource "google_compute_firewall" "www" {
  name = "weatherchk-www-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["www-node"]
}
