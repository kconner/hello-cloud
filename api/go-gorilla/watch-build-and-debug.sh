#!/bin/sh

export ENTR_INOTIFY_WORKAROUND=1

read -r -d '' build_and_debug <<'EOF'
echo Rebuilding… \
    && go build -o /build/app \
    && echo Serving. \
    && /build/app
EOF

while sleep 1 ; do
    find . | entr -dr sh -c "$build_and_debug"
done
