#!/usr/bin/env bash
# Generate relative path to CSS directory given path to file that would include it.

for path in "$@"; do
    sed s,/,../,g <<< "${path//[^\/]}"css
done
