## AWS MFA-Group Module
---
A module for creating an IAM user with enforced PGP encrypted password, secret key and with abilities to rotate the IAM key 

### Assumptions
---
* You have a bootstrapped AWS account

### Creates
---
* An IAM user defined by username
* A login profile if enabled
* Adds user to the given groups
* An access / secret key encrypted via pgp (or keybase)
* SSH key to the user

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| create\_access\_key | Whether to create an IAM access key for user | string | `"true"` | no |
| enable\_login\_profile | Create a login profile for the user? | string | `"true"` | no |
| enabled | Create the IAM user? | string | `"true"` | no |
| force\_destroy | Force Destroy user even if there's a login profile + IAM key? | string | `"false"` | no |
| groups | List of IAM user groups this user should belong to | list | `<list>` | no |
| key\_version | The version of the key | string | `"1"` | no |
| password\_length | Minimum password length | string | `"12"` | no |
| password\_reset\_required | Require Password reset on first login | string | `"true"` | no |
| path | Path | string | `"/"` | no |
| permissions\_boundary | permissions_boundaries for the user | string | `""` | no |
| pgp\_key | Base-64 encoded PGP public key, or a keybase username in the form `keybase:username`. Required to encrypt password. | string | n/a | yes |
| rotating\_key | Set to true while the key is in rotation and version is changing | string | `"false"` | no |
| ssh\_key\_encoding | The public key encoding format to use in the response. SSH -> ssh-rsa format, PEM -> PEM | string | `"SSH"` | no |
| ssh\_public\_key | The SSH public key. The public key must be encoded in ssh-rsa format or PEM format | string | `""` | no |
| upload\_ssh\_key | Upload an SSH key for the IAM User | string | `"false"` | no |
| username | Username to create | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| keybase\_password\_decrypt\_command |  |
| keybase\_password\_pgp\_message |  |
| keybase\_secret\_key\_v1\_decrypt\_command |  |
| keybase\_secret\_key\_v1\_pgp\_message |  |
| keybase\_secret\_key\_v2\_decrypt\_command |  |
| keybase\_secret\_key\_v2\_pgp\_message |  |
| pgp\_key | PGP key used to encrypt sensitive data for this user |
| this\_iam\_access\_key\_id | The access key ID |
| this\_iam\_access\_key\_v1\_secret | The access key secret |
| this\_iam\_access\_key\_v1\_status | Active or Inactive. Keys are initially active, but can be made inactive by other means. |
| this\_iam\_access\_key\_v2\_secret | The access key secret |
| this\_iam\_access\_key\_v2\_status | Active or Inactive. Keys are initially active, but can be made inactive by other means. |
| this\_iam\_user\_arn | The ARN assigned by AWS for this user |
| this\_iam\_user\_login\_profile\_encrypted\_password | The encrypted password, base64 encoded |
| this\_iam\_user\_login\_profile\_key\_fingerprint | The fingerprint of the PGP key used to encrypt the password |
| this\_iam\_user\_name | The user's name |
| this\_iam\_user\_ssh\_key\_fingerprint | The MD5 message digest of the SSH public key |
| this\_iam\_user\_ssh\_key\_ssh\_public\_key\_id | The unique identifier for the SSH public key |
| this\_iam\_user\_unique\_id | The unique ID assigned by AWS |](## Inputs

## Usage example:
1. Set the input variables from above in vars.tf.  Remember to include your provider (AWS), specificaly the default region in your variables file.
2. Define the module using the following in your terraform config (usually your main.tf)
```json
module "username" {
  source                    = "git://github.com/skrunchtech/terraform-modules//iam_user?ref=v0.1.1"
  username                  = "myname"
  pgp_key                   = "keybase:myKeybaseUsername"
}
```
Example of rotating keys: 
```json
module "username" {
  source        = "git://github.com/skrunchtech/terraform-modules//iam_user?ref=v0.1.1"
  username      = "myname"
  pgp_key       = "keybase:myKeybaseUsername"
  rotating_key  = "true"
  key_version   = 2
}
```
3. The outputs can be seen with `terraform output -module=<module_name> <nameOfOutput>`
4. When rotating key, you will need to use two additional variables: 
   1. Set `key_version` to the version after the default `1`
   2. Set `rotating_keys` to `true`
   3. Do the `plan` and `apply`.  The output of the module will now show you two keys.  Take the v2 (newer version),  handoff and when come back when safe to delete v1 (older version)
   4. Set `rotating_keys` to `false`
   5. Do the `plan` and `apply` to delete the `v1` key
   6. Futuer rotations can continue by incrementing the key versions


## References
- https://www.terraform.io/docs/providers/aws/r/iam_user.html
- https://github.com/cloudposse/terraform-aws-iam-user
- https://github.com/terraform-aws-modules/terraform-aws-iam/tree/v0.3.0/modules/iam-user