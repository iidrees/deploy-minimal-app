#!/usr/bin/env bash

set -ex
set -o pipefail

# Build packer image
function build_packer_image {
  echo "<<<<<<<<<<<<<<<<<<<<<<<<< Building Packer Image >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  cd packer/
  
  packer build ubuntu_image.json | tee ../packer_text.txt

  echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< AMI Build Done >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
}

# Run terraform deployment
function deploy_to_aws {
  echo "<<<<<<<<<<<<<<<<<<<<<< Start Terraform Deployment >>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  cd ../

  PACKER_IMG=$(egrep -oe 'ami-.{17}' packer_text.txt |tail -n1)
  echo ${PACKER_IMG}

  cd terraform/ 
  terraform apply -var="access_key=${AWS_ACCESS_KEY}" -var="secret_key=${AWS_SECRET_KEY}" \
   -var="region=${AWS_REGION}"  -var="ami_image_id=${PACKER_IMG}" -auto-approve
  echo "<<<<<<<<<<<<<<<<<<<<<<<<< Terraform Deployment Done >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
}

function main {
  build_packer_image
  deploy_to_aws
}

main