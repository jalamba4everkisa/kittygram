terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

  backend "s3" {
    endpoints = {
      s3 = "http://storage.yandexcloud.net"
    }
    bucket = "kittygram-nndanchenko"
    region = "ru-central1"
    key    = "terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  } 
}

provider "yandex" {
    service_account_key_file = "authorized_key.json"
    cloud_id  = var.YC_CLOUD_ID
    folder_id = var.YC_FOLDER_ID
    zone = var.YC_ZONE
}
