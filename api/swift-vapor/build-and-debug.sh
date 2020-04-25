#!/bin/bash

read -r -d '' build_and_debug <<'EOF'
sleep 0.2 \
    && echo Rebuilding. \
    && swift build --enable-test-discovery -c debug -Xswiftc -g \
    && .build/debug/Run serve --env development --hostname 0.0.0.0 --port 80
EOF

while sleep 1 ; do
    find Sources -name '*.swift' | entr -dr bash -c "$build_and_debug"
done
