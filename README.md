## Using modules and Workspaces Challengue 01

As new team member I have received the following challange with minimal requirements:

- Create two S3 buckets using Terraform. One using modules and the other using workspaces.
- The tfstate file must to be on AWS. The same S3 bucket can save both states(modules and workspaces).
- It should have the option to add a policy to the bucket (you should have one configured by default).
- It must have the option to configure versioning within the bucket (it must have a value configured by default).
- The code must be in a repository, one repo for modules, another for workspace (use folders as you need).

-----

Modules Repo: Here we create the backend S3 for modules and workspacs and 2 examples about creation S3 buckets using modules.