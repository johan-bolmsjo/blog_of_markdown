#!/usr/bin/env bash
#
# Convert markdown to html.
#
# Required non-standard tools:
#   blackfriday-tool
#   html_escape (source in this repo)
#
# Accepts the following parameters on the command line:
#
#   input=...         Input document (must be markdown with .md extension)
#   title=...         Document title
#   lang=...          HTML language (default: "en")
#   css_href=...      Relative path to style sheet (default: "css/style.css")
#   div_class=...     CSS classes to use for text (default: "article text_margins")
#   published=...     Published date (default" none)
#   revised=...       Revised date (default: none)
#
# Outputs html to stdout.
#
scriptdir="$(dirname $0)"
source "$scriptdir/site.bash"
source "$scriptdir/functions.bash"

# Accept parameters using shell script variable assignment notation.
eval "$@"

if [ -z "$input" ]; then
    echoerr "input variable missing!"
    exit 1
fi

if [ ! -f "$input" ]; then
    echoerr "no such file: $input"
    exit 1
fi

html_title="$site_name"
if [ ! -z "$title" ]; then
    html_title="${html_title}: $(html_escape "$title")"
fi

if [ -z "$lang" ]; then
    lang=$site_lang
fi

if [ -z "$css_href" ]; then
    css_href="css/style.css"
fi

if [ -z "$div_class" ]; then
    div_class="article text_margins"
fi

html_keywords=""
if [ ! -z "$topics" ]; then
    for topic in $topics; do
	html_keywords="${html_keywords:+$html_keywords,}$topic"
    done
fi

cat <<EOF
<!DOCTYPE html>
<html lang="$lang">
<head>
<meta charset="UTF-8">
<meta name="keywords" content="$html_keywords">
<meta name="viewport" content="width=device-width, initial-scale=0.8">
<title>${html_title}</title>
<link rel="stylesheet" href="${css_href}">
</head>
<body>
EOF

cat <<EOF
<div class="${div_class}">
EOF

blackfriday-tool $input

if [ "x${published}${revised}" != x ]; then
    if [ ! -z "$published" ]; then
	html_published="Published: ${published}<br>"
    fi
    if [ ! -z "$revised" ]; then
	html_revised="Revised: ${revised}"
    fi
    cat <<EOF
<hr width="30%" align="left">
<p>
${html_published}
${html_revised}
</p>
EOF
fi

cat <<EOF
</div>
</body>
</html>
EOF
