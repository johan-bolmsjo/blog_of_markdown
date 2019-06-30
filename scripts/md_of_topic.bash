#!/usr/bin/env bash
#
# Build markdown file with links to all posts and articles of a certain topic.
# Outputs markdown to stdout.
#
# arg1:    topic
# arg2..N: meta files
#
scriptdir="$(dirname $0)"
source "$scriptdir/site.bash"
source "$scriptdir/functions.bash"

if [ -z "$1" ]; then
    echoerr "usage: $0 topic meta-files..."
    exit 1
fi

topic=$1

posts=()
articles=()

for a in "$@"; do
    [[ "$a" =~ posts/.*meta$ ]] && posts+=("$a")
    [[ "$a" =~ articles/.*meta$ ]] && articles+=("$a")
done

echo "# ${site_name}"

md_posts=$("$scriptdir/md_of_doc_links_with_topic.bash" $topic ${posts[@]})
if [ ! -z "$md_posts" ]; then
    printf "\n## Posts: %s\n\n%s\n" $topic "$md_posts"
fi

md_articles=$("$scriptdir/md_of_doc_links_with_topic.bash" $topic ${articles[@]})
if [ ! -z "$md_articles" ]; then
    printf "\n## Articles: %s\n\n%s\n" $topic "$md_articles"
fi
