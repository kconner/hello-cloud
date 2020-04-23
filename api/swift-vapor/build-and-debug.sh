#!/bin/bash -e

swift build --enable-test-discovery -c debug -Xswiftc -g
.build/debug/Run serve --env development --hostname 0.0.0.0 --port 80
