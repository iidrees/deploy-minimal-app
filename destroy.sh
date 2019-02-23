#!/usr/bin/env bash

set -ex
set -o pipefail

function destroy_resources {
  
  PACKER_IMG=`egrep -oe 'ami-.{17}' packer_text.txt |tail -n1`
  echo ${PACKER_IMG}

  cd terraform/
  terraform destroy -var="access_key=${AWS_ACCESS_KEY}" -var="secret_key=${AWS_SECRET_KEY}" \
   -var="region=${AWS_REGION}"  -var="ami_image_id=${PACKER_IMG}" -auto-approve
}

function main {
  destroy_resources
}

main