#!/bin/bash
function writeToFile(){
appId=$1
spId=$2

rm $file

outputJson="{
"appId": $appId,
"spId":  $spId
}"

cat <<EOF > "$file"
{
  "appId": "$appId",
  "spId": "$spId"
}
EOF
}

appName=$4
file=$5
log=$6

az login --service-principal \
    --username  $1 \
    --tenant $2 \
    -p $3
    
echo "Login sucessful for client: $1 tenant : $2" >> $log 

app_id=$(az ad app list --filter "displayName eq '${appName}'" --query "[0].appId" -o tsv)

if [ -z "$app_id" ]; then
  echo "Application does not exist for : $appName" >> $log 
  writeToFile "xxxx" "xxxx" $file
  az logout
  exit 0
else
  echo "$appName identified - id $app_id" >> $log 
fi


sp_id=$(az ad sp list --filter "appId eq '${app_id}' and servicePrincipalType eq 'Application'" --query "[0].id" -o tsv)

if [ -z "$sp_id" ]; then
  echo "No Service Principal found for the AppId: $app_id" >> $log 
  writeToFile $app_id "xxxx" $file
  az logout
  exit 0
else
  echo "Service Principal ID: $sp_id" >> $log 
fi

writeToFile $app_id $sp_id $file
az logout

