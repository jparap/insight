This repo has terraform modules for setting up network infra and creating other resources needed for spot fleet.
1. Create the network infra by:
$ cd setup_network
$ terraform init (Modify the credentials file path)
$ terraform plan -var-file <terraform.tfvars>
$ terraform apply -var-file <terraform.tfvars>

2. We need to create iam roles and profiles that will be used by instances.
$ cd iam
$ terraform init (Modify the credentials file path)
$ terraform plan -var-file <vars.tfvars> 

3. You will get the subnet ids and security group ids from above terraform apply. Usually network setup is required once. 
We will create a spot fleet to create ec2 spot instances.
Modify the var file such that it uses the values recieved from above terraform run.
Then run following:
$ cd elk
$ terraform init (Modify the credentials file path and the run)
$ terraform plan -var-file env_variables/cloudwork.tfvars
$ terraform apply -var-file env_variables/cloudwork.tfvars
