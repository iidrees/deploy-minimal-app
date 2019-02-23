# Deploy a PREN stack on AWS Using Packer, Ansible & Terraform.

## Introduction
This repository contains scripts that would enable you minimally setup your deployment to Amazon Web Services by just running a couple of commands.



### Technology and Platforms Used

- [Packer](https://www.packer.io/docs/index.html) 
- [Ansible](https://docs.ansible.com/ansible/latest/index.html)
- [Terraform](https://www.terraform.io/docs/index.html)
- [AWS](aws.amazon.com)
- [NGINX](https://www.nginx.com/)

### How to Build Amazon Machine Images (AMI) for your deployment

In the root directory, you would see a folder called `packer`, that is where the `json` file packer would use to create the machine image is.

In order to create a machine image on AWS, please do the following:
- export the AWS_ACCESS_KEY, AWS_SECRET_KEY & AWS_REGION in your terminal like this
  - `export AWS_ACCESS_KEY=<paste your aws access keys here>`
  - `export AWS_SECRET_KEY=<paste your secret keys here>`
  - `export AWS_REGION=<paste your region here i.e. eu-west-1>`

- After exporting the variables above, run the command `packer build packer/ubuntu_image.json` image build process.
  - After running the command you'll see the build flow on your terminal and you can also check your `AWS EC2 console` 


### How To Launch AMIs With Terraform.
To launch AMI machine images on AWS do the following 
- Change directory into the `Terraform` folder by running this command `cd terraform` from your terminal
- In the `terraform` directory, run the command `terraform init` 
- Before running any other terraform commands, you should export this value `export AWS_AMI_ID=<AMI ID generated at the end of the packer build>` in the terminal.
- After initialising the directory, run the command `terraform plan -var="access_key=${AWS_ACCESS_KEY}" -var="secret_key=${AWS_SECRET_KEY}" -var="region=${AWS_REGION}" -var=${AWS_AMI_ID}`
- After running `terraform plan` above, run the command `terraform plan -var="access_key=${AWS_ACCESS_KEY}" -var="secret_key=${AWS_SECRET_KEY}" -var="region=${AWS_REGION}" -var=${AWS_AMI_ID} -auto-approve` to begin the process of launching the instance.

### How To Automate the Above Steps

In the root of the project, there is a `deploy.sh` script you can use to create both the `packer AMI` and deploy & launch the AMI created on AWS.

To run the script, ensure that you all the necesary environment variables described above exported into the environment. Then run the command `./deploy.sh` and then watch the terminal to see how the deployment happens.

### CLEANUP
When you are done with EC2 instances created with the `deploy.sh` script, all you need to do in the root of the project is to run another script `./destroy.sh` in order to tear down all the resources created by the `./deploy.sh` script.