provider "google" {
  credentials = file("optimum-tensor-382601-db1c680ef697.json")
  project     = "optimum-tensor-382601"
  region      = "us-central1"
  zone        = "us-central1-a"
}
