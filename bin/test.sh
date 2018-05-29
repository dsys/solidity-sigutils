#!/bin/bash

set -e

ganache-cli --gasLimit 10000000 --port 9545 &
sleep 5 # to make sure ganache-cli is up and running before compiling
rm -rf build
yarn compile
yarn migrate
yarn test
kill -9 $(lsof -t -i:9545)
