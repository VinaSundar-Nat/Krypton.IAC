#!/bin/bash
source ./variables.sh

function init_workspace(){
   EXISTING_SPACES=$(terraform workspace list)

    if echo "$EXISTING_SPACES" | grep -wq "$1"; then
        echo "Workspace $1 exists."
    else
        terraform workspace new $1
    fi  
}

function create_plan(){
    
    localdt=$(date +'%m_%d_%Y')
    KR_PLAN="kr_ops_${1}_${localdt}.tfplan"

    terraform plan -out=${KR_PLAN} -lock=false -detailed-exitcode \
    -var="AZ_SUBSCRIPTION=${AZ_SUBSCRIPTION}" -var="AZ_CERT_PATH=${AZ_CERT_PATH}" \
    -var="AZ_TENNENT_ID=${AZ_TENNENT_ID}" -var="AZ_CLIENT_ID=${AZ_CLIENT_ID}" \
    -var="AZ_CERT_PASSWORD=${AZ_CERT_PASSWORD}"
    echo "$KR_PLAN created"
    # if [ $create == 'true' ]  ; then
        terraform apply -input=false -auto-approve ${KR_PLAN}
        terraform show
    # fi 
}

cd ./src
terraform init

#Validate plan document
terraform fmt
terraform validate

if [ -n "$KR_DEPLOY_TO" ]; then
	echo "Deployment started: $KR_DEPLOY_TO"
    init_workspace $KR_DEPLOY_TO
    create_plan $KR_DEPLOY_TO
fi



