## AWS MFA-Group Module
---
A module for creating an IAM user with enforced PGP encrypted password, secret key and with abilities to rotate the IAM key 

### Assumptions
---
* You have a bootstrapped AWS account
* Billing administration via IAM roles is enabled 

### Creates
---
By default, this module will create:
* Admin Group and attach admin policies along with provided list of users
* Read Only Admin Group and attach RO admin policies along with provided list of users
* Developer Group and attach provided list of users. No policies are attached to this group
* Billing Admin group (if set to true) and attach policies along with the list of users provided
* Create a Force MFA policy and attach it to all of the groups and allow password change without mfa by default

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| allow\_password\_change\_without\_mfa | Allow changing the user password without MFA | string | `"true"` | no |
| billing\_admin\_users | Name of the IAM users to add to Billing Admin group | list | `<list>` | no |
| create\_admin | Create admin group? | string | `"true"` | no |
| create\_billing\_admin | Create Billing Admin Group? | string | `"false"` | no |
| create\_dev | Create developer Group? | string | `"true"` | no |
| create\_force\_mfa\_policy | Create policy that forces MFA usage | string | `"true"` | no |
| create\_ro\_admin | Create read-only admin group? | string | `"true"` | no |
| dev\_users | Name of the IAM users to add to Developer group | list | `<list>` | no |
| force\_mfa\_admin | Attach Force MFA policy to Admin group users? | string | `"true"` | no |
| force\_mfa\_billing\_admin | Attach Force MFA policy to Billing Admin group users? | string | `"true"` | no |
| force\_mfa\_dev | Attach Force MFA policy to Developer group users? | string | `"true"` | no |
| force\_mfa\_ro\_admin | Attach Force MFA policy to RO Admin group users? | string | `"true"` | no |
| full\_admin\_users | Name of the IAM users to add to Admin group | list | `<list>` | no |
| ro\_admin\_users | Name of the IAM users to add to Read Only Admin group | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| admin\_iam\_group\_arn | Admin Group ARN |
| admin\_iam\_group\_id | Admin Group ID |
| admin\_iam\_group\_name | Admin Name |
| admin\_iam\_group\_users | admin Group users |
| billing\_admin\_iam\_group\_arn | billing_admin Group ARN |
| billing\_admin\_iam\_group\_name | Billing Admin Name |
| billing\_admin\_iam\_unique\_id | billing_admin Group ID |
| billing\_admins\_iam\_group\_users | billing_admin Group users |
| developer\_iam\_group\_arn | Developer Group ARN |
| developer\_iam\_group\_name | Developer Admin Name |
| developer\_iam\_unique\_id | Developer Group ID |
| developers\_iam\_group\_users | developers Group users |
| force\_mfa\_policy\_arn | Force MFA Policy ARN |
| read\_only\_admin\_iam\_group\_name | Read only Admin Name |
| read\_only\_admin\_iam\_group\_users | Readonly admin Group users |
| ro\_admin\_iam\_group\_arn | Readonly Admin Group ARN |
| ro\_admin\_iam\_unique\_id | Readonly Admin Group ID |

## Usage example:
1. Set the input variables from above in vars.tf.  Remember to include your provider (AWS), specificaly the default region in your variables file.
2. Define the module using the following in your terraform config (usually your main.tf)
```json
module "default_iam_groups" {
  source                    = "git://github.com/skrunchtech/terraform-modules//iam_groups?ref=v0.2.0"
}
```
Example of not allowing a  particular module
```json
module "username" {
  source        = "git://github.com/skrunchtech/terraform-modules//iam_groups?ref=v0.2.0"
  create_dev    = "false"
}
```
3. The outputs can be seen with `terraform output -module=<module_name> <nameOfOutput>`
4. Remember to add any policies to developer group by using the output `developer_iam_group_name` in further policy attachment resource declarations


## References
- https://github.com/jeromegamez/terraform-aws-enforce-mfa
- https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_users-self-manage-mfa-and-creds.html
- https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_billing.html