#!/bin/bash
source ./variables.sh

function CopyOrDeleteFile(){
  shouldCopy=$1
  CERT_COPY_PATH=$3
  CERT_PATH=$2
  if [ $shouldCopy == false ]; then
    if [ -e "$CERT_COPY_PATH" ]; then
        echo "File exists. Deleting file..."
        rm $CERT_COPY_PATH
    else
        echo "File does not exist."
    fi
    exit 0
  fi

  echo "cert path $CERT_PATH :::: copy path $CERT_COPY_PATH"
  cp "$CERT_PATH" "$CERT_COPY_PATH"

    if [  $? -eq 0 ]; then
        echo 'Copy pem completed.'
        ls "./$CERT_COPY_PATH"
    else
      exit 1
    fi
}

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
    -var="AZ_CERT_PASSWORD=${AZ_CERT_PASSWORD}" \
    -var="CREATE_CLUSTER=${CREATE_CLUSTER}" \
    -var="CREATE_VAULT=${CREATE_VAULT}"

   
    echo "$KR_PLAN created"
    # if [ $create == 'true' ]  ; then
        terraform apply -input=false -auto-approve ${KR_PLAN}
        terraform show
    # fi 
}

#copy execution cert in resource finder directory
CopyOrDeleteFile true "./.cert/krinfra.pem" "./src/module/host/core/resource/script/krinfra.pem" 
cd ./src
terraform init

#Validate plan document
terraform fmt
terraform validate

# if [ -n "$KR_DEPLOY_TO" ]; then
	echo "Deployment started: $KR_DEPLOY_TO"
    init_workspace $KR_DEPLOY_TO
    create_plan $KR_DEPLOY_TO
# fi

CopyOrDeleteFile false "" "./src/module/host/core/resource/script/krinfra.pem"



