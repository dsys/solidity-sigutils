#!/bin/bash

set -e

ganache-cli --port 9545 > /dev/null &
sleep 5 # to make sure ganache-cli is up and running before compiling
rm -rf build
yarn migrate
yarn test
kill -9 $(lsof -t -i:9545)
