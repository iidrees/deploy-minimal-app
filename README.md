# Deploy a PREN stack on a AWS Using Packer, Ansible & Terraform.

## Introduction
This repository contains scripts that would enable you minimally setup your deployment to Amazon Web Services by just running a couple of commands.



### Technology and Platforms Used

- [Packer](https://www.packer.io/docs/index.html) 
- [Ansible](https://docs.ansible.com/ansible/latest/index.html)
- [Terraform](https://www.terraform.io/docs/index.html)
- [AWS](aws.amazon.com)

### How to Build Amazon Machine Images (AMI) for your deployment

In the root directory, you would see a folder called `packer`, that is where the `json` file packer would use to create the machine image is.

In order to create a machine image on AWS, please do the following:
- export the AWS_ACCESS_KEY, AWS_SECRET_KEY & AWS_REGION in your terminal like this
  - `export AWS_ACCESS_KEY=<paste your aws access keys here>`
  - `export AWS_SECRET_KEY=<paste your secret keys here>`
  - `export AWS_REGION=<paste your region here i.e. eu-west-1>`

- After exporting the variables above, run the command `packer build packer/ubuntu_img.json` image build process.
  - After running the command you'll see the build flow on your terminal and you can also check your `AWS EC2 console` 
