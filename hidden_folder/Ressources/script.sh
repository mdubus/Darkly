#!/bin/bash

ip='192.168.1.12'

wget -m -A README -pk -e robots=off  http://$ip/.hidden/
cd $ip/.hidden
grep -R -E '[0-9]{5,}' .
