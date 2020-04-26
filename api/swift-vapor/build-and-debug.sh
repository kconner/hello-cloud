#!/bin/bash -e

echo Rebuilding…
swift build --enable-test-discovery --sanitize=thread

existing_server_pid=$(pidof .build/debug/Run || true)
if [ -n "$existing_server_pid" ] ; then
    echo 'Prior server did not shut down when sent SIGINT. Sending SIGKILL…'
    kill -9 "$existing_server_pid"
fi

echo Serving.
.build/debug/Run serve --env development --hostname 0.0.0.0 --port 80
