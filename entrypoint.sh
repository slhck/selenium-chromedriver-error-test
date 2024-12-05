#!/usr/bin/env bash

set -e

cd "$(dirname "$0")" || exit 1

Xvfb ":123" -ac -nolisten tcp -screen 0 1024x768x24 &
XVFB_PID=$!
# Wait for Xvfb
# https://unix.stackexchange.com/a/418903/5893
MAX_ATTEMPTS=60
COUNT=0
while ! xdpyinfo -display ":123" >/dev/null 2>&1; do
  sleep 1
  COUNT=$((COUNT + 1))
  if [ "${COUNT}" -ge "${MAX_ATTEMPTS}" ]; then
    echo "Gave up waiting for X server on :123"
    exit 1
  fi
done
echo "Xvfb is ready, running on :123 with PID ${XVFB_PID}"

sleep infinity
