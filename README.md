# RSSGen

RSS 2.0 generator for Common Lisp.

## Installation

This system can be installed from [UltraLisp](https://ultralisp.org/) like this:

```lisp
(ql-dist:install-dist "http://dist.ultralisp.org/"
                      :prompt nil)
(ql:quickload "rssgen")
```

## Usage

```common-lisp
(let ((items (list
              (rss-item "Title 1"
                        "https://example.org/blog/article-1"
                        "Desription of article 1")
              (rss-item "Title 2"
                        "https://example.org/blog/article-2"
                        "Desription of article 2"
                        ;;optional
                        :author "john-doe@example.org (John Doe)"
                        :category (rss-item-category "Category 1")
                        :comments "https://example.org/blog/article-2#comments"
                        :enclosure (rss-item-enclosure "https://example.org/example.jpg"
                                                       1024
                                                       "image/jpeg")
                        :guid (rss-item-guid "a2331318-82de-4ef2-9d08-00fbda09e015")
                        :pub-date "Sun, 19 May 2002 15:21:36 GMT"
                        :source (rss-item-source "https://example.org/rss-2.xml" "Second channel"))
              (rss-item "Title 3"
                        "https://example.org/blog/article-3"
                        "Desription of article 3"
                        :category (list (rss-item-category "Category 1" :domain "https://example.org/blog")
                                        (rss-item-category "Category 2"))
                        :pub-date (local-time:now)
                        :guid (rss-item-guid "https://example.org/a2331318" :perma t)))))

  (rssgen:rss "Site title" "https://example.org" "Site description"
              :items items
              ;; optional
              :language "en-us"
              :copyright "Copyright 2022, John Doe"
              :managing-editor "john-doe@example.org (John Doe)"
              :web-master "jane-doe@example.org (Jane Doe)"
              :pub-date "Sun, 19 May 2002 15:21:36 GMT"
              :last-build-date (local-time:now)
              :category (rss-category "News")
              :generator "rssgen"
              :docs "https://example.org/rss-specification"
              :ttl 60
              :rating "The PICS rating for the channel."
              :image (rss-image "https://example.org/logo.jpg"
                                "Logo title"
                                "https://example.org"
                                ;; optional
                                :width 100
                                :height 100
                                :description "Logo description")
              :skip-hours 23
              :skip-days (list "Saturday" "Sunday")))
```
