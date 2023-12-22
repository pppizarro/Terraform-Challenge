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
| [google_container_cluster.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster) | resource |
| [google_container_node_pool.challenge_node_pool](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool) | resource |
| [google_project_iam_member.gke_sa_nodes_roles](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.container_api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.gke_sa_node](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_compute_network.challenge_vpc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network) | data source |
| [google_compute_subnetwork.challenge_subnet](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_subnetwork) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | GKE cluster name | `string` | n/a | yes |
| <a name="input_k8s_ip_range_pods"></a> [k8s\_ip\_range\_pods](#input\_k8s\_ip\_range\_pods) | CIDR to be used for pods | `string` | `""` | no |
| <a name="input_k8s_ip_range_svcs"></a> [k8s\_ip\_range\_svcs](#input\_k8s\_ip\_range\_svcs) | CIDR to be used for services | `string` | `""` | no |
| <a name="input_k8s_master_block"></a> [k8s\_master\_block](#input\_k8s\_master\_block) | CIDR to be used for GKE master nodes | `string` | n/a | yes |
| <a name="input_master_authorized_networks_config"></a> [master\_authorized\_networks\_config](#input\_master\_authorized\_networks\_config) | n/a | <pre>list(object({<br>    cidr_block   = string<br>    display_name = string<br>  }))</pre> | `[]` | no |
| <a name="input_node_network_tags"></a> [node\_network\_tags](#input\_node\_network\_tags) | Network tags to be applied to nodes | `list(string)` | `[]` | no |
| <a name="input_node_pool"></a> [node\_pool](#input\_node\_pool) | Node Pool configuration | <pre>object({<br>    name       = string,<br>    node_count = number,<br>    autoscaling = object({<br>      min_node_count = number,<br>      max_node_count = number<br>    })<br>    machine_type = string,<br>    disk_type    = string,<br>    disk_size_gb = number<br>    image_type   = string,<br>  })</pre> | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP Project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The GCP region | `string` | n/a | yes |
| <a name="input_service_account_node_name"></a> [service\_account\_node\_name](#input\_service\_account\_node\_name) | n/a | `string` | `"gke-sa-nodes"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The GCP zone | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->