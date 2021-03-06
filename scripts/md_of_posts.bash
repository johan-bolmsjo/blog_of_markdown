#!/usr/bin/env bash
#
# Build markdown file with links to all posts.
# Outputs markdown to stdout.
#
# arg1..N: meta files
#
scriptdir="$(dirname $0)"
source "$scriptdir/site.bash"
source "$scriptdir/functions.bash"

cat <<EOF
# ${site_name}

## Posts

EOF

exec "$scriptdir/md_of_doc_links.bash" "$@"
