#!/usr/bin/env bash
#
# Build a markdown list of links to documents.
# Outputs list sorted by publish or revision date to stdout.
#
# arg1..N: meta files
#
scriptdir="$(dirname $0)"
source "$scriptdir/functions.bash"

output=$(for meta in "$@"; do
    title=""
    published=""
    source "$meta"
    if [ -z "$title" ]; then
	echoerr "${meta}: title is required"
	exit 1
    fi
    if [ -z "$published" ]; then
	echoerr "${meta}: published date is required"
	exit 1
    fi
    echo "* [${published}: $(html_escape "$title")](${meta%.meta}.html)"
done); ec=$?

if [ $ec != 0 ]; then
    exit $ec
fi

printf "%s" "$output" | sort -t : -k2,2 | sort -s -r -t : -k1,1
