#!/bin/bash

set -e

docker build -t selenium-test . --progress=plain

# if container already exists, remove it
docker stop selenium-test || true
docker rm -f selenium-test || true

# run container in background
docker run -d --name selenium-test selenium-test

# wait until container is ready
while ! docker exec -it selenium-test /bin/bash -c "exit" >/dev/null 2>&1; do
  sleep 1
done

# run the failing command
docker exec --user seleniumtest -it selenium-test /bin/bash -c "DISPLAY=:123 NODE_PATH=/usr/lib/node_modules node selenium_test.js"
