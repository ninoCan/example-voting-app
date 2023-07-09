#!/bin/bash

cd integration || exit

echo "I: Creating environment to run  integration tests..."

docker compose build
docker compose up -d


echo "I: Launching Integration Test ..."

if docker compose run --rm integration /test/test.sh
then
  echo """
---------------------------------------
INTEGRATION TESTS PASSED.....
---------------------------------------
""" 
  docker compose down
  cd ..
  exit 0
else
  echo """
---------------------------------------
INTEGRATION TESTS FAILED.....
---------------------------------------
""" 
  docker compose down
  cd ..
  exit 1
fi
