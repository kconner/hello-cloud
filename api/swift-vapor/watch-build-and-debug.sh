#!/bin/bash

export ENTR_INOTIFY_WORKAROUND=1

read -r -d '' build_and_debug <<'EOF'
echo Rebuilding. \
    && swift build --enable-test-discovery -c debug -Xswiftc -g \
    && .build/debug/Run serve --env development --hostname 0.0.0.0 --port 80
EOF

while sleep 1 ; do
    find Sources | entr -dr sh -c "$build_and_debug"
done
