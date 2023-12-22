# Terraform-Challenge
Terraform Challenge

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.10.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | 5.10.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_sql_database_instance.challenge](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_sql_database_instance) | resource |
| [google_sql_database.database](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database) | resource |
| [google_sql_user.user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |
| [random_id.db_name_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [google_compute_network.challenge_vpc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_sql_enable_public_ip"></a> [cloud\_sql\_enable\_public\_ip](#input\_cloud\_sql\_enable\_public\_ip) | Enable public IP for the GCP Cloud SQL instance | `bool` | `false` | no |
| <a name="input_databases"></a> [databases](#input\_databases) | The list of databases to create in the GCP Cloud SQL instance | `list(string)` | n/a | yes |
| <a name="input_db_users"></a> [db\_users](#input\_db\_users) | The list of database users to create in the GCP Cloud SQL instance | `map(string)` | n/a | yes |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | Enable deletion protection for the GCP Cloud SQL instance | `bool` | `true` | no |
| <a name="input_instance_tier_type"></a> [instance\_tier\_type](#input\_instance\_tier\_type) | The GCP Cloud SQL instance tier type | `string` | n/a | yes |
| <a name="input_postgres_database_version"></a> [postgres\_database\_version](#input\_postgres\_database\_version) | The GCP Postgres database version | `string` | `"POSTGRES_15_2"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The GCP region | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->