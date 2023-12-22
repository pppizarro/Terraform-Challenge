# Terraform-Challenge
Terraform Challenge

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.10.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_address.challenge_nat_ips](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_firewall.allow_healthcheck](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_global_address.private_ip_range](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_compute_network.challenge_vpc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_router.challenge_router](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_compute_router_nat.challenge_nat](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat) | resource |
| [google_compute_subnetwork.challenge_subnetwork](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_project_service.compute_api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.servicenetworking_api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_networking_connection.private_vpc_connection](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_networking_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_nat_ip_count"></a> [cloud\_nat\_ip\_count](#input\_cloud\_nat\_ip\_count) | Number of IPs that will be created to be used for Cloud NAT | `string` | n/a | yes |
| <a name="input_private_reserved_range"></a> [private\_reserved\_range](#input\_private\_reserved\_range) | Private IP range that will be used for Cloud SQL Instances | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The GCP region | `string` | n/a | yes |
| <a name="input_secondary_ranges"></a> [secondary\_ranges](#input\_secondary\_ranges) | Secondary Ranges | <pre>list(object(<br>    {<br>      name = string<br>      cidr = string<br>    }<br>  ))</pre> | n/a | yes |
| <a name="input_subnetwork_definition"></a> [subnetwork\_definition](#input\_subnetwork\_definition) | Subnetwork Definition | <pre>list(object(<br>    {<br>      name   = string<br>      cidr   = string<br>      region = string<br>    }<br>  ))</pre> | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | The GCP zone | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->