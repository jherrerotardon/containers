#!/bin/bash

NAME=${1:-self}
CERTS=$(dirname $(realpath $0))/certs
PRIVATE_KEY=${CERTS}/${NAME}.key
CERTIFICATE=${CERTS}/${NAME}.crt
PEM=${CERTS}/${NAME}.pem
VALID_DAYS=365

echo -e '#######################################################################'
echo -e '\nMake sure that <Common Name> param matches with the domain of the site.\n'
echo -e '#######################################################################'
read -s -p "Press enter to continue"

openssl req -x509 -nodes -days ${VALID_DAYS} -newkey rsa:2048 -keyout ${PRIVATE_KEY} -out ${CERTIFICATE}
openssl dhparam -out ${PEM} 2048  # To Perfect forward secrecy.