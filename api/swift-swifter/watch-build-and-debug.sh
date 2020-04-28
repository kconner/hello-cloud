#!/bin/bash

export ENTR_INOTIFY_WORKAROUND=1

while sleep 1 ; do
    find Sources | entr -dr ./build-and-debug.sh
done
