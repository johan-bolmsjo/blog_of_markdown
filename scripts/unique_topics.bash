#!/usr/bin/env bash
#
# Outputs all unique topics found in meta files to stdout.
#
# arg1..N: meta files
#
for meta in "$@"; do
    topics=""
    source "$meta"
    for topic in $topics; do
	echo $topic
    done
done | sort | uniq
