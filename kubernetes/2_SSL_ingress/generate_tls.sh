#!/bin/bash

openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -subj '/O=istio demo ./CN=$1' -keyout $1.key -out $1.crt

openssl req -out $2.$1.csr -newkey rsa:2048 -nodes -keyout $2.$1.key -subj "/CN=$2.$1/O=$2 subdomain od $1 for istio demo"

openssl x509 -req -days 365 -CA $1.crt -CAkey $1.key -set_serial 0 -in $2.$1.csr -out $2.$1.crt
