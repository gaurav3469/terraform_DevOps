terraform {
  backend "gcs" {
    bucket  = "tf_bucket3469"
    prefix  = "terraform/state"
  }
}


resource "google_compute_instance" "windows_vm" {
name         = "app-server"
  machine_type = "n1-standard-2"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "projects/windows-cloud/global/images/windows-server-2019-dc-core-v20211012"
    }
  }

  metadata_startup_script = <<EOF
    <powershell>
    # Set Windows password
    $password = ConvertTo-SecureString "<PASSWORD>" -AsPlainText -Force
    $user = [adsi]"WinNT://./Administrator, user"
    $user.SetPassword($password)

    # Create a local user
    $username = "<USERNAME>"
    $password = "<PASSWORD>"
    $securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force
    $localUser = New-LocalUser -Name $username -Password $securePassword -UserMayNotChangePassword -PasswordNeverExpires
    Add-LocalGroupMember -Group "Administrators" -Member $username
    </powershell>
  EOF

  network_interface {
    network = "default"
  }
}
