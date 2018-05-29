#!/bin/bash

set -e

yarn start 2> /dev/null 1> /dev/null &
sleep 5 # to make sure ganache-cli is up and running before compiling
rm -rf build
yarn compile
yarn migrate
yarn test
kill -9 $(lsof -t -i:9545)
