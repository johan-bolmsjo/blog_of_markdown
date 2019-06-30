#!/usr/bin/env bash
#
# Create make dependencies for:
#
#   meta -> html
#   md   -> html
#
# The assumtion is that for a meta file, there is a markdown file (md) and a
# html file will be generated from both of them.
#
# arg1..N: meta files
#

for in_meta in "$@"; do
    out_html=${in_meta%.meta}.html
    in_md=${in_meta%.meta}.md
    
    echo "$out_html: $in_meta $in_md"
done
