## AWS VPC Module
---
A module for creating a VPC adhering to the first scenario described in the AWS documentation but with multiple public subnets. https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Scenario1.html 

### Assumptions
---
* You have a bootstrapped AWS account

### Creates
---
* VPC with the given CIDR
* Public Subnets (for the given CIDR ranges)
* Internet Gateway
* Public Route Table 

## Input Variables
* `vpc_cidr` - CIDR block for the VPC (required, format: 10.0.0.0/16)
* `public_subnets` - List of public subnets CIDRs (required, e.g. [10.0.0.1/24, 10.0.0.2/24])
* `vpc_name` - Mame of the VPC required for tags and identification(required)
* `azs` - List of AZs to be used for the subnets(required)
* `map_public_ip_on_launch` - Assign public IP by default to instances launched (Optional, default: false)
* `env` - Environment that is serviced by this VPC (required for tagging)
* `tags` - A mapping of additional tags to assign to the resource, in addition to the regular tags. (Optional; Default: Name, Terraform, Environment)

## Outputs
* `vpc_id`
* `vpc_cidr_block`
* `default_network_acl_id`
* `default_security_group_id`
* `default_route_table_id`
* `vpc_main_route_table_id`
* `public_subnets` - Public Subnets IDs
* `public_subnets_cidr_blocks`
* `public_route_table_ids`
* `igw_id` - Internet Gateway ID

## Usage example:
1. Set the input variables from above in vars.tf.  Remember to include your provider (AWS), specificaly the default region in your variables file.
2. Define the module using the following in your terraform config (usually your main.tf)
```json
module "vpc" {
  source                    = "git://github.com/skrunchtech/terraform-modules//vpc?ref=v0.1.0"
  vpc_cidr                  = "10.143.0.0/16"
  public_subnets            = ["10.143.16.0/20", "10.143.32.0/20"]
  azs                       = ["us-east-1a", "us-east-1b", "us-east-1c"]
  vpc_name                  = "myapp_dev_vpc"
  map_public_ip_on_launch   = "true"
  env                       = "dev"
  tags {
      "Owner" = "amalhotra"
  }
}
```
3. The outputs can be seen with `terraform output -module=<module_name> <nameOfOutput>`
4. You can always use the console to get subnets from your CIDR block by making use of the "cidrsubnet" function provided by terraform or use: http://www.davidc.net/sites/default/subnets/subnets.html

## References
- https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Scenario1.html
- http://www.davidc.net/sites/default/subnets/subnets.html
- https://github.com/terraform-aws-modules/terraform-aws-vpc
- https://fishingcatblog.wordpress.com/2016/09/22/terraform-interpolation-cidrsubnet/
- http://blog.itsjustcode.net/blog/2017/11/18/terraform-cidrsubnet-deconstructed/