#!/bin/bash

#Generate infra cert
openssl req -new -newkey rsa:4096 -sha256 -days 1825 -nodes -x509 -keyout krinfra.key -out krinfra.crt -config ./.conf/krhost.conf
if [  $? -eq 0 ]; then
    echo 'infra cert created.'
else
   exit 1
fi

#Create Pfx bundle
openssl pkcs12 -certpbe PBE-SHA1-3DES -keypbe PBE-SHA1-3DES -export -macalg sha1 -password pass:"vkr2024" -out krinfra.pfx -inkey krinfra.key -in krinfra.crt

# https://learn.microsoft.com/en-us/cli/azure/azure-cli-sp-tutorial-3
openssl pkcs12 -in krinfra.pfx -passin pass:"vkr2024" -passout pass:"vkr2024" -out krinfra.pem -nodes