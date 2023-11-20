#!/bin/bash
apt-get update
apt-get install apache2-utils -y

echo '
{
  "username": "kelompokit14",
  "password": "passwordit14"
}' > register.json

ab -n 100 -c 10 -p register.json -T application/json http://192.240.4.1:8000/api/auth/register