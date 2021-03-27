#!/usr/bin/env bash
set -e

if [ "$1" = 'stubby' ]; then
    echo "$(stubby -V)"
    echo "$@"
    exec gosu stubby "$@"
fi

exec "$@"