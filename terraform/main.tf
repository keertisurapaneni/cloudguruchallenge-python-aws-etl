terraform {
//  required_providers {
//    aws = {
//      source = "hashicorp/aws"
//    }
//  }
  backend "remote" {
    organization = "keerti"

    workspaces {
      name = "cgc-etl"
    }
  }
}

