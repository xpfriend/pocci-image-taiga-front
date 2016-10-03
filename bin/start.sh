#!/bin/sh
set -e

source /taiga/bin/config.sh

while ! nc -z taigaback 8001; do
  sleep 1
done

nginx -g 'daemon off;'
