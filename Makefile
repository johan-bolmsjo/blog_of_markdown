.DEFAULT_GOAL := build

# Various custom tool used by this makefile
tool_html_of_md        := scripts/html_of_md.bash
tool_md_of_articles    := scripts/md_of_articles.bash
tool_md_of_posts       := scripts/md_of_posts.bash
tool_md_of_topic       := scripts/md_of_topic.bash
tool_md_of_frontpage   := scripts/md_of_frontpage.bash
tool_make_depend_meta  := scripts/make_depend_meta.bash
tool_unique_topics     := scripts/unique_topics.bash
tool_css_relative_path := scripts/css_relative_path.bash

# posts: md meta -> html
md_posts   := $(wildcard posts/*/*.md)
meta_posts := $(md_posts:%.md=%.meta)
html_posts := $(md_posts:%.md=%.html)

# articles: md meta -> html
md_articles   := $(wildcard articles/*/*.md)
meta_articles := $(md_articles:%.md=%.meta)
html_articles := $(md_articles:%.md=%.html)

# most is the scientific name for posts and articles
md_most   := $(md_posts) $(md_articles)
meta_most := $(md_most:%.md=%.meta)
html_most := $(md_most:%.md=%.html)

# Topics present in articles and posts
unique_topics := $(shell $(tool_unique_topics) $(meta_most))
md_topics     := $(unique_topics:%=topic_%.md)
html_topics   := $(md_topics:%.md=%.html)

# markdown files that are to be generated
out_md := index.md all_Articles.md all_Posts.md $(md_topics)

# html files that are to be generated
out_html := $(html_most) $(out_md:%.md=%.html)

# Rule for generating html from any article
articles/%.html: articles/%.md
	$(tool_html_of_md) `cat $(<:%.md=%.meta)` css_href=$(shell $(tool_css_relative_path) $@)/style.css div_class=\"numbering col1\" input=\"$<\" > $@

# Rule for generating html from any post
posts/%.html: posts/%.md
	$(tool_html_of_md) `cat $(<:%.md=%.meta)` css_href=$(shell $(tool_css_relative_path) $@)/style.css div_class=\"col1\" input=\"$<\" > $@

# Rule for generating topic docuement indexes
topic_%.md: $(meta_most)
	$(tool_md_of_topic) $* $(filter %.meta,$^) > $@

topic_%.html: topic_%.md
	$(tool_html_of_md) title=\"Topic: $*\" topics=\"$*\" div_class=\"col1 link_lists\" input=\"$<\" > $@

# Articles index
all_Articles.md: $(meta_articles)
	$(tool_md_of_articles) $(filter %.meta,$^) > $@

all_Articles.html: all_Articles.md
	$(tool_html_of_md) title=Articles div_class=\"col1 link_lists\" input=\"$<\" > $@

# Posts index
all_Posts.md: $(meta_posts)
	$(tool_md_of_posts) $(filter %.meta,$^) > $@

all_Posts.html: all_Posts.md
	$(tool_html_of_md) title=Posts div_class=\"col1 link_lists\" input=\"$<\" > $@

# Front page
index.md: $(meta_most)
	$(tool_md_of_frontpage) $(filter %.meta,$^) > $@

index.html: index.md
	$(tool_html_of_md) div_class=\"col1 link_lists\" input=\"$<\" > $@

.PHONY: build
build:	$(out_html)

# Force rebuild if scripts or makefiles change
$(out_html) $(out_md): $(wildcard scripts/*.bash) $(MAKEFILE_LIST)

.depend: $(meta_most)
	$(tool_make_depend_meta) $^ > $@

-include .depend
