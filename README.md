# Blog of Markdown

Static web site built from Markdown documents using shell,
[make](https://www.gnu.org/software/make/) and some other command line tools.
Running `make` in the repository root should update all HTML from Markdown
documents.

The typical workflow is to store everything in [Git](https://git-scm.com/) and
push it to a web server when documents has been updated. Since everything is
static HTML it's very easy to review locally.

The blog has support for posts which are supposed to be authored once and
articles which can be revised at any time; the difference is by convention only
really. One Markdown document and (small) meta file is maintained per post or
article. See `posts/2019-06-30/...` in the
[software repository](https://github.com/johan-bolmsjo/blog_of_markdown) for an
example.

## Required Tools

Install the following tools first. Both tools requires a working
[Go](http://golang.org) installation.

### html_escape

    cd src/html_escape
    go build
    mv html_escape ~/.local/bin # Or other location in your path

### blackfriday-tool

Markdown to html converter.

    go get github.com/russross/blackfriday-tool
