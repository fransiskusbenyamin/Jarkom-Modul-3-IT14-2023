#!/bin/bash

curl -X POST -H "Content-Type: application/json" -d @login.json http://192.240.4.3:8000/api/auth/login > login_output.txt
token=$(cat login_output.txt | jq -r '.token')
ab -n 100 -c 10 -H "Authorization: Bearer $token" http://192.240.4.3:8000/api/me