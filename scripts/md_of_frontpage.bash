#!/usr/bin/env bash
#
# Build markdown file of front page.
# Outputs markdown to stdout.
#
# arg1..N: meta files
#
scriptdir="$(dirname $0)"
source "$scriptdir/site.bash"
source "$scriptdir/functions.bash"

posts=()
articles=()

for a in "$@"; do
    [[ "$a" =~ posts/.*meta$ ]] && posts+=("$a")
    [[ "$a" =~ articles/.*meta$ ]] && articles+=("$a")
done

printf "# %s\n\n%s\n" "$site_name" "$site_abstract"

md_posts=$("$scriptdir/md_of_doc_links.bash" ${posts[@]} | head -5)
if [ ! -z "$md_posts" ]; then
    printf "\n## Posts\n\n%s\n" "$md_posts"
    echo '* [Archive](all_Posts.html)'
fi

md_articles=$("$scriptdir/md_of_doc_links.bash" ${articles[@]} | head -5)
if [ ! -z "$md_articles" ]; then
    printf "\n## Articles\n\n%s\n" "$md_articles"
    echo '* [Archive](all_Articles.html)'
fi

topics=$("$scriptdir/unique_topics.bash" "$@")
if [ ! -z "$topics" ]; then
    printf "\n## Topics\n\n"
    for topic in $topics; do
	echo "[$topic](topic_${topic}.html)"
    done
    echo
fi
