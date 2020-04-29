#!/bin/bash

echo Rebuilding…
swift build --enable-test-discovery --sanitize=thread

# Look for an existing server process and kill it if it's running.
# Vapor does not always seem to get terminated in response to SIGTERM.
existing_server_pid=$(pidof .build/debug/Run)
if [ -n "$existing_server_pid" ] ; then
    echo 'Prior server did not shut down. Killing it.'
    kill -KILL "$existing_server_pid"
fi

handleTerminate() { 
  echo 'Terminating…' 
  kill -TERM "$server_pid" 2>/dev/null
}

trap handleTerminate SIGTERM

echo Serving.
.build/debug/Run serve --env development --hostname 0.0.0.0 --port 80 &
server_pid=$! 
wait "$server_pid"
