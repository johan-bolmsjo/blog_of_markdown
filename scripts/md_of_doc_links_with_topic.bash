#!/usr/bin/env bash
#
# Build a markdown list of links to documents containing a specific topic.
# Outputs list sorted by publish or revision date to stdout.
#
# arg1:    topic
# arg2..N: meta files
#
scriptdir="$(dirname $0)"
source "$scriptdir/functions.bash"

if [ -z "$1" ]; then
    echoerr "usage: $0 topic meta-files..."
    exit 1
fi

search_topic="$1"
shift

output=$(for meta in "$@"; do
    topics=""
    title=""
    published=""
    revised=""
    source "$meta"
    for topic in $topics; do
	if [ "$search_topic" = "$topic" ]; then
	    if [ -z "$title" ]; then
		echoerr "${meta}: title is required"
		exit 1
	    fi
	    if [ x"${published}${revised}" = x ]; then
		echoerr "${meta}: published or revised date is required"
		exit 1
	    fi
	    if [ -z "$revised" ]; then
		revised="$published"
	    fi
	    echo "* [${revised}: $(html_escape "$title")](${meta%.meta}.html)"
	    break
	fi
    done
done); ec=$?

if [ $ec != 0 ]; then
    exit $ec
fi

printf "%s" "$output" | sort -t : -k2,2 | sort -s -r -t : -k1,1
