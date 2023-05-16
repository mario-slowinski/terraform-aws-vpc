azure-virtual-network
=======================

Terraform [Azure Virtual Network](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview).

Required providers
------------------

* [hashicorp/azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)

Variables
--------------

* `variables.tf`
  * `separator`: Single character to separate segments in object's name.
  * `name`: The name of the virtual network. Generated from tags if not set.
  * `location`: The location/region where the virtual network is created.
  * `tags_keys`: The list of tags keys.
  * `tags_keys`: The list of tags values.
  * `names_keys`: The list of names keys to be used for name generation.
* `virutal_network.vars.tf`
  * `resource_group_name`: The name of the resource group in which to create the virtual network.
  * **`address_space`**: The list of address spaces used by the virtual network.

Outputs
--------------

* `data`: Virtual network data.

Dependencies
------------

*No* *dependencies*

Examples
--------

* `main.tf`

  ```terraform
  module "azure-virtual-network" {
    sources = "github.com/mario-slowinski/terraform-azure-virtual-network"
  }
  ```

License
-------

[GPL-3.0](https://www.gnu.org/licenses/gpl-3.0.html)

Author Information
------------------

[mario.slowinski@gmail.com](mailto:mario.slowinski@gmail.com)
