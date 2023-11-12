(defpackage rssgen
  (:use #:cl #:cl-who #:alexandria)
  (:export #:rss
           #:rss-item
           #:rss-image
           #:rss-category
           #:rss-text-input
           #:rss-item-category
           #:rss-item-enclosure
           #:rss-item-source
           #:rss-item-guid))
